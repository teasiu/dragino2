#/bin/bash
echo
echo
echo "本脚本仅适用于在Ubuntu环境下编译 https://github.com/garypang13/Actions-OpenWrt"
echo
echo
sleep 2s
#sudo apt-get update
#sudo apt-get upgrade

#sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3 python2.7 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs gcc-multilib g++-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler ccache xsltproc rename antlr3 gperf curl screen



clear 
echo
echo 
echo 
echo "|*******************************************|"
echo "|                                           |"
echo "|                                           |"
echo "|           基本环境部署完成......          |"
echo "|                                           |"
echo "|                                           |"
echo "|*******************************************|"
echo
echo


if [ "$USER" == "root" ]; then
	echo
	echo
	echo "请勿使用root用户编译，换一个普通用户吧~~"
	sleep 3s
	exit 0
fi

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



if [ -d $firmware ]; then
echo "发现有openwrt文件夹"
read -p "是否删除？yes or no: " dddd
[ $dddd == "yes" ] && rm -rf $firmware > /dev/null
fi
git clone -b v19.07.7 --depth 1 https://gitee.com/teasiu/openwrt.git $firmware
chmod -R 755 devices > /dev/null
cp -rf devices $firmware/devices
cd $firmware
if [ -d ../dl ]; then
ln -s ../dl dl
fi
cp -rf devices/common/feeds.conf.default feeds.conf.default
./scripts/feeds update -a
./scripts/feeds install -a
cp -rf devices/common/diy/package/* package
cp devices/$firmware/.config .config
if [ -f "devices/common/diy.sh" ]; then
	chmod +x devices/common/diy.sh
	/bin/bash "devices/common/diy.sh"
fi
if [ -f "devices/$firmware/diy.sh" ]; then
	chmod +x devices/$firmware/diy.sh
	/bin/bash "devices/$firmware/diy.sh"
fi
./scripts/feeds install -a
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
echo
echo "                      *****5秒后开始编译*****

1.你可以随时按Ctrl+C停止编译

3.大陆用户编译前请准备好梯子,使用大陆白名单或全局模式"
echo
echo
echo
sleep 5s

make -j5

