#
# Copyright (C) 2009-2010 OpenWrt.org
# Copyright (C) 2009 Jakob Pfeiffer
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=c-ares1
PKG_VERSION:=1.17.2
PKG_RELEASE:=1

PKG_SOURCE:=c-ares-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://c-ares.haxx.se/download
PKG_HASH:=4803c844ce20ce510ef0eb83f8ea41fa24ecaae9d280c468c582d2bb25b3913d

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE.md
PKG_CPE_ID:=cpe:/a:c-ares_project:c-ares

PKG_BUILD_PARALLEL:=1

CMAKE_INSTALL:=1
UNPACK_CMD=tar -xf "$(DL_DIR)/$(PKG_SOURCE)" -C $(PKG_BUILD_DIR) --strip-components=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/libcares1
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Library for asyncronous DNS Requests (including name resolves)
  URL:=http://c-ares.haxx.se/
endef

define Package/libcares1/description
  c-ares is a C library for asynchronous DNS requests (including name resolves)

C89 compatibility, MIT licensed, builds for and runs on POSIX, Windows,
Netware, Android and many more operating systems.

This is a backport from openwrt-21.02

endef

CMAKE_OPTIONS += \
	-DCARES_STATIC=OFF \
	-DCARES_SHARED=ON \
	-DCARES_STATIC_PIC=ON \
	-DCARES_BUILD_TESTS=OFF \
	-DCARES_BUILD_TOOLS=OFF

# Install on custom location
CMAKE_OPTIONS += -DCMAKE_INSTALL_PREFIX=/opt/prplos/usr

define Package/libcares1/install
	$(INSTALL_DIR) $(1)/opt/prplos/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/prplos/usr/lib/libcares.so* $(1)/opt/prplos/usr/lib/
endef

$(eval $(call BuildPackage,libcares1))
