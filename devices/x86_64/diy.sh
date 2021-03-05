#!/bin/bash
cp -rf devices/x86_64/index.html feeds/luci/modules/luci-base/root/www/index.html
cp -rf devices/x86_64/slitaz-background.jpg feeds/luci/modules/luci-base/root/www/slitaz-background.jpg
cp -rf devices/x86_64/favicon.ico feeds/luci/modules/luci-base/root/www/favicon.ico
cp -rf devices/x86_64/nginx package/base-files/files/etc
cp -rf devices/x86_64/nginx.conf feeds/packages/net/nginx/files-luci-support/luci_nginx.conf
cp -rf devices/x86_64/settings.sh package/base-files/files/etc
cp -rf devices/x86_64/config_generate package/base-files/files/bin
cp -rf devices/x86_64/manual-tracker-add.sh package/base-files/files/etc
