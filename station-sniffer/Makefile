#
# Copyright (C) 2022 Tucker Polomik (tpolomik@cablelabs.com tuckerpo@buffalo.edu)
#

include $(TOPDIR)/rules.mk

PKG_NAME:=station-sniffer
PKG_VERSION:=2023-04-11
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/prplmesh/stationsniffer.git
PKG_SOURCE_VERSION:=fa582e973e68c5826be6d4ca61e164169afb59ca
PKG_MIRROR_HASH:=26efdd4409bf7ed363fd85887b456613c4bcc6c87a294d9399f43614e26d56b3

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
		+libpthread \
		+libnl
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
