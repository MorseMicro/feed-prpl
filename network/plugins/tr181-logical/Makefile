include $(TOPDIR)/rules.mk

PKG_NAME:=tr181-logical
PKG_VERSION:=v0.6.1
SHORT_DESCRIPTION:=logical interface plugin

PKG_SOURCE:=tr181-logical-v0.6.1.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/core/plugins/tr181-logical/-/archive/v0.6.1
PKG_HASH:=f8580107f7a94d55c4cc45ca813f282c84538bc5174e84eb6a6a644ecb8859b1
PKG_BUILD_DIR:=$(BUILD_DIR)/tr181-logical-v0.6.1
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

COMPONENT:=tr181-logical

PKG_RELEASE:=1

define SAHInit/Install
	install -d ${PKG_INSTALL_DIR}/etc/rc.d/
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/S$(CONFIG_SAH_AMX_TR181_LOGICAL_ORDER)$(COMPONENT)
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/K$(CONFIG_SAH_AMX_TR181_LOGICAL_ORDER)$(COMPONENT)
endef

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=prpl Foundation
  SUBMENU:=TR-181 Managers
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/components/core/plugins/tr181-logical
  DEPENDS += +libamxb
  DEPENDS += +libamxc
  DEPENDS += +libamxd
  DEPENDS += +libamxo
  DEPENDS += +libamxp
  DEPENDS += +libsahtrace
  DEPENDS += +amxrt
  DEPENDS += +mod-dmstats
  DEPENDS += +mod-netmodel
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	logical interface plugin
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_LOGICAL_ORDER=$(CONFIG_SAH_AMX_TR181_LOGICAL_ORDER) CONFIG_SAH_AMX_TR181_LOGICAL_RUN_AS_USER=$(CONFIG_SAH_AMX_TR181_LOGICAL_RUN_AS_USER) CONFIG_SAH_AMX_TR181_LOGICAL_RUN_AS_GROUP=$(CONFIG_SAH_AMX_TR181_LOGICAL_RUN_AS_GROUP))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_LOGICAL_ORDER=$(CONFIG_SAH_AMX_TR181_LOGICAL_ORDER) CONFIG_SAH_AMX_TR181_LOGICAL_RUN_AS_USER=$(CONFIG_SAH_AMX_TR181_LOGICAL_RUN_AS_USER) CONFIG_SAH_AMX_TR181_LOGICAL_RUN_AS_GROUP=$(CONFIG_SAH_AMX_TR181_LOGICAL_RUN_AS_GROUP))

	$(call SAHInit/Install)
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_LOGICAL_ORDER=$(CONFIG_SAH_AMX_TR181_LOGICAL_ORDER) CONFIG_SAH_AMX_TR181_LOGICAL_RUN_AS_USER=$(CONFIG_SAH_AMX_TR181_LOGICAL_RUN_AS_USER) CONFIG_SAH_AMX_TR181_LOGICAL_RUN_AS_GROUP=$(CONFIG_SAH_AMX_TR181_LOGICAL_RUN_AS_GROUP))
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
