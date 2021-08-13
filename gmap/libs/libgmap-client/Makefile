include $(TOPDIR)/rules.mk

PKG_NAME:=libgmap-client
PKG_VERSION:=v0.2.1
SHORT_DESCRIPTION:=Client library for gmap modules

PKG_SOURCE:=libgmap-client-v0.2.1.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/soft.at.home/gmap/libraries/libgmap-client/-/archive/v0.2.1
PKG_HASH:=c74b83c5b154d9130020eeb6e4300130c8a463b92f248c35dad5ed3496fef29c
PKG_BUILD_DIR:=$(BUILD_DIR)/libgmap-client-v0.2.1
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=gmap
  SUBMENU:=Libraries
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/soft.at.home/gmap/libraries/libgmap-client
  DEPENDS += +libamxc
  DEPENDS += +libamxp
  DEPENDS += +libamxb
  DEPENDS += +libamxd
  DEPENDS += +libsahtrace
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	Client library for gmap modules
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include)
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include)
	find $(PKG_INSTALL_DIR) -name *.a -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.h -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.pc -exec rm {} +;
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include)
endef

define Package/$(PKG_NAME)/install
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
