include $(TOPDIR)/rules.mk

PKG_NAME:=mod-ba-cli
PKG_VERSION:=v0.9.0
SHORT_DESCRIPTION:=Bus Agnostic Command Line Interface

PKG_SOURCE:=mod-ba-cli-v0.9.0.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/ambiorix/modules/amx_cli/mod-ba-cli/-/archive/v0.9.0
PKG_HASH:=ed8ae573a907c8f9fb66b460969e45be5f7dc7f4a3a54e74a10379917b7d5f18
PKG_BUILD_DIR:=$(BUILD_DIR)/mod-ba-cli-v0.9.0
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE


PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=prpl Foundation
  SUBMENU:=Ambiorix
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/components/ambiorix/modules/amx_cli/mod-ba-cli
  DEPENDS += +libamxc
  DEPENDS += +libamxt
  DEPENDS += +libamxm
  DEPENDS += +libamxp
  DEPENDS += +libamxd
  DEPENDS += +libamxb
  DEPENDS += +libamxa
  DEPENDS += +amx-cli
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	Bus Agnostic Command Line Interface
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_MOD_BA_CLI_INSTALL_UBUS_CLI=$(CONFIG_SAH_MOD_BA_CLI_INSTALL_UBUS_CLI) CONFIG_SAH_MOD_BA_CLI_INSTALL_PCB_CLI=$(CONFIG_SAH_MOD_BA_CLI_INSTALL_PCB_CLI))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_MOD_BA_CLI_INSTALL_UBUS_CLI=$(CONFIG_SAH_MOD_BA_CLI_INSTALL_UBUS_CLI) CONFIG_SAH_MOD_BA_CLI_INSTALL_PCB_CLI=$(CONFIG_SAH_MOD_BA_CLI_INSTALL_PCB_CLI))
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_MOD_BA_CLI_INSTALL_UBUS_CLI=$(CONFIG_SAH_MOD_BA_CLI_INSTALL_UBUS_CLI) CONFIG_SAH_MOD_BA_CLI_INSTALL_PCB_CLI=$(CONFIG_SAH_MOD_BA_CLI_INSTALL_PCB_CLI))
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
