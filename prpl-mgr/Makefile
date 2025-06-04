#
# Copyright (C) 2025 Morse Micro
#
include $(TOPDIR)/rules.mk

PKG_NAME:=prpl-mgr
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=prpl Foundation
	SUBMENU:=prplMesh
	TITLE:=PrplMesh Openwrt abstraction layer
	MAINTAINER:=Morse Micro
	DEPENDS:= +rpcd +ucode +ucode-mod-ubus +ucode-mod-uci
endef

define Package/$(PKG_NAME)/description
	This package adds a ubus (rpcd ucode) handler to interface prplmesh with
	openwrt wlan subsystem.
endef

define Build/Compile
	# nothing to compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/share/rpcd/ucode
	$(INSTALL_DATA) ./rpcd/ucode/* $(1)/usr/share/rpcd/ucode
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
