#
# Copyright (C) 2008-2014 The LuCI Team <luci@lists.subsignal.org>
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=luci-app-blog
LUCI_DEPENDS:=+php7 +php7-cgi +php7-mod-ctype +php7-mod-hash +php7-mod-pdo +php7-mod-pdo-sqlite +php7-mod-session +php7-mod-sqlite3 +php7-mod-tokenizer +php7-mod-xml +php7-mod-xmlreader +php7-mod-xmlwriter +zoneinfo-core +zoneinfo-asia
LUCI_PKGARCH:=all
PKG_NAME:=luci-app-blog

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
