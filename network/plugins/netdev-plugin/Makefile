include $(TOPDIR)/rules.mk

PKG_NAME:=netdev-plugin
PKG_VERSION:=v1.11.2
SHORT_DESCRIPTION:=NetDev monitors the operating system's network devices

PKG_SOURCE:=netdev-v1.11.2.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/core/plugins/netdev/-/archive/v1.11.2
PKG_HASH:=54949d3174659a263af5429321954106eeb994a18e2567ff62c95152c7d104bc
PKG_BUILD_DIR:=$(BUILD_DIR)/netdev-v1.11.2
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

COMPONENT:=netdev-plugin

PKG_RELEASE:=1

define SAHInit/Install
	install -d ${PKG_INSTALL_DIR}/etc/rc.d/
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/S20$(COMPONENT)
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/K10$(COMPONENT)
endef

define SAHBackupRestore/Install
	install -d ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/backup
	install -d ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/restore
	install -d ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/import
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/backup/B10$(COMPONENT)
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/restore/R10$(COMPONENT)
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/usr/lib/hgwcfg/import/R10$(COMPONENT)
endef

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=prpl Foundation
  SUBMENU:=TR-181 Managers
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/components/core/plugins/netdev
  DEPENDS += +libamxc
  DEPENDS += +libamxj
  DEPENDS += +libamxd
  DEPENDS += +libamxp
  DEPENDS += +libamxb
  DEPENDS += +libamxo
  DEPENDS += +libsahtrace
  DEPENDS += +libmnl
  DEPENDS += +mod-dmext
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	NetDev monitors the operating system's network devices
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_NETDEV_64_BITS_NETWORK_STATISTICS=$(CONFIG_SAH_AMX_NETDEV_64_BITS_NETWORK_STATISTICS) CONFIG_SAH_AMX_NETDEV_BROKEN_NETLINK=$(CONFIG_SAH_AMX_NETDEV_BROKEN_NETLINK) CONFIG_SAH_AMX_NETDEV_RUN_AS_USER=$(CONFIG_SAH_AMX_NETDEV_RUN_AS_USER) CONFIG_SAH_AMX_NETDEV_RUN_AS_GROUP=$(CONFIG_SAH_AMX_NETDEV_RUN_AS_GROUP))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_NETDEV_64_BITS_NETWORK_STATISTICS=$(CONFIG_SAH_AMX_NETDEV_64_BITS_NETWORK_STATISTICS) CONFIG_SAH_AMX_NETDEV_BROKEN_NETLINK=$(CONFIG_SAH_AMX_NETDEV_BROKEN_NETLINK) CONFIG_SAH_AMX_NETDEV_RUN_AS_USER=$(CONFIG_SAH_AMX_NETDEV_RUN_AS_USER) CONFIG_SAH_AMX_NETDEV_RUN_AS_GROUP=$(CONFIG_SAH_AMX_NETDEV_RUN_AS_GROUP))

	$(call SAHInit/Install)
	$(call SAHBackupRestore/Install)
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_NETDEV_64_BITS_NETWORK_STATISTICS=$(CONFIG_SAH_AMX_NETDEV_64_BITS_NETWORK_STATISTICS) CONFIG_SAH_AMX_NETDEV_BROKEN_NETLINK=$(CONFIG_SAH_AMX_NETDEV_BROKEN_NETLINK) CONFIG_SAH_AMX_NETDEV_RUN_AS_USER=$(CONFIG_SAH_AMX_NETDEV_RUN_AS_USER) CONFIG_SAH_AMX_NETDEV_RUN_AS_GROUP=$(CONFIG_SAH_AMX_NETDEV_RUN_AS_GROUP))
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
