include $(TOPDIR)/rules.mk

PKG_NAME:=cwmp

PKG_LICENSE:=GPLv2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/prplwrt/ucwmp.git
PKG_MIRROR_HASH:=74cf30fa87afcb67cbbcccbe442b48e8c4aa036acaa2fadac6023486013c52b6
PKG_SOURCE_VERSION:=be8956da903a441d8736fc4533cbc10f4e4edbc1
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz

PKG_MAINTAINER:=Felix Fietkau <nbd@openwrt.org>

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

CMAKE_INSTALL:=1

define Package/ucwmp
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Tiny CWMP (TR-069) client
  ABI_VERSION:=$(PKG_VERSION)
  DEPENDS:=+libubox +uhttpd +libroxml +libuclient +uclient-fetch \
	+libustream-mbedtls +ca-certificates \
	+UCWMP_BACKEND_SCAL:scal-plugin-json \
	+UCWMP_BACKEND_USP:uspd \
	+UCWMP_BACKEND_BBFD:bbfd
endef

define Package/ucwmp/config
config UCWMP_BACKEND_SCAL
	bool "Use scald as backend"
	default n

config UCWMP_BACKEND_USP
	bool "Use uspd as backend"
	default n

config UCWMP_BACKEND_BBFD
	bool "Use bbfd as backend"
	default y
endef

ifeq ($(CONFIG_UCWMP_BACKEND_SCAL),y)
	CMAKE_OPTIONS += -DBACKEND=scal
endif
ifeq ($(CONFIG_UCWMP_BACKEND_USP),y)
	CMAKE_OPTIONS += -DBACKEND=usp
endif
ifeq ($(CONFIG_UCWMP_BACKEND_BBFD),y)
	CMAKE_OPTIONS += -DBACKEND=bbfd
endif

define Package/ucwmp/conffiles
/etc/config/cwmp
/etc/cwmp-cache.json
/etc/cwmp-startup.json
endef

define Package/ucwmp/install
	$(INSTALL_DIR) $(1)/usr/sbin $(1)/usr/libexec
	$(CP) $(PKG_INSTALL_DIR)/usr/sbin/* $(1)/usr/sbin/
	$(CP) $(PKG_INSTALL_DIR)/usr/libexec/* $(1)/usr/libexec/
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,ucwmp))
