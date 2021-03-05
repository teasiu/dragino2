#/bin/bash
echo
echo
echo "本脚本仅适用于在Ubuntu环境下编译 https://github.com/garypang13/Actions-OpenWrt"
echo
echo

if [ "$USER" == "root" ]; then
	echo
	echo
	echo "请勿使用root用户编译，换一个普通用户吧~~"
	sleep 3s
	exit 0
fi

echo
echo "

1. X86_64

2. newifi-d2

3. dragino2

4. hg255d

5. Exit

"

while :; do

read -p "你想要编译哪个固件？ " CHOOSE

case $CHOOSE in
	1)
		firmware="x86_64"
	break
	;;
	2)
		firmware="newifi-d2"
	break
	;;
	3)
		firmware="dragino2"
	break
	;;
	4)
		firmware="hg255d"
	break
	;;
	5)	exit 0
	;;

esac
done

echo

clear
rm -Rf $firmware/devices
chmod -R 755 devices > /dev/null
cp -rf devices $firmware/devices
cd $firmware
cp -rf devices/common/feeds.conf.default feeds.conf.default
make clean
rm .config .config.old
rm -rf tmp
git fetch --all
./scripts/feeds update -a
rm -Rf package/teasiu
cp -rf devices/common/diy/package/* package
if [ -f "devices/common/diy.sh" ]; then
	chmod +x devices/common/diy.sh
	/bin/bash "devices/common/diy.sh"
fi
if [ -f "devices/$firmware/diy.sh" ]; then
	chmod +x devices/$firmware/diy.sh
	/bin/bash "devices/$firmware/diy.sh"
fi
./scripts/feeds install -a
cp devices/$firmware/.config .config
read -p "是否增删插件? [y/N]: " YN
case ${YN:-N} in
	[Yy])
		make menuconfig
	echo ""
	;;
	[Nn]) 
	make defconfig
	;;
esac

echo
echo
echo "                      *****5秒后开始编译*****

1.你可以随时按Ctrl+C停止编译

3.大陆用户编译前请准备好梯子,使用大陆白名单或全局模式"
echo
echo
sleep 5s

make -j5
