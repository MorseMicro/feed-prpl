include $(TOPDIR)/rules.mk

PKG_NAME:=libfwinterface
PKG_VERSION:=v1.3.7
SHORT_DESCRIPTION:=A library providing interfaces between lib_fwrules and netfilter

PKG_SOURCE:=libfwinterface-v1.3.7.tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/components/core/libraries/libfwinterface/-/archive/v1.3.7
PKG_HASH:=b78517baf9eb16562d69683c4c18bd848b31da5074aa6baef9effb508a8a35a0
PKG_BUILD_DIR:=$(BUILD_DIR)/libfwinterface-v1.3.7
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE

PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=ambiorix
  SUBMENU:=Libraries
  TITLE:=$(SHORT_DESCRIPTION)
  URL:=https://gitlab.com/prpl-foundation/components/core/libraries/libfwinterface
  DEPENDS += +libamxc
  DEPENDS += +libsahtrace
  DEPENDS += +libfwrules
  DEPENDS += +libiptc
  DEPENDS += +kmod-ifb
  DEPENDS += +kmod-ip6tables
  DEPENDS += +kmod-ipt-conntrack
  DEPENDS += +kmod-ipt-conntrack-extra
  DEPENDS += +kmod-ipt-core
  DEPENDS += +kmod-ipt-extra
  DEPENDS += +kmod-ipt-ipopt
  DEPENDS += +kmod-ipt-nat
  DEPENDS += +kmod-ipt-nat6
  DEPENDS += +kmod-ipt-nfqueue
  DEPENDS += +kmod-ipt-raw
  DEPENDS += +kmod-ipt-raw6
  DEPENDS += +kmod-nf-conntrack
  DEPENDS += +kmod-nf-conntrack6
  DEPENDS += +!LINUX_4_9:kmod-nf-flow
  DEPENDS += +kmod-nf-ipt
  DEPENDS += +kmod-nf-ipt6
  DEPENDS += +kmod-nf-nat
  DEPENDS += +kmod-nf-nat6
  DEPENDS += +kmod-nfnetlink
  DEPENDS += +kmod-nfnetlink-queue
  DEPENDS += +kmod-nf-reject
  DEPENDS += +kmod-nf-reject6
  DEPENDS += +kmod-ipt-conntrack-extra
  DEPENDS += +kmod-ip6tables-extra
  DEPENDS += +kmod-nf-nathelper
  DEPENDS += +kmod-nf-nathelper-extra
  DEPENDS += +ip6tables-extra
  DEPENDS += +libip4tc
  DEPENDS += +libip6tc
  DEPENDS += +libsahtrace
  DEPENDS += +libxtables
  MENU:=1
endef

define Package/$(PKG_NAME)/description
	A library providing interfaces between lib_fwrules and netfilter
endef

define Build/Compile
	$(call Build/Compile/Default, STAGINGDIR=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PKG_CONFIG_PATH=$(STAGING_DIR)/usr/lib/pkgconfig RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_LIB_FWINTERFACE_INTERFACE=$(CONFIG_SAH_LIB_FWINTERFACE_INTERFACE))
endef

define Build/Install
	$(call Build/Install/Default, install INSTALL=install D=$(PKG_INSTALL_DIR) DEST=$(PKG_INSTALL_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_LIB_FWINTERFACE_INTERFACE=$(CONFIG_SAH_LIB_FWINTERFACE_INTERFACE))
	find $(PKG_INSTALL_DIR) -name *.a -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.h -exec rm {} +;
	find $(PKG_INSTALL_DIR) -name *.pc -exec rm {} +;
endef

define Build/InstallDev
	$(call Build/Install/Default, install INSTALL=install D=$(STAGING_DIR) DEST=$(STAGING_DIR) CONFIGDIR=$(STAGING_DIR) PV=$(PKG_VERSION) PKG_CONFIG_LIBDIR=$(STAGING_DIR)/usr/lib/pkgconfig LIBDIR=/usr/lib INSTALL_LIB_DIR=/lib INSTALL_BIN_DIR=/bin RAW_VERSION=$(PKG_VERSION) HARDCO_HAL_DIR=$(STAGING_DIR)/usr/include CONFIG_SAH_LIB_FWINTERFACE_INTERFACE=$(CONFIG_SAH_LIB_FWINTERFACE_INTERFACE))
endef

define Package/$(PKG_NAME)/install
	if [ -d ./files ]; then \
		$(CP) ./files/* $(1)/; \
	fi
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
endef

define Package/$(PKG_NAME)/config
	source "$(SOURCE)/Config.in"
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
