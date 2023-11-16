include $(TOPDIR)/rules.mk

PKG_NAME:=tr181-xpon
PKG_VERSION:=v1.3.7
SHORT_DESCRIPTION:=TR-181 XPON manager

PKG_SOURCE:=tr181-xpon-v1.3.7.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/core/plugins/tr181-xpon/-/archive/v1.3.7
PKG_HASH:=8ee3c2453be8127589bd27de2474e3daeb241293b48290dd80a178775a1ead64
PKG_BUILD_DIR:=$(BUILD_DIR)/tr181-xpon-v1.3.7
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

COMPONENT:=tr181-xpon

PKG_RELEASE:=1

define SAHInit/Install
	install -d ${PKG_INSTALL_DIR}/etc/rc.d/
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/S$(CONFIG_SAH_AMX_TR181_XPON_ORDER)$(COMPONENT)
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/K$(CONFIG_SAH_AMX_TR181_XPON_ORDER)$(COMPONENT)
endef

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=prpl Foundation
  SUBMENU:=TR-181 Managers
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/components/core/plugins/tr181-xpon
  DEPENDS += +libamxc
  DEPENDS += +libamxp
  DEPENDS += +libamxd
  DEPENDS += +libamxb
  DEPENDS += +libamxo
  DEPENDS += +libamxm
  DEPENDS += +libsahtrace
  DEPENDS += +amxrt
  DEPENDS += +mod-netmodel
  DEPENDS += +SAH_AMX_TR181_XPON_USE_NETDEV_COUNTERS:mod-dmstats
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	TR-181 XPON manager
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_XPON_ORDER=$(CONFIG_SAH_AMX_TR181_XPON_ORDER) CONFIG_SAH_AMX_TR181_XPON_MAX_ONUS=$(CONFIG_SAH_AMX_TR181_XPON_MAX_ONUS) CONFIG_SAH_AMX_TR181_XPON_USE_NETDEV_COUNTERS=$(CONFIG_SAH_AMX_TR181_XPON_USE_NETDEV_COUNTERS))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_XPON_ORDER=$(CONFIG_SAH_AMX_TR181_XPON_ORDER) CONFIG_SAH_AMX_TR181_XPON_MAX_ONUS=$(CONFIG_SAH_AMX_TR181_XPON_MAX_ONUS) CONFIG_SAH_AMX_TR181_XPON_USE_NETDEV_COUNTERS=$(CONFIG_SAH_AMX_TR181_XPON_USE_NETDEV_COUNTERS))

	$(call SAHInit/Install)
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_XPON_ORDER=$(CONFIG_SAH_AMX_TR181_XPON_ORDER) CONFIG_SAH_AMX_TR181_XPON_MAX_ONUS=$(CONFIG_SAH_AMX_TR181_XPON_MAX_ONUS) CONFIG_SAH_AMX_TR181_XPON_USE_NETDEV_COUNTERS=$(CONFIG_SAH_AMX_TR181_XPON_USE_NETDEV_COUNTERS))
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
