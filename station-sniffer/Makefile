#
# Copyright (C) 2022 Tucker Polomik (tpolomik@cablelabs.com tuckerpo@buffalo.edu)
#

include $(TOPDIR)/rules.mk

PKG_NAME:=station-sniffer
PKG_VERSION:=2022-11-08
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/prplmesh/stationsniffer.git
PKG_SOURCE_VERSION:=bf9a4c1f05b9c03d5a0735cf3d4c926afd479591
PKG_MIRROR_HASH:=b428eb95775d7f4a2cedfe80bd8022d7c5ef6986a373d1e6cf0a9ed1dfe8cfdf

PKG_MAINTAINER:=Tucker Polomik <t.polomik@cablelabs.com tuckerpo@buffalo.edu>
PKG_LICENSE:=BSD-2-Clause
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/station-sniffer
	SECTION:=net
	CATEGORY:=mesh
	TITLE:=station-sniffer
	DEPENDS:= \
		+libpcap \
		+libradiotap \
		+libstdcpp \
		+libpthread
endef

define Package/station-sniffer/description
	A userspace application to capture and parse radiotap headers using libpcap for packet capture and libradiotap for radiotap parsing.
	Serves parsed radiotap data over Unix sockets.
endef

define Package/station-sniffer/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/$(PKG_NAME) $(1)/usr/bin
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
