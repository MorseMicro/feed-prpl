include $(TOPDIR)/rules.mk

PKG_NAME:=board-config-haze
PKG_VERSION:=0.0.1
PKG_RELEASE:=1
PKG_LICENSE:=BSD-2-Clause-Patent

include $(INCLUDE_DIR)/package.mk

define Package/board-config-haze
  TITLE:=Haze board configuration
  CATEGORY:=prpl Foundation
  SUBMENU:=Utilities
  DEPENDS:=@TARGET_ipq807x_generic_DEVICE_prpl_haze
endef

define Package/board-config-haze/description
 This package contains Haze board configuration files.
endef

define Build/Compile
endef

define Package/board-config-haze/install
	$(INSTALL_DIR) $(1)/etc
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,board-config-haze))
