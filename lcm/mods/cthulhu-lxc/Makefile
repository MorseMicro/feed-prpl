include $(TOPDIR)/rules.mk

PKG_NAME:=cthulhu-lxc
PKG_VERSION:=v0.2.10
SHORT_DESCRIPTION:=The module Cthulhu-LXC provides LXC support as a backend to Cthluhu

PKG_SOURCE:=cthulhu-lxc-v0.2.10.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/lcm/modules/cthulhu-lxc/-/archive/v0.2.10
PKG_HASH:=b510b01af431740c9de6dac5bf48f42ddf0c3df2c247e25a469f1e81ebd93df8
PKG_BUILD_DIR:=$(BUILD_DIR)/cthulhu-lxc-v0.2.10
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

PKG_BUILD_DEPENS += e2fsprogs

define Package/$(PKG_NAME)
  CATEGORY:=SoftAtHome
  SUBMENU:=Modules
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/lcm/modules/cthulhu-lxc
  DEPENDS += +libamxc
  DEPENDS += +libamxm
  DEPENDS += +libamxj
  DEPENDS += +libamxp
  DEPENDS += +libamxd
  DEPENDS += +libamxo
  DEPENDS += +libsahtrace
  DEPENDS += +liblxc4
  DEPENDS += +libcthulhu
  DEPENDS += +yajl
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	The module Cthulhu-LXC provides LXC support as a backend to Cthluhu
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_LIB_CTHULHU-LXC_LXC_TOOLS_PREFIX=$(CONFIG_SAH_LIB_CTHULHU-LXC_LXC_TOOLS_PREFIX) CONFIG_SAH_LIB_CTHULHU-LXC_PRPL_OS_RPATH=$(CONFIG_SAH_LIB_CTHULHU-LXC_PRPL_OS_RPATH))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_LIB_CTHULHU-LXC_LXC_TOOLS_PREFIX=$(CONFIG_SAH_LIB_CTHULHU-LXC_LXC_TOOLS_PREFIX) CONFIG_SAH_LIB_CTHULHU-LXC_PRPL_OS_RPATH=$(CONFIG_SAH_LIB_CTHULHU-LXC_PRPL_OS_RPATH))
	find $(PKG_INSTALL_DIR) -name *.a -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.h -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.pc -exec rm {} +;
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_LIB_CTHULHU-LXC_LXC_TOOLS_PREFIX=$(CONFIG_SAH_LIB_CTHULHU-LXC_LXC_TOOLS_PREFIX) CONFIG_SAH_LIB_CTHULHU-LXC_PRPL_OS_RPATH=$(CONFIG_SAH_LIB_CTHULHU-LXC_PRPL_OS_RPATH))
endef

define Package/$(PKG_NAME)/install
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
endef

define Package/$(PKG_NAME)/config
	source "$(SOURCE)/Config.in"
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
