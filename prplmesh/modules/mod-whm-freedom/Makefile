include $(TOPDIR)/rules.mk

PKG_NAME:=mod-whm-freedom
PKG_VERSION:=0.0.1
PKG_RELEASE:=1
PKG_LICENSE:=BSD-2-Clause-Patent

include $(INCLUDE_DIR)/package.mk

define Package/mod-whm-freedom
  TITLE:=Freedom board module for wireless hardware manager
  CATEGORY:=prpl Foundation
  SUBMENU:=prplMesh
  DEPENDS:=@TARGET_ipq95xx_generic_DEVICE_prpl_freedom
endef

define Package/mod-whm-freedom/description
 This package contains Freedom board ODL configuration files for wireless hardware manager
endef

define Build/Compile
endef

define Package/mod-whm-freedom/install
	$(INSTALL_DIR) $(1)/etc
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,mod-whm-freedom))
