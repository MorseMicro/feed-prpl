include $(TOPDIR)/rules.mk

PKG_NAME:=prplmesh
PKG_VERSION:=1.7.3
PKG_RELEASE:=1
PKG_REV:=$(PKG_VERSION)

PKG_SOURCE:=prplMesh-$(PKG_REV).tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/prplmesh/prplMesh/-/archive/$(PKG_REV)
PKG_HASH:=fbfae6320c74f0219d49228af6872e43c24517baaffac929eed198290307367c
PKG_BUILD_DIR:=$(BUILD_DIR)/prplMesh-$(PKG_REV)

PKG_CONFIG_DEPENDS:= \
	CONFIG_WIRELESS_STA \
	CONFIG_TARGET_intel_mips \
	CONFIG_PACKAGE_libamxb

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/prplmesh
	SECTION:=net
	CATEGORY:=Network
	TITLE:=prplmesh
	URL:=https://gitlab.com/prpl-foundation/prplmesh/prplMesh/README.md
	MAINTAINER:=prplfoundation
	DEPENDS:=+libstdcpp +libpthread +librt +libjson-c +libreadline +libopenssl +libnl +uci +ubus +ubox +ebtables
#	intel_mips specific dependencies:
	DEPENDS+= +TARGET_intel_mips:dwpal_6x-uci +TARGET_intel_mips:iwlwav-hostap-uci +TARGET_intel_mips:libsafec3 +TARGET_intel_mips:bridge-ugw
#	non-intel_mips dependencies:
	DEPENDS+= +!TARGET_intel_mips:hostapd-openssl +!TARGET_intel_mips:hostapd-utils +!TARGET_intel_mips:wpa-supplicant-openssl
#	The ambiorix library is optional, select it if libamxb is selected:
	DEPENDS+= +PACKAGE_libamxb:libamxb +PACKAGE_libamxb:libamxc +PACKAGE_libamxb:libamxd +PACKAGE_libamxb:libamxo +PACKAGE_libamxb:libamxp
endef

define Package/prplmesh/config
	source "$(SOURCE)/Config.in"
endef

CMAKE_SOURCE_DIR:=
CMAKE_OPTIONS+= \
	-DTARGET_PLATFORM=openwrt \
	-DCMAKE_INSTALL_PREFIX=/opt/prplmesh \
	-DPLATFORM_BUILD_DIR=$(BUILD_DIR) \
	-DPLATFORM_STAGING_DIR=$(STAGING_DIR) \
	-DPLATFORM_INCLUDE_DIR=$(STAGING_DIR)/usr/include \
	-DBUILD_TESTS=ON \
	$(if $(CONFIG_PACKAGE_libamxb), -DENABLE_NBAPI=ON) \
	-H. -B./build

ifeq ($(wildcard $(PKG_BUILD_DIR)/.source_dir),)
	CMAKE_OPTIONS += -DPRPLMESH_REVISION=$(PKG_REV)
endif

ifeq ($(CONFIG_TARGET_intel_mips),y)
	CMAKE_OPTIONS+= -DBWL_TYPE=DWPAL \
		-DTARGET_PLATFORM_TYPE=ugw \
		-DCMAKE_FIND_ROOT_PATH="${STAGING_DIR}/opt/intel;${CMAKE_FIND_ROOT_PATH}"
else
	CMAKE_OPTIONS+= -DBWL_TYPE=NL80211 \
		-DTARGET_PLATFORM_TYPE=turris-omnia
endif

Build/Compile:=cmake --build $(PKG_BUILD_DIR)/build -- $(MAKE_INSTALL_FLAGS) install -j
Build/Install:=
Build/Clean:=cd $(PKG_BUILD_DIR) && rm -rf .built .configured_* .prepared_* build/ ipkg-* || true

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/lib/libbml* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/include/beerocks/bml $(1)/usr/include/
endef

define Package/prplmesh/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DIR) $(1)/opt/prplmesh
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/etc/uci-defaults/* $(1)/etc/uci-defaults/
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/bin $(1)/opt/prplmesh/
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/scripts $(1)/opt/prplmesh/
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/lib/*.so* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/share $(1)/opt/prplmesh/
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/config $(1)/opt/prplmesh/
endef

$(eval $(call BuildPackage,prplmesh))
