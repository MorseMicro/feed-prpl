include $(TOPDIR)/rules.mk

PKG_NAME:=libnetlink-utils
PKG_VERSION:=v0.0.9
SHORT_DESCRIPTION:=Netlink utility library

PKG_SOURCE:=libnetlink-utils-v0.0.9.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/core/libraries/libnetlink-utils/-/archive/v0.0.9
PKG_HASH:=e368f142982c5aa89a4b9183f97327dc87480d28f4f867c78b0204e33b9ed832
PKG_BUILD_DIR:=$(BUILD_DIR)/libnetlink-utils-v0.0.9
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE


PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=prpl Foundation
  SUBMENU:=Libraries
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/components/core/libraries/libnetlink-utils
  DEPENDS += +libamxc
  DEPENDS += +libamxp
  DEPENDS += +libamxd
  DEPENDS += +libamxo
  DEPENDS += +libamxb
  DEPENDS += +libsahtrace
  DEPENDS += +libnetfilter-queue
  DEPENDS += +libnetfilter-conntrack
  DEPENDS += +libmnl
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	Netlink utility library
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_LIB_NETLINK_NF_QUEUE_PRPL_OS_PATH=$(CONFIG_SAH_LIB_NETLINK_NF_QUEUE_PRPL_OS_PATH))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_LIB_NETLINK_NF_QUEUE_PRPL_OS_PATH=$(CONFIG_SAH_LIB_NETLINK_NF_QUEUE_PRPL_OS_PATH))
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_LIB_NETLINK_NF_QUEUE_PRPL_OS_PATH=$(CONFIG_SAH_LIB_NETLINK_NF_QUEUE_PRPL_OS_PATH))
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
