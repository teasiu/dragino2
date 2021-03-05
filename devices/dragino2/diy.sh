#!/bin/bash
rm -Rf package/teasiu/luci-app-admconf/root/www/tftp
ln -s /mnt/sda1/tftp package/teasiu/luci-app-admconf/root/www/tftp
cp -rf devices/dragino2/index.html feeds/luci/modules/luci-base/root/www/index.html
cp -rf devices/dragino2/nginx package/base-files/files/etc
cp -rf devices/dragino2/nginx.conf feeds/packages/net/nginx/files-luci-support/luci_nginx.conf
cp -rf devices/dragino2/settings.sh package/base-files/files/etc
cp -rf devices/dragino2/config_generate package/base-files/files/bin
