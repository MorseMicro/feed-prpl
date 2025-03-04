include $(TOPDIR)/rules.mk

PKG_NAME:=mod-xpon-prpl
PKG_VERSION:=v1.0.5
SHORT_DESCRIPTION:=xpon prpl module

PKG_SOURCE:=mod-xpon-prpl-v1.0.5.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/core/modules/mod-xpon-prpl/-/archive/v1.0.5
PKG_HASH:=a2b43897cf1c921483b11d4eb7ff7c51f2ff9c457af19dfddcedb48754f970a9
PKG_BUILD_DIR:=$(BUILD_DIR)/mod-xpon-prpl-v1.0.5
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=prpl Foundation
  SUBMENU:=Modules
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/components/core/modules/mod-xpon-prpl
  DEPENDS += +libamxc
  DEPENDS += +libamxm
  DEPENDS += +libamxd
  DEPENDS += +libamxp
  DEPENDS += +libamxb
  DEPENDS += +libsahtrace
  DEPENDS += +ubus
  MENU:=1
endef

define Package/$(PKG_NAME)-mock
  CATEGORY:=prpl Foundation
  SUBMENU:=Modules
  TITLE:=$(SHORT_DESCRIPTION) mock
  URL:=https://gitlab.com/prpl-foundation/components/core/modules/mod-xpon-prpl
  DEPENDS += $(PKG_NAME)
endef

define Package/$(PKG_NAME)/description
	xpon prpl module
endef

define Package/$(PKG_NAME)-mock/description
	xpon prpl module mock
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include)
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
	if [ -d ./files ]; then \
		$(CP) ./files/* $(1)/; \
	fi
endef

define Package/$(PKG_NAME)-mock/install
	$(INSTALL_DIR) $(1)/opt/prplos/usr/bin
	$(CP) $(PKG_BUILD_DIR)/test/onu_hal_mock/onu_hal_mock/src/onu_hal_mock $(1)/opt/prplos/usr/bin/xpon-onu-hal-mock
	$(CP) $(PKG_BUILD_DIR)/test/onu_hal_mock/dbgtool/src/dbgtool $(1)/opt/prplos/usr/bin/xpon-onu-hal-mock-dbgtool
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)-mock))
