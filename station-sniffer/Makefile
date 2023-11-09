#
# Copyright (C) 2022, 2023 Tucker Polomik (tpolomik@cablelabs.com tuckerpo@buffalo.edu)
#

include $(TOPDIR)/rules.mk

PKG_NAME:=station-sniffer
PKG_VERSION:=2023-10-26
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/prplmesh/stationsniffer.git
PKG_SOURCE_VERSION:=a1139ea609129ed75557a6be8de4d6fc1099f3a8
PKG_MIRROR_HASH:=1ee803d870e74d8ec53127137d24730dda148f6760be94c0316358d5506dd3cd

PKG_MAINTAINER:=Tucker Polomik <t.polomik@cablelabs.com tuckerpo@buffalo.edu>
PKG_LICENSE:=BSD-2-Clause
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/station-sniffer
	SECTION:=net
	CATEGORY:=prpl Foundation
	SUBMENU:=prplMesh
	TITLE:=station-sniffer
	DEPENDS:= \
		+libpcap \
		+libradiotap \
		+libstdcpp \
		+libpthread \
		+libnl
endef

define Package/station-sniffer/description
	A userspace application to capture and parse radiotap headers using libpcap for packet capture and libradiotap for radiotap parsing.
	Serves parsed radiotap data over Unix sockets.
endef

define Package/station-sniffer/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/$(PKG_NAME) $(1)/usr/bin
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/usr/bin/* $(1)/usr/bin/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
