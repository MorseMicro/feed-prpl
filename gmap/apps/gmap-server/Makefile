include $(TOPDIR)/rules.mk

PKG_NAME:=gmap-server
PKG_VERSION:=v1.6.2
SHORT_DESCRIPTION:=Service implementing the gmap data model

PKG_SOURCE:=gmap-server-v1.6.2.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/gmap/applications/gmap-server/-/archive/v1.6.2
PKG_HASH:=c712ad78d8c6b9ea92b3f70bf929ae369f22761813f6d659a968dd9da04a7979
PKG_BUILD_DIR:=$(BUILD_DIR)/gmap-server-v1.6.2
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

COMPONENT:=gmap-server

PKG_RELEASE:=1
PKG_BUILD_DEPENDS += util-linux

define SAHInit/Install
	install -d ${PKG_INSTALL_DIR}/etc/rc.d/
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/S$(CONFIG_SAH_AMX_GMAP_SERVER_ORDER)$(COMPONENT)
endef

define SAHBackupRestore/Install
	install -d ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/backup
	install -d ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/restore
	install -d ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/import
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/backup/B$(CONFIG_SAH_AMX_GMAP_SERVER_ORDER)$(COMPONENT)
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/restore/R$(CONFIG_SAH_AMX_GMAP_SERVER_ORDER)$(COMPONENT)
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/import/R$(CONFIG_SAH_AMX_GMAP_SERVER_ORDER)$(COMPONENT)
endef

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=gmap
  SUBMENU:=Applications
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/components/gmap/applications/gmap-server
  DEPENDS += +libamxc
  DEPENDS += +libamxd
  DEPENDS += +libamxp
  DEPENDS += +libamxb
  DEPENDS += +libamxo
  DEPENDS += +libgmap-client
  DEPENDS += +libsahtrace
  DEPENDS += +libuuid
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	Service implementing the gmap data model
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_GMAP_SERVER_ORDER=$(CONFIG_SAH_AMX_GMAP_SERVER_ORDER) CONFIG_AMX_GMAP_SERVER_NAME_ORDER=$(CONFIG_AMX_GMAP_SERVER_NAME_ORDER) CONFIG_AMX_GMAP_MAX_DEVICES=$(CONFIG_AMX_GMAP_MAX_DEVICES))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_GMAP_SERVER_ORDER=$(CONFIG_SAH_AMX_GMAP_SERVER_ORDER) CONFIG_AMX_GMAP_SERVER_NAME_ORDER=$(CONFIG_AMX_GMAP_SERVER_NAME_ORDER) CONFIG_AMX_GMAP_MAX_DEVICES=$(CONFIG_AMX_GMAP_MAX_DEVICES))
	find $(PKG_INSTALL_DIR) -name *.a -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.h -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.pc -exec rm {} +;

	$(call SAHInit/Install)
	$(call SAHBackupRestore/Install)
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_GMAP_SERVER_ORDER=$(CONFIG_SAH_AMX_GMAP_SERVER_ORDER) CONFIG_AMX_GMAP_SERVER_NAME_ORDER=$(CONFIG_AMX_GMAP_SERVER_NAME_ORDER) CONFIG_AMX_GMAP_MAX_DEVICES=$(CONFIG_AMX_GMAP_MAX_DEVICES))
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
