include $(TOPDIR)/rules.mk

PKG_NAME:=mod-sahtrace
PKG_VERSION:=v1.1.0
SHORT_DESCRIPTION:=Module for sahtrace logging

PKG_SOURCE:=mod-sahtrace-v1.1.0.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/core/modules/mod-sahtrace/-/archive/v1.1.0
PKG_HASH:=0ddb2ed1a6b5c7473e0c4d19521464dc950c8c94ea9dd0da89c8801924e9403f
PKG_BUILD_DIR:=$(BUILD_DIR)/mod-sahtrace-v1.1.0
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE


PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=prpl Foundation
  SUBMENU:=Modules
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/components/core/modules/mod-sahtrace
  DEPENDS += +libamxc
  DEPENDS += +libamxd
  DEPENDS += +libamxo
  DEPENDS += +libamxj
  DEPENDS += +libsahtrace
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	Module for sahtrace logging
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_MOD_SAHTRACE_DEFAULT_LOG_LEVEL=$(CONFIG_SAH_MOD_SAHTRACE_DEFAULT_LOG_LEVEL) CONFIG_SAH_MOD_SAHTRACE_DEFAULT_TRACE_ZONE_LEVEL=$(CONFIG_SAH_MOD_SAHTRACE_DEFAULT_TRACE_ZONE_LEVEL))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_MOD_SAHTRACE_DEFAULT_LOG_LEVEL=$(CONFIG_SAH_MOD_SAHTRACE_DEFAULT_LOG_LEVEL) CONFIG_SAH_MOD_SAHTRACE_DEFAULT_TRACE_ZONE_LEVEL=$(CONFIG_SAH_MOD_SAHTRACE_DEFAULT_TRACE_ZONE_LEVEL))
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_MOD_SAHTRACE_DEFAULT_LOG_LEVEL=$(CONFIG_SAH_MOD_SAHTRACE_DEFAULT_LOG_LEVEL) CONFIG_SAH_MOD_SAHTRACE_DEFAULT_TRACE_ZONE_LEVEL=$(CONFIG_SAH_MOD_SAHTRACE_DEFAULT_TRACE_ZONE_LEVEL))
endef

define Package/$(PKG_NAME)/install
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
	if [ -d ./files ]; then \
		$(CP) ./files/* $(1)/; \
	fi
	find $(1) -name *.a -exec rm {} +;
	find $(1) -name *.h -exec rm {} +;
	find $(1) -name *.pc -exec rm {} +;
endef

define Package/$(PKG_NAME)/config
	source "$(SOURCE)/Config.in"
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
