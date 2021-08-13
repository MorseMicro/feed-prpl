include $(TOPDIR)/rules.mk

PKG_NAME:=gmap-mibs-common
PKG_VERSION:=v0.2.1
SHORT_DESCRIPTION:=Generic mib files for the gmap service

PKG_SOURCE:=gmap-mibs-common-v0.2.1.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/soft.at.home/gmap/mibs/gmap-mibs-common/-/archive/v0.2.1
PKG_HASH:=84a4aad72d2632fb859fa2355459e462f88bc26240448c047e79064add6f806e
PKG_BUILD_DIR:=$(BUILD_DIR)/gmap-mibs-common-v0.2.1
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=gmap
  SUBMENU:=Configurations
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/soft.at.home/gmap/mibs/gmap-mibs-common
  DEPENDS += +gmap-server
  DEPENDS += +libamxc
  DEPENDS += +libamxp
  DEPENDS += +libamxd
  DEPENDS += +libamxb
  DEPENDS += +libsahtrace
  DEPENDS += +libamxo
  DEPENDS += +libgmap-client
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	Generic mib files for the gmap service
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
