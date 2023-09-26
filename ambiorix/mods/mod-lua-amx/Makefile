include $(TOPDIR)/rules.mk

PKG_NAME:=mod-lua-amx
PKG_VERSION:=v0.1.9
SHORT_DESCRIPTION:=Ambiorix LUA extension

PKG_SOURCE:=mod-lua-amx-v0.1.9.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/ambiorix/bindings/lua/mod-lua-amx/-/archive/v0.1.9
PKG_HASH:=d5600e212c787dcecdd0be1f0ca78e6ff06db5c368f32c42355406d56d2e0e5c
PKG_BUILD_DIR:=$(BUILD_DIR)/mod-lua-amx-v0.1.9
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE


PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=ambiorix
  SUBMENU:=Modules
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/components/ambiorix/bindings/lua/mod-lua-amx
  DEPENDS += +libamxc
  DEPENDS += +libamxp
  DEPENDS += +libamxd
  DEPENDS += +libamxo
  DEPENDS += +lua
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	Ambiorix LUA extension
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_LUA_AMX_LUA_VERSION=$(CONFIG_SAH_LUA_AMX_LUA_VERSION))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_LUA_AMX_LUA_VERSION=$(CONFIG_SAH_LUA_AMX_LUA_VERSION))
	find $(PKG_INSTALL_DIR) -name *.a -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.h -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.pc -exec rm {} +;
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_LUA_AMX_LUA_VERSION=$(CONFIG_SAH_LUA_AMX_LUA_VERSION))
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
