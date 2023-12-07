include $(TOPDIR)/rules.mk

PKG_NAME:=gmap-client
PKG_VERSION:=v1.2.1
SHORT_DESCRIPTION:=gMap client plugin

PKG_SOURCE:=gmap-client-v1.2.1.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/gmap/applications/gmap-client/-/archive/v1.2.1
PKG_HASH:=04f1fa5d8a9ddbcaba519dbd2f8d193cd596a321cc84b3132fde6f3a09627720
PKG_BUILD_DIR:=$(BUILD_DIR)/gmap-client-v1.2.1
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

COMPONENT:=gmap-client

PKG_RELEASE:=1

define SAHInit/Install
	install -d ${PKG_INSTALL_DIR}/etc/rc.d/
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/S$(CONFIG_SAH_AMX_GMAP_CLIENT_ORDER)$(COMPONENT)
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/K$(CONFIG_SAH_AMX_GMAP_CLIENT_ORDER)$(COMPONENT)
endef

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=prpl Foundation
  SUBMENU:=gMap
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/components/gmap/applications/gmap-client
  DEPENDS += +libamxc
  DEPENDS += +libamxp
  DEPENDS += +libamxd
  DEPENDS += +libamxb
  DEPENDS += +libamxo
  DEPENDS += +libsahtrace
  DEPENDS += +amxrt
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	gMap client plugin
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_GMAP_CLIENT_ORDER=$(CONFIG_SAH_AMX_GMAP_CLIENT_ORDER) CONFIG_SAH_AMX_GMAP_CLIENT_ONE_PROCESS=$(CONFIG_SAH_AMX_GMAP_CLIENT_ONE_PROCESS))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_GMAP_CLIENT_ORDER=$(CONFIG_SAH_AMX_GMAP_CLIENT_ORDER) CONFIG_SAH_AMX_GMAP_CLIENT_ONE_PROCESS=$(CONFIG_SAH_AMX_GMAP_CLIENT_ONE_PROCESS))

	$(call SAHInit/Install)
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_GMAP_CLIENT_ORDER=$(CONFIG_SAH_AMX_GMAP_CLIENT_ORDER) CONFIG_SAH_AMX_GMAP_CLIENT_ONE_PROCESS=$(CONFIG_SAH_AMX_GMAP_CLIENT_ONE_PROCESS))
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
