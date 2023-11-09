include $(TOPDIR)/rules.mk

PKG_NAME:=libpcp
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=1c783fb83516ebf10ebebd023a490255d35f34fd
PKG_SOURCE_DATE:=2022-02-22
PKG_SOURCE_URL:=https://github.com/libpcp/pcp
PKG_MIRROR_HASH:=6ddc6b45d44435f1c530687499429b1479247cdd235730913abb77ba163d778a

PKG_LICENSE:=BSD-2-Clause
PKG_LICENSE_FILES:=COPYING

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

CONFIGURE_ARGS += --disable-server --disable-app

define Package/$(PKG_NAME)
  SECTION:=libs
  CATEGORY:=prpl Foundation
  SUBMENU:=Libraries
  TITLE:=PCP client library implements client side of PCP
  URL:=https://github.com/libpcp/pcp
  DEPENDS:=
endef

define Package/$(PKG_NAME)/description
  PCP client library implements client side of PCP (RFC 6887) and NATPMP(RFC
  6886) protocols.  Switch to NATPMP is done automatically by version
  negotiation.  This library enables any network application to manage network
  edge device (e.g. to create NAT mapping or ask router for specific flow
  treatment).
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/pcp-client
	$(CP) $(PKG_INSTALL_DIR)/usr/include/pcp-client $(1)/usr/include
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/*.so* $(1)/usr/lib/
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/*.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
