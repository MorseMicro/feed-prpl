#
# Copyright (C) 2013-2015 OpenWrt.org
# Copyright (C) 2020 Sartura
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=lxc4
PKG_VERSION:=4.0.10
PKG_RELEASE:=$(AUTORELEASE)

UNPACK_CMD=tar -xf "$(DL_DIR)/$(PKG_SOURCE)" -C $(PKG_BUILD_DIR) --strip-components=1

PKG_SOURCE:=lxc-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://linuxcontainers.org/downloads/lxc/
PKG_HASH:=a10c518056d2e497bd600e4ffac2853bdeab1e835bf455a6d87cc8df128bfae9

PKG_MAINTAINER:=Marko Ratkaj <marko.ratkaj@sartura.hr>
PKG_LICENSE:=LGPL-2.1-or-later BSD-2-Clause GPL-2.0

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

LXC4_APPLETS_BIN += \
	attach autostart cgroup copy config console create destroy device \
	execute freeze info monitor snapshot start stop unfreeze unshare \
	usernsexec wait top ls

LXC4_APPLETS_LIB += \
	monitord user-nic

LXC4_SCRIPTS += \
	checkconfig

DEPENDS_APPLETS = +libpthread +libcap +liblxc4

DEPENDS_create = +lxc4-configs +lxc4-hooks +lxc4-templates +flock

define Package/lxc4/Default
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=LXC userspace tools
  URL:=https://linuxcontainers.org/
  DEPENDS:=lxc4
endef

define Package/lxc4
  $(call Package/lxc4/Default)
  DEPENDS:=@!arc
  MENU:=1
endef

define Package/lxc4-auto
  $(call Package/lxc4/Default)
  TITLE:= (initscript)
  DEPENDS+=+lxc4-start +lxc4-stop
endef

define Package/lxc4-auto/description
 LXC is the userspace control package for Linux Containers, a lightweight
 virtual system mechanism sometimes described as "chroot on steroids".
 This package adds an initscript for starting and stopping the containers
 on boot and shutdown.
endef

define Package/lxc4-auto/conffiles
/opt/prplos/etc/config/lxc-auto
endef

define Package/lxc4-unprivileged
  $(call Package/lxc4/Default)
  TITLE:=Helper script for unprivileged containers support
  DEPENDS+=+shadow-utils +shadow-newuidmap +shadow-newgidmap
endef

define Package/lxc4-unprivileged/description
 Support for unprivileged containers requires newuidmap and newguidmap.
 This package makes sure they are available & have correct permissions.
endef

define Package/lxc4-unprivileged/install
	$(INSTALL_DIR) $(1)/opt/prplos/etc/uci-defaults
	$(INSTALL_DATA) ./files/lxc-unprivileged.defaults $(1)/opt/prplos/etc/uci-defaults/lxc-unprivileged
endef

define Package/lxc4/config
  source "$(SOURCE)/Config.in"
endef

define Package/lxc4/description
 LXC is the userspace control package for Linux Containers, a lightweight
 virtual system mechanism sometimes described as "chroot on steroids".
endef

define Package/lxc4-common
  $(call Package/lxc4/Default)
  TITLE:=LXC common files
endef

define Package/lxc4-hooks
  $(call Package/lxc4/Default)
  TITLE:=LXC virtual machine hooks
endef

define Package/lxc4-templates
  $(call Package/lxc4/Default)
  TITLE:=LXC virtual machine templates
endef

define Package/lxc4-configs
  $(call Package/lxc4/Default)
  TITLE:=LXC virtual machine common config files
endef

