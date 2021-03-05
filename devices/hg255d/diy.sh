#!/bin/bash
cp -rf devices/hg255d/index.html feeds/luci/modules/luci-base/root/www/index.html
cp -rf devices/hg255d/nginx package/base-files/files/etc
cp -rf devices/hg255d/nginx.conf feeds/packages/net/nginx/files-luci-support/luci_nginx.conf
cp -rf devices/hg255d/settings.sh package/base-files/files/etc
cp -rf devices/hg255d/config_generate package/base-files/files/bin
