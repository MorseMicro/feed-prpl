include $(TOPDIR)/rules.mk

PKG_NAME:=tr181-firewall
PKG_VERSION:=v2.3.5
SHORT_DESCRIPTION:=TR181 firewall manager

PKG_SOURCE:=tr181-firewall-v2.3.5.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/core/plugins/tr181-firewall/-/archive/v2.3.5
PKG_HASH:=ca41a02b05324df2ad7acf97064ef1d271d08e4ddc9b647bb8ea42da51c31374
PKG_BUILD_DIR:=$(BUILD_DIR)/tr181-firewall-v2.3.5
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

COMPONENT:=tr181-firewall

PKG_RELEASE:=2

define SAHInit/Install
	install -d ${PKG_INSTALL_DIR}/etc/rc.d/
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/S$(CONFIG_SAH_AMX_TR181_FIREWALL_ORDER)$(COMPONENT)
endef

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=ambiorix
  SUBMENU:=Plugins
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
  DEPENDS += +iptables
  DEPENDS += +libmnl
  DEPENDS += +libnetfilter-queue
  DEPENDS += +libip4tc
  DEPENDS += +libip6tc
  DEPENDS += +libxtables
  DEPENDS += +kmod-ipt-core
  DEPENDS += +kmod-ipt-conntrack
  DEPENDS += +kmod-nf-conntrack6
  DEPENDS += +kmod-ipt-nat
  DEPENDS += +kmod-ipt-nfqueue
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	TR181 firewall manager
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_FIREWALL_ORDER=$(CONFIG_SAH_AMX_TR181_FIREWALL_ORDER))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_FIREWALL_ORDER=$(CONFIG_SAH_AMX_TR181_FIREWALL_ORDER))
	find $(PKG_INSTALL_DIR) -name *.a -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.h -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.pc -exec rm {} +;

	$(call SAHInit/Install)
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_FIREWALL_ORDER=$(CONFIG_SAH_AMX_TR181_FIREWALL_ORDER))
endef

define Package/$(PKG_NAME)/install
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
endef

define Package/$(PKG_NAME)/config
	source "$(SOURCE)/Config.in"
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
