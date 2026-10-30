#!/usr/bin/env bash
# Необязательное второе ядро для режима «Для опытных» — mihomo.
# Собирает его из официальных исходников с одной правкой: mihomo-android-nonroot.patch (лежит рядом).
# Без неё Android-сборка mihomo пытается прочитать /data/system/packages.xml, приложению
# без root это запрещено, и TUN не поднимается.
#
# Нужны Go (https://go.dev/dl/) и git. Результат — в ./out вместе с SHA256SUMS.
set -euo pipefail

VERSION="v1.19.33"
HERE="$(cd "$(dirname "$0")" && pwd)"
OUT="$HERE/out"
WORK="${WORK:-$(mktemp -d)}"

mkdir -p "$OUT"
git clone -q --depth 1 --branch "$VERSION" https://github.com/MetaCubeX/mihomo.git "$WORK/mihomo"
cd "$WORK/mihomo"
git apply "$HERE/mihomo-android-nonroot.patch"

export CGO_ENABLED=0
LDFLAGS="-X github.com/metacubex/mihomo/constant.Version=$VERSION-tropa -w -s -buildid="
# Телефоны: настоящая Android-сборка.
GOOS=android GOARCH=arm64 go build -tags with_gvisor -trimpath -ldflags "$LDFLAGS" -o "$OUT/mihomo-android-arm64" .
# Эмулятор x86_64: android/amd64 без NDK не собрать, статическая Linux-сборка на ядре Android запускается так же.
GOOS=linux GOARCH=amd64 go build -tags with_gvisor -trimpath -ldflags "$LDFLAGS" -o "$OUT/mihomo-android-amd64" .

cd "$OUT"
sha256sum mihomo-android-arm64 mihomo-android-amd64 > SHA256SUMS
cat SHA256SUMS
