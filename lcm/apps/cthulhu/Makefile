include $(TOPDIR)/rules.mk

PKG_NAME:=cthulhu
PKG_VERSION:=v3.5.1
SHORT_DESCRIPTION:=Cthulhu manages the lifecycle of containers

PKG_SOURCE:=cthulhu-v3.5.1.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/lcm/applications/cthulhu/-/archive/v3.5.1
PKG_HASH:=cadf7bff11feaaae6bafcb3f07c9ee1d4bc1c99272cc7bdfaeaf6620a3387ce8
PKG_BUILD_DIR:=$(BUILD_DIR)/cthulhu-v3.5.1
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

COMPONENT:=cthulhu

PKG_RELEASE:=1

define SAHInit/Install
	install -d ${PKG_INSTALL_DIR}/etc/rc.d/
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/S$(CONFIG_SAH_SERVICES_CTHULHU_INIT_START)$(COMPONENT)
	ln -sfr ${PKG_INSTALL_DIR}/etc/init.d/$(COMPONENT) ${PKG_INSTALL_DIR}/etc/rc.d/K$(CONFIG_SAH_SERVICES_CTHULHU_INIT_STOP)$(COMPONENT)
endef

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=prpl Foundation
  SUBMENU:=Life Cycle Management (LCM)
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
  DEPENDS += +liblcm
  DEPENDS += +libarchive
  DEPENDS += +libocispec
  DEPENDS += +libnl-core
  DEPENDS += +libnl-route
  DEPENDS += +!BUSYBOX_CONFIG_MKFS_EXT2:e2fsprogs
  DEPENDS += +kmod-loop
  DEPENDS += +kmod-veth
  DEPENDS += +kmod-fs-ext4
  DEPENDS += +f2fsck
  DEPENDS += +resize2fs
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	Cthulhu manages the lifecycle of containers
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_SERVICES_CTHULHU_DATASIZE=$(CONFIG_SAH_SERVICES_CTHULHU_DATASIZE) CONFIG_SAH_SERVICES_CTHULHU_LCM_STORAGE_LOCATION=$(CONFIG_SAH_SERVICES_CTHULHU_LCM_STORAGE_LOCATION) CONFIG_SAH_SERVICES_CTHULHU_INIT_START=$(CONFIG_SAH_SERVICES_CTHULHU_INIT_START) CONFIG_SAH_SERVICES_CTHULHU_INIT_STOP=$(CONFIG_SAH_SERVICES_CTHULHU_INIT_STOP))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_SERVICES_CTHULHU_DATASIZE=$(CONFIG_SAH_SERVICES_CTHULHU_DATASIZE) CONFIG_SAH_SERVICES_CTHULHU_LCM_STORAGE_LOCATION=$(CONFIG_SAH_SERVICES_CTHULHU_LCM_STORAGE_LOCATION) CONFIG_SAH_SERVICES_CTHULHU_INIT_START=$(CONFIG_SAH_SERVICES_CTHULHU_INIT_START) CONFIG_SAH_SERVICES_CTHULHU_INIT_STOP=$(CONFIG_SAH_SERVICES_CTHULHU_INIT_STOP))

	$(call SAHInit/Install)
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_SERVICES_CTHULHU_DATASIZE=$(CONFIG_SAH_SERVICES_CTHULHU_DATASIZE) CONFIG_SAH_SERVICES_CTHULHU_LCM_STORAGE_LOCATION=$(CONFIG_SAH_SERVICES_CTHULHU_LCM_STORAGE_LOCATION) CONFIG_SAH_SERVICES_CTHULHU_INIT_START=$(CONFIG_SAH_SERVICES_CTHULHU_INIT_START) CONFIG_SAH_SERVICES_CTHULHU_INIT_STOP=$(CONFIG_SAH_SERVICES_CTHULHU_INIT_STOP))
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
