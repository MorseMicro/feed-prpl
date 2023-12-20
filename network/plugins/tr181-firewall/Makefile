include $(TOPDIR)/rules.mk

PKG_NAME:=tr181-firewall
PKG_VERSION:=v6.13.5
SHORT_DESCRIPTION:=TR181 firewall manager

PKG_SOURCE:=tr181-firewall-v6.13.5.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/core/plugins/tr181-firewall/-/archive/v6.13.5
PKG_HASH:=c6389a0bf75768d6a3fbe6afe8503e88011f40148aedcd1a707e7e0fcbf829f2
PKG_BUILD_DIR:=$(BUILD_DIR)/tr181-firewall-v6.13.5
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

COMPONENT:=tr181-firewall

PKG_RELEASE:=1
PKG_BUILD_DEPENDS += SAH_AMX_TR181_FIREWALL_WITH_GMAP:libgmap-client

define SAHInit/Install
	install -d ${PKG_INSTALL_DIR}/etc/rc.d/
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/S$(CONFIG_SAH_AMX_TR181_FIREWALL_ORDER)$(COMPONENT)
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/K$(CONFIG_SAH_AMX_TR181_FIREWALL_ORDER)$(COMPONENT)
endef

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=prpl Foundation
  SUBMENU:=TR-181 Managers
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/components/core/plugins/tr181-firewall
  DEPENDS += +libamxc
  DEPENDS += +libamxp
  DEPENDS += +libamxd
  DEPENDS += +libamxb
  DEPENDS += +libamxo
  DEPENDS += +libsahtrace
  DEPENDS += +amxrt
  DEPENDS += +mod-dmext
  DEPENDS += +libfwrules
  DEPENDS += +libfwinterface
  DEPENDS += +libnetmodel
  DEPENDS += +libmnl
  DEPENDS += +libnetfilter-queue
  DEPENDS += +mod-pcm-svc
  DEPENDS += +libipat
  DEPENDS += +SAH_AMX_TR181_FIREWALL_WITH_GMAP:gmap-client
  DEPENDS += +SAH_AMX_TR181_FIREWALL_WITH_GMAP:gmap-mod-ethernet-dev
  DEPENDS += +SAH_AMX_TR181_FIREWALL_WITH_GMAP:gmap-mod-name-selector
  DEPENDS += +SAH_AMX_TR181_FIREWALL_WITH_GMAP:gmap-mod-self
  DEPENDS += +SAH_AMX_TR181_FIREWALL_WITH_GMAP:gmap-server
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	TR181 firewall manager
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_FIREWALL_ORDER=$(CONFIG_SAH_AMX_TR181_FIREWALL_ORDER) CONFIG_SAH_AMX_TR181_FIREWALL_RUN_AS_USER=$(CONFIG_SAH_AMX_TR181_FIREWALL_RUN_AS_USER) CONFIG_SAH_AMX_TR181_FIREWALL_RUN_AS_GROUP=$(CONFIG_SAH_AMX_TR181_FIREWALL_RUN_AS_GROUP) CONFIG_SAH_AMX_TR181_FIREWALL_WITH_GMAP=$(CONFIG_SAH_AMX_TR181_FIREWALL_WITH_GMAP))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_FIREWALL_ORDER=$(CONFIG_SAH_AMX_TR181_FIREWALL_ORDER) CONFIG_SAH_AMX_TR181_FIREWALL_RUN_AS_USER=$(CONFIG_SAH_AMX_TR181_FIREWALL_RUN_AS_USER) CONFIG_SAH_AMX_TR181_FIREWALL_RUN_AS_GROUP=$(CONFIG_SAH_AMX_TR181_FIREWALL_RUN_AS_GROUP) CONFIG_SAH_AMX_TR181_FIREWALL_WITH_GMAP=$(CONFIG_SAH_AMX_TR181_FIREWALL_WITH_GMAP))

	$(call SAHInit/Install)
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_FIREWALL_ORDER=$(CONFIG_SAH_AMX_TR181_FIREWALL_ORDER) CONFIG_SAH_AMX_TR181_FIREWALL_RUN_AS_USER=$(CONFIG_SAH_AMX_TR181_FIREWALL_RUN_AS_USER) CONFIG_SAH_AMX_TR181_FIREWALL_RUN_AS_GROUP=$(CONFIG_SAH_AMX_TR181_FIREWALL_RUN_AS_GROUP) CONFIG_SAH_AMX_TR181_FIREWALL_WITH_GMAP=$(CONFIG_SAH_AMX_TR181_FIREWALL_WITH_GMAP))
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
