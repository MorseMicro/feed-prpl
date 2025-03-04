include $(TOPDIR)/rules.mk

PKG_NAME:=mod-ppp-daemon
PKG_VERSION:=v0.5.5
SHORT_DESCRIPTION:=Module integrating the pppd daemon as amx plugin

PKG_SOURCE:=mod-ppp-daemon-v0.5.5.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/core/modules/mod-ppp-daemon/-/archive/v0.5.5
PKG_HASH:=4aba98bb188fc0efc28ac05a47842827e304efce45dcb4f9b3994b755ec12295
PKG_BUILD_DIR:=$(BUILD_DIR)/mod-ppp-daemon-v0.5.5
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE


PKG_RELEASE:=1
PKG_BUILD_DEPENDS += libsahtrace

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=prpl Foundation
  SUBMENU:=Modules
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/components/core/modules/mod-ppp-daemon
  DEPENDS += +libamxc
  DEPENDS += +libamxp
  DEPENDS += +libamxd
  DEPENDS += +libamxo
  DEPENDS += +libamxm
  DEPENDS += +amxrt
  DEPENDS += +mod-netmodel
  DEPENDS += +libnetmodel
  DEPENDS += +ppp-prpl
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	Module integrating the pppd daemon as amx plugin
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include)
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include)
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include)
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

$(eval $(call BuildPackage,$(PKG_NAME)))
