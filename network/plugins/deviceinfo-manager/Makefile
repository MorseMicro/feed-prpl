include $(TOPDIR)/rules.mk

PKG_NAME:=deviceinfo-manager
PKG_VERSION:=v1.2.18
SHORT_DESCRIPTION:=TR-181 compatible DeviceInfo plugin

PKG_SOURCE:=tr181-deviceinfo-v1.2.18.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/core/plugins/tr181-deviceinfo/-/archive/v1.2.18
PKG_HASH:=3bf78d2288e89b6f6ad28afbb62d76ce0d78baf7ac6c8c742dfef4d2b2ad361c
PKG_BUILD_DIR:=$(BUILD_DIR)/tr181-deviceinfo-v1.2.18
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

COMPONENT:=deviceinfo-manager

PKG_RELEASE:=1

define SAHInit/Install
	install -d ${PKG_INSTALL_DIR}/etc/rc.d/
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/S$(CONFIG_SAH_AMX_TR181_DEVICEINFO_ORDER)$(COMPONENT)
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/Z_sysinit_done ${PKG_INSTALL_DIR}/etc/rc.d/S99Z_sysinit_done
endef

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=ambiorix
  SUBMENU:=Plugins
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/components/core/plugins/tr181-deviceinfo
  DEPENDS += +libamxc
  DEPENDS += +libamxp
  DEPENDS += +libamxd
  DEPENDS += +libamxb
  DEPENDS += +libamxo
  DEPENDS += +libamxm
  DEPENDS += +libsahtrace
  DEPENDS += +mod-dmext
  DEPENDS += +procps-ng
  DEPENDS += +procps-ng-ps
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	TR-181 compatible DeviceInfo plugin
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_DEVICEINFO_ORDER=$(CONFIG_SAH_AMX_TR181_DEVICEINFO_ORDER) CONFIG_SAH_AMX_ADD_SYSINIT_DONE_SCRIPT=$(CONFIG_SAH_AMX_ADD_SYSINIT_DONE_SCRIPT))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_DEVICEINFO_ORDER=$(CONFIG_SAH_AMX_TR181_DEVICEINFO_ORDER) CONFIG_SAH_AMX_ADD_SYSINIT_DONE_SCRIPT=$(CONFIG_SAH_AMX_ADD_SYSINIT_DONE_SCRIPT))
	find $(PKG_INSTALL_DIR) -name *.a -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.h -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.pc -exec rm {} +;

	$(call SAHInit/Install)
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_AMX_TR181_DEVICEINFO_ORDER=$(CONFIG_SAH_AMX_TR181_DEVICEINFO_ORDER) CONFIG_SAH_AMX_ADD_SYSINIT_DONE_SCRIPT=$(CONFIG_SAH_AMX_ADD_SYSINIT_DONE_SCRIPT))
endef

define Package/$(PKG_NAME)/install
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
endef

define Package/$(PKG_NAME)/config
	source "$(SOURCE)/Config.in"
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
