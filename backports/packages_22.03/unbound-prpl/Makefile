#
# Copyright (C) 2010-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=unbound
PKG_RELEASE:=$(AUTORELEASE)

PKG_VERSION:=v0.2.0
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/mirrors/unbound/-/archive/$(PKG_VERSION)
PKG_HASH:=4d259f96c4667215e3ce27b1e628cc04d4895c944d31abd5336db462ebf5beff
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)


PKG_MAINTAINER:=Eric Luehrsen <ericluehrsen@gmail.com>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE
PKG_CPE_ID:=cpe:/a:nlnetlabs:unbound

PKG_BUILD_PARALLEL:=1
PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

PKG_CONFIG_DEPENDS:=CONFIG_PACKAGE_libunbound_dnscrypt \
	CONFIG_PACKAGE_libunbound_ipset \
	CONFIG_PACKAGE_libunbound_libevent \
	CONFIG_PACKAGE_libunbound_libpthread \
	CONFIG_PACKAGE_libunbound_nghttp2 \
	CONFIG_PACKAGE_libunbound_pythonmodule \
	CONFIG_PACKAGE_libunbound_subnet \
	CONFIG_PACKAGE_libunbound_dnstap

include $(INCLUDE_DIR)/package.mk

define Package/unbound-prpl/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  USERID:=unbound:unbound
  TITLE:=Recursive DNS Server
  URL:=https://nlnetlabs.nl/projects/unbound/about
  DEPENDS:=+ca-bundle +libopenssl +@OPENSSL_WITH_EC +libexpat \
  			+libamxb +libamxc +libamxd +libamxo +libamxp
endef

define Package/unbound-daemon-prpl
  $(call Package/unbound-prpl/Default)
  TITLE+= (daemon)
  CONFLICTS:=unbound-daemon
  DEPENDS+= +libunbound-prpl
endef

define Package/unbound-daemon-prpl/description
  This package contains the Unbound daemon including 'libevent', 'libmnl', and
  'libpthread' to better handle large networks with heavy query loads. Options
  are available under libraries/network/libunbound to custom trim Unbound for
  smaller targets.
endef

define Package/libunbound-prpl
  $(call Package/unbound-prpl/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  SUBMENU:=Networking
  TITLE+= (library)
  CONFLICTS:=libunbound
  DEPENDS+=+PACKAGE_libunbound_dnscrypt:libsodium \
    +PACKAGE_libunbound_ipset:libmnl \
    +PACKAGE_libunbound_libevent:libevent2 \
    +PACKAGE_libunbound_libpthread:libpthread \
    +PACKAGE_libunbound_nghttp2:libnghttp2 \
    +PACKAGE_libunbound_pythonmodule:python3-base \
    +PACKAGE_libunbound_dnstap:libprotobuf-c
endef

define Package/libunbound-prpl/description
  This package contains the Unbound library including 'libevent', 'libmnl', and
  'libpthread' to better handle large networks with heavy query loads. Options
  are available to custom trim Unbound for smaller targets.
endef

define Package/libunbound-prpl/config
	if PACKAGE_libunbound
	config PACKAGE_libunbound_dnscrypt
		bool "Build with DNSCRYPT support."
		default n
	config PACKAGE_libunbound_ipset
		bool "Build with IPSET (libmnl) support."
		default y
	config PACKAGE_libunbound_libevent
		bool "Build with expanded network resource (libevent) support."
		default y
	config PACKAGE_libunbound_libpthread
		bool "Build with POSIX threading (libpthread) support."
		default y
	config PACKAGE_libunbound_nghttp2
		bool "Build with DNS over HTTPS support (nghttp2 framework)."
		default n
	config PACKAGE_libunbound_pythonmodule
		bool "Build with PYTHON module for prototyping and data analysis."
		default n
	config PACKAGE_libunbound_subnet
		bool "Build with SUBNET cache module support."
		default n
	config PACKAGE_libunbound_dnstap
		bool "Build with dnstap support."
		default n
	endif
endef

CONFIGURE_VARS += UNAME=Linux

CONFIGURE_ARGS += \
	--disable-dsa \
	--disable-gost \
	--enable-allsymbols \
	--enable-ecdsa \
	--enable-tfo-client \
	--enable-tfo-server \
	--with-libexpat="$(STAGING_DIR)/usr" \
	--with-ssl="$(STAGING_DIR)/usr" \
	--with-user=unbound \
	--with-run-dir=/var/lib/unbound \
	--with-conf-file=/var/lib/unbound/unbound.conf \
	--with-pidfile=/var/run/unbound.pid \
    $(if $(CONFIG_PACKAGE_libunbound_dnscrypt), \
        --enable-dnscrypt --with-libsodium="$(STAGING_DIR)/usr",) \
    $(if $(CONFIG_PACKAGE_libunbound_ipset), \
        --enable-ipset --with-libmnl="$(STAGING_DIR)/usr",) \
    $(if $(CONFIG_PACKAGE_libunbound_libevent), \
        --enable-event-api --with-libevent="$(STAGING_DIR)/usr",--without-libevent) \
    $(if $(CONFIG_PACKAGE_libunbound_nghttp2), \
        --with-libnghttp2="$(STAGING_DIR)/usr",) \
    $(if $(CONFIG_PACKAGE_libunbound_libpthread), \
        --with-pthreads,--without-pthreads --without-solaris-threads) \
    $(if $(CONFIG_PACKAGE_libunbound_python),--with-pythonmodule,) \
    $(if $(CONFIG_PACKAGE_libunbound_subnet),--enable-subnet,) \
    $(if $(CONFIG_PACKAGE_libunbound_dnstap),--enable-dnstap,) \

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/libunbound.{so*,a,la} $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/include
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/include/unbound.h $(1)/usr/include/
ifneq ($(CONFIG_PACKAGE_libunbound_libevent),)
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/include/unbound-event.h $(1)/usr/include/
endif
endef

define Package/unbound-daemon-prpl/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/sbin/unbound $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc/unbound
endef

define Package/libunbound-prpl/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libunbound.so.* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,unbound-daemon-prpl))
$(eval $(call BuildPackage,libunbound-prpl))
