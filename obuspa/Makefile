include $(TOPDIR)/rules.mk

PKG_NAME:=obuspa
PKG_VERSION:=3.0.0
PKG_RELEASE:=1

PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/prplwrt/obuspa.git
PKG_MIRROR_HASH:=1e3dbc987955dcefae3fc6397bf45c850e583aea29cda5ed22d76952fa6e6656
PKG_SOURCE_VERSION:=4b66744031731c7198d73b01b50cb5ec918bfa28

PKG_MAINTAINER:=Daniel Danzberger <daniel@dd-wrt.com>

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/obuspa/config
  config OBUSPA_MQTT
     depends on PACKAGE_obuspa
     bool "  Enable MQTT Message Support"
        default n

  config OBUSPA_COAP
     depends on PACKAGE_obuspa
     bool "  Enable COAP Message Support"
        default n
endef

define Package/obuspa
  CATEGORY:=Purple
  TITLE:=USP agent
  DEPENDS:=+libopenssl +libcurl +zlib +libsqlite3 \
	+libubox +libubus +libblobmsg-json +bbfd \
	+OBUSPA_MQTT:libmosquitto
endef

define Package/obuspa/description
  Boardband forum USP Agent reference implementation
endef

ifeq ($(CONFIG_OBUSPA_MQTT),y)
	CONFIGURE_ARGS += --enable-mqtt
else
	CONFIGURE_ARGS += --disable-mqtt
endif

ifeq ($(CONFIG_OBUSPA_COAP),y)
	CONFIGURE_ARGS += --enable-coap
else
	CONFIGURE_ARGS += --disable-coap
endif

TARGET_CFLAGS += -D_GNU_SOURCE

ifneq ($(CONFIG_USE_MUSL),)
TARGET_CFLAGS += -DUSE_MUSL
endif

define Package/obuspa/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/obuspa $(1)/usr/sbin/
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,obuspa))

