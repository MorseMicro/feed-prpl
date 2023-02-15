include $(TOPDIR)/rules.mk

PKG_NAME:=tr181-dslite
PKG_VERSION:=v0.5.0
SHORT_DESCRIPTION:=TR-181 compatible DSLite plugin

PKG_SOURCE:=tr181-dslite-v0.5.0.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/core/plugins/tr181-dslite/-/archive/v0.5.0
PKG_HASH:=1c2df018f1b5307f1c191e192d1a7d3e5020fe8a0ccc876b23c8249537c41e8a
PKG_BUILD_DIR:=$(BUILD_DIR)/tr181-dslite-v0.5.0
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

COMPONENT:=tr181-dslite

PKG_RELEASE:=1

define SAHInit/Install
	install -d ${PKG_INSTALL_DIR}/etc/rc.d/
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/S$(CONFIG_SAH_AMX_TR181_DSLITE_ORDER)$(COMPONENT)
endef

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=ambiorix
  SUBMENU:=Plugins
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/components/core/plugins/tr181-dslite
  DEPENDS += +libamxc
  DEPENDS += +libamxp
  DEPENDS += +libamxd
  DEPENDS += +libamxo
  DEPENDS += +libamxm
  DEPENDS += +libamxb
  DEPENDS += +libsahtrace
  DEPENDS += +amxrt
  DEPENDS += +mod-netmodel
  DEPENDS += +libnetmodel
  DEPENDS += +libcares
  DEPENDS += +kmod-ip6-tunnel
  DEPENDS += +kmod-iptunnel6
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	TR-181 compatible DSLite plugin
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_DSLITE_ORDER=$(CONFIG_SAH_AMX_TR181_DSLITE_ORDER) CONFIG_SAH_AMX_TR181_DSLITE_CARES_RPATH=$(CONFIG_SAH_AMX_TR181_DSLITE_CARES_RPATH))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_DSLITE_ORDER=$(CONFIG_SAH_AMX_TR181_DSLITE_ORDER) CONFIG_SAH_AMX_TR181_DSLITE_CARES_RPATH=$(CONFIG_SAH_AMX_TR181_DSLITE_CARES_RPATH))
	find $(PKG_INSTALL_DIR) -name *.a -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.h -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.pc -exec rm {} +;

	$(call SAHInit/Install)
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_DSLITE_ORDER=$(CONFIG_SAH_AMX_TR181_DSLITE_ORDER) CONFIG_SAH_AMX_TR181_DSLITE_CARES_RPATH=$(CONFIG_SAH_AMX_TR181_DSLITE_CARES_RPATH))
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
