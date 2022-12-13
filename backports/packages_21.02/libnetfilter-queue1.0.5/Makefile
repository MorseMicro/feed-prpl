#
# Copyright (C) 2009-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libnetfilter_queue1.0.5
PKG_VERSION:=1.0.5
PKG_RELEASE:=4

PKG_SOURCE:=libnetfilter_queue-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://www.netfilter.org/projects/libnetfilter_queue/files
PKG_HASH:=f9ff3c11305d6e03d81405957bdc11aea18e0d315c3e3f48da53a24ba251b9f5

PKG_FIXUP:=autoreconf
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

UNPACK_CMD=tar -xf "$(DL_DIR)/$(PKG_SOURCE)" -C $(PKG_BUILD_DIR) --strip-components=1

include $(INCLUDE_DIR)/package.mk

define Package/libnetfilter-queue1.0.5
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+libmnl +libnfnetlink
  TITLE:=Userspace API to packets queued by kernel packet filter
  URL:=https://www.netfilter.org/projects/libnetfilter_queue/
  ABI_VERSION:=1
endef

define Package/libnetfilter-queue1.0.5/description
 libnetfilter_queue is a userspace library providing a programming
 interface (API) to packets that have been queued by the kernel
 packet filter.
endef

TARGET_CFLAGS += $(FPIC) -D_GNU_SOURCE=1

CONFIGURE_ARGS += \
	--enable-static \
	--enable-shared \

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/prplos/usr/include/libnetfilter_queue
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/include/libnetfilter_queue/*.h \
		$(1)/opt/prplos/usr/include/libnetfilter_queue/

	$(INSTALL_DIR) $(1)/opt/prplos/usr/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/libnetfilter_queue.{so*,a,la} \
		$(1)/opt/prplos/usr/lib/

	$(INSTALL_DIR) $(1)/opt/prplos/usr/lib/pkgconfig
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libnetfilter_queue.pc \
		$(1)/opt/prplos/usr/lib/pkgconfig/
endef

define Package/libnetfilter-queue1.0.5/install
	$(INSTALL_DIR) $(1)/opt/prplos/usr/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/libnetfilter_queue.so.* \
		$(1)/opt/prplos/usr/lib/
endef

$(eval $(call BuildPackage,libnetfilter-queue1.0.5))
