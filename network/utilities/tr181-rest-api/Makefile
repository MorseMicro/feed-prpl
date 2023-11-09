include $(TOPDIR)/rules.mk

PKG_NAME:=tr181-rest-api
PKG_VERSION:=v0.1.1
PKG_RELEASE:=1
PKG_LICENSE:=BSD-2-Clause-Patent

include $(INCLUDE_DIR)/package.mk

define Package/tr181-rest-api
  TITLE:=TR181 REST API
  CATEGORY:=prpl Foundation
  SUBMENU:=Utilities
  DEPENDS:=+amx-fcgi +lighttpd +lighttpd-mod-fastcgi +lighttpd-mod-auth +lighttpd-mod-authn_file +lighttpd-mod-setenv
endef

define Package/tr181-rest-api/conffiles
/etc/lighttpd/prplos.user
/etc/lighttpd/conf.d/50-prplos-auth.conf
/etc/lighttpd/conf.d/60-amx-fcgi.conf
endef

define Package/tr181-rest-api/description
 This package contains TR181 based REST API powered by lighttpd and
 using amx-fcgi module.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Compile/Default

endef
Build/Compile = $(Build/Compile/Default)

define Package/tr181-rest-api/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,tr181-rest-api))
