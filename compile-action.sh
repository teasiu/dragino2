#/bin/bash
git clone -b v19.07.7 --depth 1 https://gitee.com/teasiu/openwrt.git
chmod -R 755 devices > /dev/null
cp -rf devices openwrt/devices
cd openwrt
cp -rf devices/common/feeds.conf.default feeds.conf.default
./scripts/feeds update -a
./scripts/feeds install -a
cp -rf devices/common/diy/package/* package
cp devices/dragino2/.config .config
if [ -f "devices/common/diy.sh" ]; then
	chmod +x devices/common/diy.sh
	/bin/bash "devices/common/diy.sh"
fi
if [ -f "devices/dragino2/diy.sh" ]; then
	chmod +x devices/dragino2/diy.sh
	/bin/bash "devices/dragino2/diy.sh"
fi
./scripts/feeds install -a
make defconfig
make -j9

