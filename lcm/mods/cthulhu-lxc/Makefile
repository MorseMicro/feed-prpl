include $(TOPDIR)/rules.mk

PKG_NAME:=cthulhu-lxc
PKG_VERSION:=v0.9.1
SHORT_DESCRIPTION:=The module provides LXC support as a backend to Cthluhu

PKG_SOURCE:=cthulhu-lxc-v0.9.1.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/lcm/modules/cthulhu-lxc/-/archive/v0.9.1
PKG_HASH:=d375306cf0555bee55b293d05956902a06f87f39f4f77d487eacea86d3a86b8c
PKG_BUILD_DIR:=$(BUILD_DIR)/cthulhu-lxc-v0.9.1
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE


PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=prpl Foundation
  SUBMENU:=Life Cycle Management (LCM)
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/lcm/modules/cthulhu-lxc
  DEPENDS += +libamxc
  DEPENDS += +libamxm
  DEPENDS += +libamxj
  DEPENDS += +libamxp
  DEPENDS += +libamxd
  DEPENDS += +libamxo
  DEPENDS += +libsahtrace
  DEPENDS += +liblxc
  DEPENDS += +libcthulhu
  DEPENDS += +liblcm
  DEPENDS += +yajl
  DEPENDS += +lxc
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	The module Cthulhu-LXC provides LXC support as a backend to Cthluhu
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_LIB_CTHULHU-LXC_PRPL_OS_RPATH=$(CONFIG_SAH_LIB_CTHULHU-LXC_PRPL_OS_RPATH))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_LIB_CTHULHU-LXC_PRPL_OS_RPATH=$(CONFIG_SAH_LIB_CTHULHU-LXC_PRPL_OS_RPATH))
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_LIB_CTHULHU-LXC_PRPL_OS_RPATH=$(CONFIG_SAH_LIB_CTHULHU-LXC_PRPL_OS_RPATH))
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
