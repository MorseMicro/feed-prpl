#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=ppp-prpl
PKG_RELEASE:=3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/paulusmack/ppp
PKG_SOURCE_DATE:=2021-01-04
PKG_SOURCE_VERSION:=4fb319056f168bb8379865b91b4fd3e1ada73f1e
PKG_MIRROR_HASH:=429cb5fcff36e1d8698766130711d4764347f08b83233dfb4831bea21616efef
PKG_MAINTAINER:=Felix Fietkau <nbd@nbd.name>
PKG_LICENSE:=BSD-4-Clause
PKG_CPE_ID:=cpe:/a:samba:ppp

PKG_RELEASE_VERSION:=2.4.9
PKG_VERSION:=$(PKG_RELEASE_VERSION).git-$(PKG_SOURCE_DATE)

PKG_BUILD_DEPENDS:=libpcap

PKG_ASLR_PIE_REGULAR:=1
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/ppp-prpl
  SECTION:=net
  CATEGORY:=Network
  URL:=https://ppp.samba.org/
  DEPENDS:=+kmod-ppp +kmod-pppoe +libopenssl
  TITLE:=PPP daemon
  CONFLICTS:=ppp
endef

define Package/ppp-prpl/description
This package contains the PPP (Point-to-Point Protocol) daemon.
endef

define Package/ppp-prpl/conffiles
/etc/ppp/chap-secrets
/etc/ppp/filter
/etc/ppp/ip-down
/etc/ppp/ip-up
/etc/ppp/ipv6-down
/etc/ppp/ipv6-up
/etc/ppp/options
endef

define Build/Configure
$(call Build/Configure/Default,, \
	UNAME_S="Linux" \
	UNAME_R="$(LINUX_VERSION)" \
	UNAME_M="$(ARCH)" \
)
	mkdir -p $(PKG_BUILD_DIR)/pppd/plugins/pppoatm/linux
	$(CP) \
		$(LINUX_DIR)/include/linux/compiler.h \
		$(LINUX_DIR)/include/$(LINUX_UAPI_DIR)linux/atm*.h \
		$(PKG_BUILD_DIR)/pppd/plugins/pppoatm/linux/

	# Kernel 4.14.9+ only, ignore the exit status of cp in case the file
	# doesn't exits
	-$(CP) $(LINUX_DIR)/include/linux/compiler_types.h \
		$(PKG_BUILD_DIR)/pppd/plugins/pppoatm/linux/
endef

TARGET_CFLAGS += -ffunction-sections -fdata-sections -flto
TARGET_LDFLAGS += -Wl,--gc-sections -flto -fuse-linker-plugin

MAKE_FLAGS += COPTS="$(TARGET_CFLAGS)" \
		PRECOMPILED_FILTER=1 \
		STAGING_DIR="$(STAGING_DIR)" \
		HAVE_MULTILINK=

ifdef CONFIG_USE_MUSL
  MAKE_FLAGS += USE_LIBUTIL=
endif

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/include/pppd $(1)/usr/include/
endef

define Package/ppp-prpl/install
	$(INSTALL_DIR) $(1)/usr/lib/pppd/$(PKG_RELEASE_VERSION)
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/lib/libpppd.so $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/sbin/pppd $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc/ppp
	$(INSTALL_CONF) ./files/etc/ppp/chap-secrets $(1)/etc/ppp/
	$(INSTALL_DATA) ./files/etc/ppp/filter $(1)/etc/ppp/
	$(INSTALL_DATA) ./files/etc/ppp/options $(1)/etc/ppp/
	$(LN) /tmp/resolv.conf.ppp $(1)/etc/ppp/resolv.conf
	$(INSTALL_DIR) $(1)/lib/netifd/proto
	$(INSTALL_BIN) ./files/ppp.sh $(1)/lib/netifd/proto/
	$(INSTALL_BIN) ./files/lib/netifd/ppp-up $(1)/lib/netifd/
	$(INSTALL_BIN) ./files/lib/netifd/ppp6-up $(1)/lib/netifd/
	$(INSTALL_BIN) ./files/lib/netifd/ppp-down $(1)/lib/netifd/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/lib/pppd/$(PKG_RELEASE_VERSION)/pppoe.so \
		$(1)/usr/lib/pppd/$(PKG_RELEASE_VERSION)/
	$(LN) pppoe.so $(1)/usr/lib/pppd/$(PKG_RELEASE_VERSION)/rp-pppoe.so
endef

$(eval $(call BuildPackage,ppp-prpl))
