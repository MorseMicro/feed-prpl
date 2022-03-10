include $(TOPDIR)/rules.mk

PKG_NAME:=librlyeh
PKG_VERSION:=v0.4.16
SHORT_DESCRIPTION:=The module librlyeh provides functions and datastructures to interact with OCI registries

PKG_SOURCE:=librlyeh-v0.4.16.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/lcm/libraries/librlyeh/-/archive/v0.4.16
PKG_HASH:=341a55844c83d1bf65cb9c9809df953992ecf1be085f7d95485bc3a2ab875b32
PKG_BUILD_DIR:=$(BUILD_DIR)/librlyeh-v0.4.16
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=SoftAtHome
  SUBMENU:=Libraries
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/lcm/libraries/librlyeh
  DEPENDS += +libamxc
  DEPENDS += +libamxj
  DEPENDS += +yajl
  DEPENDS += +libocispec
  DEPENDS += +libopenssl
  DEPENDS += +curl
  DEPENDS += +libsahtrace
  DEPENDS += +libgpgme
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	The module librlyeh provides functions and datastructures to interact with OCI registries
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include)
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include)
	find $(PKG_INSTALL_DIR) -name *.a -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.h -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.pc -exec rm {} +;
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include)
endef

define Package/$(PKG_NAME)/install
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