define Package/liblxc4
  $(call Package/lxc4/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=LXC userspace library
  DEPENDS+= +libcap +libpthread +LXC_SECCOMP:libseccomp +libopenssl
endef

define Package/lxc4-init
  $(call Package/lxc4/Default)
  TITLE:=LXC Lua bindings
  DEPENDS+= +liblxc4
endef

CONFIGURE_ARGS += \
	--disable-werror \
	--disable-doc \
	--disable-api-docs \
	--disable-apparmor \
	--disable-selinux \
	--$(if $(CONFIG_LXC_SECCOMP),en,dis)able-seccomp \
	--enable-capabilities \
	--disable-examples \
	--with-global-conf="/opt/prplos/etc/lxc/lxc.conf"  \
	--sysconfdir="/opt/prplos/etc/" \
	--libdir="/opt/prplos/usr/lib/" \
	--with-runtime-path="/var/run/"

ifdef CONFIG_USE_MIPS16
  TARGET_CFLAGS += -minterlink-mips16
endif
TARGET_LDFLAGS += -lgcc_eh -Wl,-rpath=/opt/prplos/usr/lib/

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/prplos/usr/include/lxc/
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/include/lxc/* \
		$(1)/opt/prplos/usr/include/lxc/

	$(INSTALL_DIR) $(1)/opt/prplos/usr/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/prplos/usr/lib/liblxc.so* \
		$(1)/opt/prplos/usr/lib/

	$(INSTALL_DIR) $(1)/opt/prplos/usr/lib/pkgconfig
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/prplos/usr/lib/pkgconfig/lxc.pc \
		$(1)/opt/prplos/usr/lib/pkgconfig/
	$(SED) 's,/usr/include,$$$${prefix}/include,g' $(1)/opt/prplos/usr/lib/pkgconfig/lxc.pc
	$(SED) 's,/usr/lib,$$$${prefix}/lib,g' $(1)/opt/prplos/usr/lib/pkgconfig/lxc.pc
endef


define Package/lxc4/install
	true
endef

define Package/lxc4-auto/install
	$(INSTALL_DIR) $(1)/opt/prplos/etc/config $(1)/opt/prplos/etc/init.d
	$(INSTALL_CONF) ./files/lxc-auto.config $(1)/opt/prplos/etc/config/lxc-auto
	$(INSTALL_BIN) ./files/lxc-auto.init $(1)/opt/prplos/etc/init.d/lxc-auto
endef

define Package/lxc4-common/conffiles
/opt/prplos/etc/lxc/default.conf
/opt/prplos/etc/lxc/lxc.conf
endef

define Package/lxc4-common/install
	$(INSTALL_DIR) $(1)/opt/prplos/usr/lib/lxc/rootfs
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/prplos/usr/lib/lxc/rootfs/README \
		$(1)/opt/prplos/usr/lib/lxc/rootfs/

	$(INSTALL_DIR) $(1)/opt/prplos/usr/share/lxc
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/share/lxc/lxc.functions \
		$(1)/opt/prplos/usr/share/lxc/

	$(INSTALL_DIR) $(1)/opt/prplos/etc/lxc/
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/prplos/etc/lxc/default.conf \
		$(1)/opt/prplos/etc/lxc/default.conf

	$(INSTALL_DIR) $(1)/opt/prplos/etc/lxc/
	$(CP) \
		./files/lxc.conf \
		$(1)/opt/prplos/etc/lxc/lxc.conf

	$(INSTALL_DIR) $(1)/opt/prplos/srv/lxc/
endef

define Package/lxc4-hooks/install
	$(INSTALL_DIR) $(1)/opt/prplos/usr/share/lxc/hooks
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/share/lxc/hooks/* \
		$(1)/opt/prplos/usr/share/lxc/hooks/
endef

define Package/lxc4-templates/install
	$(INSTALL_DIR) $(1)/opt/prplos/usr/share/lxc/templates/
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/share/lxc/templates/lxc-* \
		$(1)/opt/prplos/usr/share/lxc/templates/
endef

define Package/lxc4-configs/install
	$(INSTALL_DIR) $(1)/opt/prplos/usr/share/lxc/config/
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/share/lxc/config/* \
		$(1)/opt/prplos/usr/share/lxc/config/
endef

define Package/liblxc4/install
	$(INSTALL_DIR) $(1)/opt/prplos/usr/lib/
	$(CP) \
		$(PKG_INSTALL_DIR)/opt/prplos/usr/lib/liblxc.so* \
		$(1)/opt/prplos/usr/lib/
endef

define Package/lxc4-init/install
	$(INSTALL_DIR) $(1)/opt/prplos/sbin
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/sbin/init.lxc \
		$(1)/opt/prplos/sbin/
endef

define GenPlugin
  define Package/lxc4-$(1)
    $(call Package/lxc4/Default)
    TITLE:=Utility lxc4-$(1) from the LXC userspace tools
    DEPENDS+= +lxc4-common $(2) $(DEPENDS_$(1)) liblxc4
  endef

  define Package/lxc4-$(1)/install
	$(INSTALL_DIR) $$(1)/opt/prplos/$(3)
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)$(3)/lxc-$(1) \
		$$(1)/opt/prplos/$(3)/
  endef

  $$(eval $$(call BuildPackage,lxc4-$(1)))
endef


$(eval $(call BuildPackage,lxc4))
$(eval $(call BuildPackage,lxc4-common))
$(eval $(call BuildPackage,lxc4-hooks))
$(eval $(call BuildPackage,lxc4-configs))
$(eval $(call BuildPackage,lxc4-templates))
$(eval $(call BuildPackage,liblxc4))
$(eval $(call BuildPackage,lxc4-init))
$(eval $(call BuildPackage,lxc4-auto))
$(eval $(call BuildPackage,lxc4-unprivileged))
$(foreach u,$(LXC4_APPLETS_BIN),$(eval $(call GenPlugin,$(u),$(DEPENDS_APPLETS),"/usr/bin")))
$(foreach u,$(LXC4_APPLETS_LIB),$(eval $(call GenPlugin,$(u),$(DEPENDS_APPLETS),"/usr/lib/lxc")))
$(foreach u,$(LXC4_SCRIPTS),$(eval $(call GenPlugin,$(u),,"/usr/bin")))
