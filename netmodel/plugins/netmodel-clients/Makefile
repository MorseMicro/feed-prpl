include $(TOPDIR)/rules.mk

PKG_NAME:=netmodel-clients
PKG_VERSION:=v0.1.7
SHORT_DESCRIPTION:=Network Model clients plugin

PKG_SOURCE:=netmodel-clients-v0.1.7.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/netmodel/applications/netmodel-clients/-/archive/v0.1.7
PKG_HASH:=25f11de6d202c6113c4f511ee7b3e39d39c10288c1e0ffe1db61d5f98f00f2d9
PKG_BUILD_DIR:=$(BUILD_DIR)/netmodel-clients-v0.1.7
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

COMPONENT:=netmodel-clients

PKG_RELEASE:=1

define SAHInit/Install
	install -d ${PKG_INSTALL_DIR}/etc/rc.d/
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/S$(CONFIG_SAH_AMX_NETMODEL_CLIENTS_ORDER)$(COMPONENT)
endef

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=ambiorix
  SUBMENU:=Plugins
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/components/netmodel/applications/netmodel-clients
  DEPENDS += +libamxc
  DEPENDS += +libamxp
  DEPENDS += +libamxd
  DEPENDS += +libamxb
  DEPENDS += +libamxo
  DEPENDS += +libamxm
  DEPENDS += +libsahtrace
  DEPENDS += +libnetmodel
  DEPENDS += +amxrt
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	Network Model clients plugin
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_NETMODEL_CLIENTS_ORDER=$(CONFIG_SAH_AMX_NETMODEL_CLIENTS_ORDER))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_NETMODEL_CLIENTS_ORDER=$(CONFIG_SAH_AMX_NETMODEL_CLIENTS_ORDER))
	find $(PKG_INSTALL_DIR) -name *.a -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.h -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.pc -exec rm {} +;

	$(call SAHInit/Install)
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_NETMODEL_CLIENTS_ORDER=$(CONFIG_SAH_AMX_NETMODEL_CLIENTS_ORDER))
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
