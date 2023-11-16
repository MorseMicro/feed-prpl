include $(TOPDIR)/rules.mk

PKG_NAME:=tr181-dhcpv4client
PKG_VERSION:=v1.24.1
SHORT_DESCRIPTION:=TR-181 compatible DHCPv4 client

PKG_SOURCE:=tr181-dhcpv4client-v1.24.1.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/core/plugins/tr181-dhcpv4client/-/archive/v1.24.1
PKG_HASH:=1e23ddbcb03b165ef86a2202ff795c292f0462420169d7bd77aab8ecbdb22aeb
PKG_BUILD_DIR:=$(BUILD_DIR)/tr181-dhcpv4client-v1.24.1
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

COMPONENT:=tr181-dhcpv4client

PKG_RELEASE:=1

define SAHInit/Install
	install -d ${PKG_INSTALL_DIR}/etc/rc.d/
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/S27$(COMPONENT)
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/K75$(COMPONENT)
endef

define SAHBackupRestore/Install
	install -d ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/backup
	install -d ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/restore
	install -d ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/import
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/backup/B25$(COMPONENT)
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/restore/R25$(COMPONENT)
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/import/R25$(COMPONENT)
endef

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=prpl Foundation
  SUBMENU:=TR-181 Managers
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/components/core/plugins/tr181-dhcpv4client
  DEPENDS += +libamxb
  DEPENDS += +libamxc
  DEPENDS += +libamxd
  DEPENDS += +libamxj
  DEPENDS += +libamxm
  DEPENDS += +libamxo
  DEPENDS += +libamxp
  DEPENDS += +amxrt
  DEPENDS += +libsahtrace
  DEPENDS += +libdhcpoptions
  DEPENDS += +libnetmodel
  DEPENDS += +mod-netmodel
  DEPENDS += +mod-dmext
  DEPENDS += +rpcd
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	TR-181 compatible DHCPv4 client
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_DHCPV4CLIENT_RUN_AS_USER=$(CONFIG_SAH_AMX_TR181_DHCPV4CLIENT_RUN_AS_USER) CONFIG_SAH_AMX_TR181_DHCPV4CLIENT_RUN_AS_GROUP=$(CONFIG_SAH_AMX_TR181_DHCPV4CLIENT_RUN_AS_GROUP))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_DHCPV4CLIENT_RUN_AS_USER=$(CONFIG_SAH_AMX_TR181_DHCPV4CLIENT_RUN_AS_USER) CONFIG_SAH_AMX_TR181_DHCPV4CLIENT_RUN_AS_GROUP=$(CONFIG_SAH_AMX_TR181_DHCPV4CLIENT_RUN_AS_GROUP))

	$(call SAHInit/Install)
	$(call SAHBackupRestore/Install)
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_DHCPV4CLIENT_RUN_AS_USER=$(CONFIG_SAH_AMX_TR181_DHCPV4CLIENT_RUN_AS_USER) CONFIG_SAH_AMX_TR181_DHCPV4CLIENT_RUN_AS_GROUP=$(CONFIG_SAH_AMX_TR181_DHCPV4CLIENT_RUN_AS_GROUP))
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
