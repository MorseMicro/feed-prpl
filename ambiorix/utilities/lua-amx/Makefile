include $(TOPDIR)/rules.mk

PKG_NAME:=lua-amx
PKG_VERSION:=v0.3.9
SHORT_DESCRIPTION:=LUA AMX Bindings 

PKG_SOURCE:=lua-amx-v0.3.9.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/ambiorix/bindings/lua/lua-amx/-/archive/v0.3.9
PKG_HASH:=6644c2b57bf67f3d00fbf7714b87a767f80728dd3cc32bb3edcb01851bafc6cf
PKG_BUILD_DIR:=$(BUILD_DIR)/lua-amx-v0.3.9
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=ambiorix
  SUBMENU:=Utilities
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/components/ambiorix/bindings/lua/lua-amx
  DEPENDS += +libamxc
  DEPENDS += +libamxp
  DEPENDS += +libamxd
  DEPENDS += +libamxb
  DEPENDS += +libamxo
  DEPENDS += +lua
  DEPENDS += +libevent2
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	LUA AMX Bindings 
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_LUA_AMX_LUA_VERSION_OVERRIDE=$(CONFIG_SAH_LUA_AMX_LUA_VERSION_OVERRIDE) CONFIG_SAH_LUA_AMX_LUA_VERSION=$(CONFIG_SAH_LUA_AMX_LUA_VERSION))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_LUA_AMX_LUA_VERSION_OVERRIDE=$(CONFIG_SAH_LUA_AMX_LUA_VERSION_OVERRIDE) CONFIG_SAH_LUA_AMX_LUA_VERSION=$(CONFIG_SAH_LUA_AMX_LUA_VERSION))
	find $(PKG_INSTALL_DIR) -name *.a -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.h -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.pc -exec rm {} +;
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_LUA_AMX_LUA_VERSION_OVERRIDE=$(CONFIG_SAH_LUA_AMX_LUA_VERSION_OVERRIDE) CONFIG_SAH_LUA_AMX_LUA_VERSION=$(CONFIG_SAH_LUA_AMX_LUA_VERSION))
endef

define Package/$(PKG_NAME)/install
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
	if [ -d ./files ]; then \
		$(CP) ./files/* $(1)/; \
	fi
endef

define Package/$(PKG_NAME)/config
	source "$(SOURCE)/Config.in"
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
