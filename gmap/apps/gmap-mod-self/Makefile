include $(TOPDIR)/rules.mk

PKG_NAME:=gmap-mod-self
PKG_VERSION:=v0.0.12
SHORT_DESCRIPTION:=gmap module to fetch information about the hgw itself and the layer 2 'devices' on it

PKG_SOURCE:=gmap-mod-self-v0.0.12.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/soft.at.home/gmap/applications/gmap-mod-self/-/archive/v0.0.12
PKG_HASH:=42cad5951f2d4a09f06d7d5fc431085dde184525ac5420751f88300f17c4ef6b
PKG_BUILD_DIR:=$(BUILD_DIR)/gmap-mod-self-v0.0.12
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

COMPONENT:=gmap-mod-self

PKG_RELEASE:=1

define SAHInit/Install
	install -d ${PKG_INSTALL_DIR}/etc/rc.d/
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT).so ${PKG_INSTALL_DIR}/etc/rc.d/S72$(COMPONENT).so
endef

define SAHBackupRestore/Install
	install -d ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/backup
	install -d ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/restore
	install -d ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/import
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT).so ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/backup/B10$(COMPONENT).so
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT).so ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/restore/R10$(COMPONENT).so
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT).so ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/import/R10$(COMPONENT).so
endef

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=gmap
  SUBMENU:=Applications
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/soft.at.home/gmap/applications/gmap-mod-self
  DEPENDS += +libamxc
  DEPENDS += +libamxj
  DEPENDS += +libamxd
  DEPENDS += +libamxp
  DEPENDS += +libamxb
  DEPENDS += +libamxo
  DEPENDS += +libgmap-client
  DEPENDS += +libsahtrace
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	gmap module to fetch information about the hgw itself and the layer 2 'devices' on it
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include)
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include)
	find $(PKG_INSTALL_DIR) -name *.a -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.h -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.pc -exec rm {} +;

	$(call SAHInit/Install)
	$(call SAHBackupRestore/Install)
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include)
endef

define Package/$(PKG_NAME)/install
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
