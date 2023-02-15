include $(TOPDIR)/rules.mk

PKG_NAME:=cthulhu
PKG_VERSION:=proj_prpl_v0.18.12
SHORT_DESCRIPTION:=Cthulhu manages the lifecycle of containers

PKG_SOURCE:=cthulhu-v0.18.12.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/lcm/applications/cthulhu/-/archive/v0.18.12
PKG_HASH:=869f89af35af27bf154160b329790b71474f54c07a5f8891fd65f0b8fbbcb997
PKG_BUILD_DIR:=$(BUILD_DIR)/cthulhu-v0.18.12
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

COMPONENT:=cthulhu

PKG_RELEASE:=1

define SAHInit/Install
	install -d ${PKG_INSTALL_DIR}/etc/rc.d/
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/S$(CONFIG_SAH_SERVICES_CTHULHU_INIT_ORDER)$(COMPONENT)
endef

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=SoftAtHome
  SUBMENU:=Applications
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/lcm/applications/cthulhu
  DEPENDS += +libamxc
  DEPENDS += +libamxp
  DEPENDS += +libamxd
  DEPENDS += +libamxo
  DEPENDS += +libamxm
  DEPENDS += +libamxj
  DEPENDS += +libamxb
  DEPENDS += +libsahtrace
  DEPENDS += +yajl
  DEPENDS += +libcthulhu
  DEPENDS += +libarchive
  DEPENDS += +libocispec
  DEPENDS += +libnl-core
  DEPENDS += +libnl-route
  DEPENDS += +!BUSYBOX_CONFIG_MKFS_EXT2:e2fsprogs
  DEPENDS += +kmod-loop
  DEPENDS += +kmod-veth
  DEPENDS += +kmod-fs-ext4
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	Cthulhu manages the lifecycle of containers
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_SERVICES_CTHULHU_INIT_ORDER=$(CONFIG_SAH_SERVICES_CTHULHU_INIT_ORDER))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_SERVICES_CTHULHU_INIT_ORDER=$(CONFIG_SAH_SERVICES_CTHULHU_INIT_ORDER))
	find $(PKG_INSTALL_DIR) -name *.a -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.h -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.pc -exec rm {} +;

	$(call SAHInit/Install)
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_SERVICES_CTHULHU_INIT_ORDER=$(CONFIG_SAH_SERVICES_CTHULHU_INIT_ORDER))
endef

define Package/$(PKG_NAME)/install
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
	if [ -d ./files ]; then \
		$(CP) ./files/* $(1)/; \
	fi
endef

define Package/$(PKG_NAME)/config
	source "$(SOURCE)/Config.in"
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
