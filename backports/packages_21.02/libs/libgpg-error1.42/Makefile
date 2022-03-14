#
# Copyright (C) 2005-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libgpg-error1.42
PKG_VERSION:=1.42
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE:=libgpg-error-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://mirrors.dotsrc.org/gcrypt/libgpg-error \
		http://ring.ksc.gr.jp/archives/net/gnupg/libgpg-error \
		https://www.gnupg.org/ftp/gcrypt/libgpg-error
PKG_HASH:=fc07e70f6c615f8c4f590a8e37a9b8dd2e2ca1e9408f8e60459c67452b925e23

PKG_MAINTAINER:=W. Michael Petullo <mike@flyn.org>
PKG_LICENSE:=LGPL-2.1-or-later
PKG_LICENSE_FILES:=COPYING

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

UNPACK_CMD=tar -xf "$(DL_DIR)/$(PKG_SOURCE)" -C $(PKG_BUILD_DIR) --strip-components=1

include $(INCLUDE_DIR)/package.mk

define Package/libgpg-error1.42
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=GnuPG error handling helper library
  URL:=https://www.gnupg.org/related_software/libgpg-error/
endef

define Package/libgpg-error1.42/description
	An helper library for common error codes and descriptions.
	This is a library that defines common error values for all GnuPG
	components. Among these are GPG, GPGSM, GPGME, GPG-Agent, libgcrypt,
	Libksba, DirMngr, Pinentry, SmartCard Daemon and possibly more in the
	future.
endef

CONFIGURE_ARGS += \
	--enable-shared \
	--enable-static \
	--disable-doc \
	--disable-languages \
	--disable-rpath \
	--disable-tests \
	--bindir=/opt/prplos/usr/bin \
	--includedir=/opt/prplos/usr/include \
	--libdir=/opt/prplos/usr/lib 

define Build/InstallDev
	$(INSTALL_DIR) $(2)/opt/prplos/bin $(1)/opt/prplos/usr/bin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/opt/prplos/usr/bin/gpg-error-config \
		$(2)/opt/prplos/bin/
	$(SED) \
		's,^\(prefix\|exec_prefix\)=.*,\1=$(STAGING_DIR)/usr,g' \
		$(2)/opt/prplos/bin/gpg-error-config
	ln -sf $(STAGING_DIR)/host/opt/prplos/bin/gpg-error-config $(1)/opt/prplos/usr/bin/gpg-error-config

	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/opt/prplos/usr/bin/gpgrt-config \
		$(2)/opt/prplos/bin/
	$(SED) \
		's,^\(prefix\|exec_prefix\)=.*,\1=$(STAGING_DIR)/usr,g' \
		$(2)/opt/prplos/bin/gpgrt-config
	ln -sf $(STAGING_DIR)/host/opt/prplos/bin/gpgrt-config $(1)/opt/prplos/usr/bin/gpgrt-config

	$(INSTALL_DIR) $(1)/opt/prplos/usr/include
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/prplos/usr/include/gpg-error.h \
		$(1)/opt/prplos/usr/include/

	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/opt/prplos/usr/include/gpgrt.h \
		$(1)/opt/prplos/usr/include/

	$(INSTALL_DIR) $(1)/opt/prplos/usr/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/prplos/usr/lib/libgpg-error.{la,a,so*} \
		$(1)/opt/prplos/usr/lib/

	$(INSTALL_DIR) $(1)/opt/prplos/usr/share/aclocal
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/usr/share/aclocal/gpg-error.m4 \
		$(1)/opt/prplos/usr/share/aclocal/

	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/usr/share/aclocal/gpgrt.m4 \
		$(1)/opt/prplos/usr/share/aclocal/
endef

define Package/libgpg-error1.42/install
	$(INSTALL_DIR) $(1)/opt/prplos/usr/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/prplos/usr/lib/libgpg-error.so.* \
		$(1)/opt/prplos/usr/lib/
endef

$(eval $(call BuildPackage,libgpg-error1.42))
