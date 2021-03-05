#!/bin/bash
if [ ! -f "package/teasiu/luci-app-admconf/root/www/openwrtdl" ]; then
	ln -s /mnt/sda1/openwrtdl package/teasiu/luci-app-admconf/root/www/openwrtdl
fi
cp -rf devices/newifi-d2/index.html feeds/luci/modules/luci-base/root/www/index.html
cp -rf devices/newifi-d2/slitaz-background.jpg feeds/luci/modules/luci-base/root/www/slitaz-background.jpg
cp -rf devices/newifi-d2/favicon.ico feeds/luci/modules/luci-base/root/www/favicon.ico
if [ ! -f "package/teasiu/luci-app-admconf/root/www/ipxenetboot" ]; then
	ln -s /mnt/sda1/ipxenetboot package/teasiu/luci-app-admconf/root/www/ipxenetboot
fi
rm -Rf package/teasiu/luci-app-admconf/root/www/tftp
ln -s /mnt/sda1/tftp package/teasiu/luci-app-admconf/root/www/tftp
cp -rf devices/newifi-d2/nginx package/base-files/files/etc
cp -rf devices/newifi-d2/nginx.conf feeds/packages/net/nginx/files-luci-support/luci_nginx.conf
cp -rf devices/newifi-d2/settings.sh package/base-files/files/etc
cp -rf devices/newifi-d2/config_generate package/base-files/files/bin
cp -rf devices/newifi-d2/samba.config package/network/services/samba36/files
cp -rf devices/newifi-d2/manual-tracker-add.sh package/base-files/files/etc
cp -rf devices/newifi-d2/102-mt7621-fix-cpu-clk-add-clkdev.patch target/linux/ramips/patches-4.14/
