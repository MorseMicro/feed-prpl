include $(TOPDIR)/rules.mk

PKG_NAME:=tr181-bridging
PKG_VERSION:=v2.3.0
SHORT_DESCRIPTION:=Implementation of Device

PKG_SOURCE:=tr181-bridging-v2.3.0.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/core/plugins/tr181-bridging/-/archive/v2.3.0
PKG_HASH:=a12f6139795415f0ce079a83b9254d6b589ee142e8f239f65ec4125581a1d475
PKG_BUILD_DIR:=$(BUILD_DIR)/tr181-bridging-v2.3.0
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

COMPONENT:=tr181-bridging

PKG_RELEASE:=1

define SAHInit/Install
	install -d ${PKG_INSTALL_DIR}/etc/rc.d/
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/S22$(COMPONENT)
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/K76$(COMPONENT)
endef

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=prpl Foundation
  SUBMENU:=TR-181 Managers
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/components/core/plugins/tr181-bridging
  DEPENDS += +libamxc
  DEPENDS += +libamxd
  DEPENDS += +libamxj
  DEPENDS += +libamxp
  DEPENDS += +libamxb
  DEPENDS += +libamxo
  DEPENDS += +libamxm
  DEPENDS += +libsahtrace
  DEPENDS += +libnetmodel
  DEPENDS += +mod-dmstats
  DEPENDS += +mod-netmodel
  DEPENDS += +rpcd
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	Implementation of Device.Bridging of the TR-181 datamodel
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_BRIDGING_RUN_AS_USER=$(CONFIG_SAH_AMX_TR181_BRIDGING_RUN_AS_USER) CONFIG_SAH_AMX_TR181_BRIDGING_RUN_AS_GROUP=$(CONFIG_SAH_AMX_TR181_BRIDGING_RUN_AS_GROUP))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_BRIDGING_RUN_AS_USER=$(CONFIG_SAH_AMX_TR181_BRIDGING_RUN_AS_USER) CONFIG_SAH_AMX_TR181_BRIDGING_RUN_AS_GROUP=$(CONFIG_SAH_AMX_TR181_BRIDGING_RUN_AS_GROUP))

	$(call SAHInit/Install)
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_BRIDGING_RUN_AS_USER=$(CONFIG_SAH_AMX_TR181_BRIDGING_RUN_AS_USER) CONFIG_SAH_AMX_TR181_BRIDGING_RUN_AS_GROUP=$(CONFIG_SAH_AMX_TR181_BRIDGING_RUN_AS_GROUP))
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
