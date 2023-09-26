include $(TOPDIR)/rules.mk

PKG_NAME:=gmap-mod-self
PKG_VERSION:=v1.4.0
SHORT_DESCRIPTION:=gmap module to fetch information about the hgw/repeater itself and the layer 2 'devices' on it

PKG_SOURCE:=gmap-mod-self-v1.4.0.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/gmap/applications/gmap-mod-self/-/archive/v1.4.0
PKG_HASH:=22399b4093c38fd9a5c8c3f89ff8358fb32f32601940069c4dc0fbaedc63a32b
PKG_BUILD_DIR:=$(BUILD_DIR)/gmap-mod-self-v1.4.0
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE


PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=gmap
  SUBMENU:=Applications
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/components/gmap/applications/gmap-mod-self
  DEPENDS += +libamxc
  DEPENDS += +libamxj
  DEPENDS += +libamxd
  DEPENDS += +libamxp
  DEPENDS += +libamxb
  DEPENDS += +libamxo
  DEPENDS += +libamxs
  DEPENDS += +libgmap-client
  DEPENDS += +libsahtrace
  DEPENDS += +libnetmodel
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	gmap module to fetch information about the hgw/repeater itself and the layer 2 'devices' on it
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_SERVICES_GMAP_SELF_DEVTYPE_WIFIREPEATER=$(CONFIG_SAH_SERVICES_GMAP_SELF_DEVTYPE_WIFIREPEATER))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_SERVICES_GMAP_SELF_DEVTYPE_WIFIREPEATER=$(CONFIG_SAH_SERVICES_GMAP_SELF_DEVTYPE_WIFIREPEATER))
	find $(PKG_INSTALL_DIR) -name *.a -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.h -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.pc -exec rm {} +;
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_SERVICES_GMAP_SELF_DEVTYPE_WIFIREPEATER=$(CONFIG_SAH_SERVICES_GMAP_SELF_DEVTYPE_WIFIREPEATER))
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
