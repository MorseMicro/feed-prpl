include $(TOPDIR)/rules.mk

PKG_NAME:=mod-ba-cli
PKG_VERSION:=v0.4.0
SHORT_DESCRIPTION:=Bus Agnostic Command Line Interface

PKG_SOURCE:=mod-ba-cli-v0.4.0.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/ambiorix/modules/amx_cli/mod-ba-cli/-/archive/v0.4.0
PKG_HASH:=9bb728dd81e00e0d5c49f34d156fcfba14a94ffbebca95c2618744e221211028
PKG_BUILD_DIR:=$(BUILD_DIR)/mod-ba-cli-v0.4.0
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=ambiorix
  SUBMENU:=Modules
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/components/ambiorix/modules/amx_cli/mod-ba-cli
  DEPENDS += +libamxc
  DEPENDS += +libamxt
  DEPENDS += +libamxm
  DEPENDS += +libamxp
  DEPENDS += +libamxd
  DEPENDS += +libamxb
  DEPENDS += +libamxo
  DEPENDS += +libamxa
  DEPENDS += +amx-cli
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	Bus Agnostic Command Line Interface
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_MOD_BA_CLI_INSTALL_UBUS_CLI=$(CONFIG_SAH_MOD_BA_CLI_INSTALL_UBUS_CLI) CONFIG_SAH_MOD_BA_CLI_INSTALL_PCB_CLI=$(CONFIG_SAH_MOD_BA_CLI_INSTALL_PCB_CLI))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_MOD_BA_CLI_INSTALL_UBUS_CLI=$(CONFIG_SAH_MOD_BA_CLI_INSTALL_UBUS_CLI) CONFIG_SAH_MOD_BA_CLI_INSTALL_PCB_CLI=$(CONFIG_SAH_MOD_BA_CLI_INSTALL_PCB_CLI))
	find $(PKG_INSTALL_DIR) -name *.a -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.h -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.pc -exec rm {} +;
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_MOD_BA_CLI_INSTALL_UBUS_CLI=$(CONFIG_SAH_MOD_BA_CLI_INSTALL_UBUS_CLI) CONFIG_SAH_MOD_BA_CLI_INSTALL_PCB_CLI=$(CONFIG_SAH_MOD_BA_CLI_INSTALL_PCB_CLI))
endef

define Package/$(PKG_NAME)/install
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
endef

define Package/$(PKG_NAME)/config
	source "$(SOURCE)/Config.in"
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
