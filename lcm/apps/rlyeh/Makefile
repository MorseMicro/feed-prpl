include $(TOPDIR)/rules.mk

PKG_NAME:=rlyeh
PKG_VERSION:=v2.3.1
SHORT_DESCRIPTION:=Rlyeh is the local LCM repository

PKG_SOURCE:=rlyeh-v2.3.1.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/lcm/applications/rlyeh/-/archive/v2.3.1
PKG_HASH:=7c2e2b941b19598493bb7efb71f0fa071a081c6c6795ba124580b41541df6e3a
PKG_BUILD_DIR:=$(BUILD_DIR)/rlyeh-v2.3.1
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

COMPONENT:=rlyeh

PKG_RELEASE:=1

define SAHInit/Install
	install -d ${PKG_INSTALL_DIR}/etc/rc.d/
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/S$(CONFIG_SAH_SERVICES_RLYEH_ORDER)$(COMPONENT)
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/K$(CONFIG_SAH_SERVICES_RLYEH_ORDER)$(COMPONENT)
endef

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=prpl Foundation
  SUBMENU:=Life Cycle Management (LCM)
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/lcm/applications/rlyeh
  DEPENDS += +libamxc
  DEPENDS += +libamxp
  DEPENDS += +libamxd
  DEPENDS += +libamxo
  DEPENDS += +libamxm
  DEPENDS += +libsahtrace
  DEPENDS += +librlyeh
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	Rlyeh is the local LCM repository
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_SERVICES_RLYEH_LCM_STORAGE_LOCATION=$(CONFIG_SAH_SERVICES_RLYEH_LCM_STORAGE_LOCATION) CONFIG_SAH_SERVICES_RLYEH_ORDER=$(CONFIG_SAH_SERVICES_RLYEH_ORDER))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_SERVICES_RLYEH_LCM_STORAGE_LOCATION=$(CONFIG_SAH_SERVICES_RLYEH_LCM_STORAGE_LOCATION) CONFIG_SAH_SERVICES_RLYEH_ORDER=$(CONFIG_SAH_SERVICES_RLYEH_ORDER))

	$(call SAHInit/Install)
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_SERVICES_RLYEH_LCM_STORAGE_LOCATION=$(CONFIG_SAH_SERVICES_RLYEH_LCM_STORAGE_LOCATION) CONFIG_SAH_SERVICES_RLYEH_ORDER=$(CONFIG_SAH_SERVICES_RLYEH_ORDER))
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
