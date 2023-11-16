include $(TOPDIR)/rules.mk

PKG_NAME:=netmodel-clients
PKG_VERSION:=v0.2.0
SHORT_DESCRIPTION:=Network Model clients plugin

PKG_SOURCE:=netmodel-clients-v0.2.0.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/netmodel/applications/netmodel-clients/-/archive/v0.2.0
PKG_HASH:=fa65cdbac5c713fff57565445d57406badcc3acb9834bdd625fdcf2465172faa
PKG_BUILD_DIR:=$(BUILD_DIR)/netmodel-clients-v0.2.0
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

COMPONENT:=netmodel-clients

PKG_RELEASE:=1

define SAHInit/Install
	install -d ${PKG_INSTALL_DIR}/etc/rc.d/
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/S$(CONFIG_SAH_AMX_NETMODEL_CLIENTS_ORDER)$(COMPONENT)
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/K$(CONFIG_SAH_AMX_NETMODEL_CLIENTS_ORDER)$(COMPONENT)
endef

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=prpl Foundation
  SUBMENU:=Netmodel
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
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_NETMODEL_CLIENTS_ORDER=$(CONFIG_SAH_AMX_NETMODEL_CLIENTS_ORDER) CONFIG_SAH_AMX_NETMODEL_CLIENTS_RUN_AS_USER=$(CONFIG_SAH_AMX_NETMODEL_CLIENTS_RUN_AS_USER) CONFIG_SAH_AMX_NETMODEL_CLIENTS_RUN_AS_GROUP=$(CONFIG_SAH_AMX_NETMODEL_CLIENTS_RUN_AS_GROUP))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_NETMODEL_CLIENTS_ORDER=$(CONFIG_SAH_AMX_NETMODEL_CLIENTS_ORDER) CONFIG_SAH_AMX_NETMODEL_CLIENTS_RUN_AS_USER=$(CONFIG_SAH_AMX_NETMODEL_CLIENTS_RUN_AS_USER) CONFIG_SAH_AMX_NETMODEL_CLIENTS_RUN_AS_GROUP=$(CONFIG_SAH_AMX_NETMODEL_CLIENTS_RUN_AS_GROUP))

	$(call SAHInit/Install)
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_NETMODEL_CLIENTS_ORDER=$(CONFIG_SAH_AMX_NETMODEL_CLIENTS_ORDER) CONFIG_SAH_AMX_NETMODEL_CLIENTS_RUN_AS_USER=$(CONFIG_SAH_AMX_NETMODEL_CLIENTS_RUN_AS_USER) CONFIG_SAH_AMX_NETMODEL_CLIENTS_RUN_AS_GROUP=$(CONFIG_SAH_AMX_NETMODEL_CLIENTS_RUN_AS_GROUP))
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
