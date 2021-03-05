#!/bin/sh
if [ ! -f "/etc/crontabs/root" ]; then
	echo "未找到计划任务，文档建立中"
	touch /etc/crontabs/root
else
	echo "计划任务文档已存在"
fi
if [ -f "/etc/ddns_oray.sh" ]; then
	echo "计划任务的ddns已存在"
else
	echo "ddns计划任务建立中"
	if [ -f "/mnt/sda1/myddns/ddns_oray.sh" ]; then
	cp -a /mnt/sda1/myddns/ddns_oray.sh /etc
	chmod +x /etc/ddns_oray.sh
	echo "#*/10 * * * * sh /etc/ddns_oray.sh >ddns.log" >> /etc/crontabs/root
	fi
	if [ -f "/mnt/sda1/myddns/aliddns.sh" ]; then
	cp -a /mnt/sda1/myddns/aliddns.sh /etc
	chmod +x /etc/aliddns.sh
	fi
	if [ -f "/mnt/sda1/myddns/aliddnsgo.sh" ]; then
	cp -a /mnt/sda1/myddns/aliddnsgo.sh /etc
	chmod +x /etc/aliddnsgo.sh
	echo "#*/25 * * * * sh /etc/aliddnsgo.sh >ali.log" >> /etc/crontabs/root
	fi
	if [ -f "/mnt/sda1/myddns/aliddnsgo1.sh" ]; then
	cp -a /mnt/sda1/myddns/aliddnsgo1.sh /etc
	chmod +x /etc/aliddnsgo1.sh
	echo "#*/30 * * * * sh /etc/aliddnsgo1.sh >ali.log" >> /etc/crontabs/root
	fi
	if [ -d "/mnt/sda1/myddns/client-mode" ]; then
	cp -rf /mnt/sda1/myddns/client-mode /etc
	echo "#*/35 * * * * bash /etc/client-mode/client.sh" >> /etc/crontabs/root
	fi
fi
oldfeeds=`cat /etc/opkg/distfeeds.conf | grep downloads.openwrt.org`
if [ "$oldfeeds" == "" ]; then
	echo "软件包国内源已配置"
else
	echo "软件包国内源配置中"
	sed -i 's_downloads.openwrt.org_mirrors.ustc.edu.cn/openwrt_' /etc/opkg/distfeeds.conf
fi
exit 0
