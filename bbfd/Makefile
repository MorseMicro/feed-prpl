include $(TOPDIR)/rules.mk

PKG_NAME:=bbfd
PKG_VERSION:=1.0.5
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/prplwrt/bbfd.git
PKG_SOURCE_VERSION=1c91d6135ac8b3387b2f83336c992a5fe0f846c0
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz

PKG_MAINTAINER:=Daniel Danzberger <daniel@dd-wrt.com>

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/bbfd
  CATEGORY:=Purple
  TITLE:=Libbbf ubus frontend
  DEPENDS:=+libubox +ubus +libbbfdm
endef

define Package/bbfd/description
 Ubus based frontend for iopsys bbf tr-x library
endef

define Package/bbfd/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/bbfd.init $(1)/etc/init.d/bbfd
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bbfd $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,bbfd))
