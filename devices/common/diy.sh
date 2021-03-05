#!/bin/bash
#=================================================
#mkdir package/network/config/firewall/patches
#wget -O package/network/config/firewall/patches/fullconenat.patch https://raw.fastgit.org/coolsnowwolf/lede/master/package/network/config/firewall/patches/fullconenat.patch
sed -i "s/auto/zh_cn/g" feeds/luci/modules/luci-base/root/etc/config/luci
sed -i "s/16384/65536/g" package/kernel/linux/files/sysctl-nf-conntrack.conf
#find package target -name inittab | xargs -i sed -i "s/askfirst/respawn/g" {}
date=`date +%m.%d.%Y`
sed -i "s/DISTRIB_DESCRIPTION.*/DISTRIB_DESCRIPTION='%D %V %C by teasiu'/g" package/base-files/files/etc/openwrt_release
sed -i "s/# REVISION:=x/REVISION:= $date/g" include/version.mk
webuitimeout=`cat package/feeds/packages/uwsgi/files-luci-support/luci-webui.ini | grep "cgi-timeout"`
if [ ! "$webuitimeout" ]; then
	sed -i '$a cgi-timeout = 300' package/feeds/packages/uwsgi/files-luci-support/luci-webui.ini
fi
cp -rf devices/common/php.ini feeds/packages/lang/php7/files/php.ini
cp -rf devices/common/Makefile.tr feeds/packages/net/transmission-web-control/Makefile
rm -rf feeds/packages/net/transmission-web-control/patches
cp -rf devices/common/transmission.config feeds/packages/net/transmission/files
cp -a devices/common/download.pl scripts

