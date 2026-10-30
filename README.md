# Тропа

Android-клиент для VPN-подписок (VLESS / Reality, VMess, Trojan, Shadowsocks, Hysteria2).
Работает с подписками, которые провайдеры выдают для Happ и INCY, Clash/mihomo и v2rayNG.

Здесь только готовые сборки. Скачать — в разделе [Releases](https://github.com/nvsbunny/tropa-releases/releases/latest):
`Tropa-<версия>-arm64-v8a.apk` — для телефонов, `x86_64` — для эмуляторов.

## Что умеет
- Подписки по ссылке, в том числе Xray JSON (как у Happ) — конфиги провайдера уходят ядру как есть.
- Выбор сервера «как у провайдера» или самой Тропой — по отклику и по проверке сервисов (Google, YouTube, Telegram, WhatsApp, Claude).
- Серверы для обхода белых списков (LTE) — только на мобильном интернете и с учётом оператора; лимит LTE на экране.
- Маршруты: всё через VPN / российские сайты напрямую / только заблокированное / как у провайдера; приложения и свои сайты мимо VPN.
- Виджеты, плитка в шторке, уведомление «Подключено» отключается.
- Android TV: экран под пульт, подписки передаются с телефона по QR-коду через домашнюю сеть (зашифровано, без чужих серверов).
- Автообновление из этого репозитория: SHA-256 и ключ подписи сверяются перед установкой.
- Для опытных: root-режим без VPN — TPROXY и iptables (Magisk, KernelSU); второе ядро mihomo.

## Приватность
- Нет трекеров, рекламы и сбора статистики: в APK нет Google Play services, Firebase, Crashlytics, AppMetrica и подобного.
- Нет открытых локальных прокси (через них другие приложения могли бы узнать адрес сервера).
- В сеть Тропа ходит только к вашим подпискам и серверам и на GitHub — проверить, вышла ли новая версия.

## Установка
Android 9 и новее. При установке не из Play Маркета Google Play Защита предупредит о неизвестном приложении:
«Подробнее» → «Всё равно установить». Дальше Тропа обновляется сама.

## Сторонние компоненты
| Компонент | Лицензия | Исходники |
|---|---|---|
| Xray-core 26.10.29 (официальная сборка) | MPL-2.0 | https://github.com/XTLS/Xray-core |
| mihomo 1.19.33 с правкой из [`mihomo/`](mihomo) | GPL-3.0 | https://github.com/MetaCubeX/mihomo/tree/v1.19.33 + [`mihomo-android-nonroot.patch`](mihomo/mihomo-android-nonroot.patch), сборка — [`build-mihomo.sh`](mihomo/build-mihomo.sh) |
| geosite.dat / geoip.dat | — | из того же релиза Xray-core |
| Списки блокировок | — | https://github.com/itdoginfo/allow-domains |
| Шрифт Onest | SIL OFL 1.1 | https://fonts.google.com/specimen/Onest |
| Jetpack Compose, Glance, ZXing core, SnakeYAML | Apache-2.0 | |

Правка mihomo: обычная Android-сборка mihomo без root не поднимает TUN (пытается прочитать
`/data/system/packages.xml`); правка делает эту ошибку нефатальной.
