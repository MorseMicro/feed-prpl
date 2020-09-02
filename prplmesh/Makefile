include $(TOPDIR)/rules.mk

PKG_NAME:=prplmesh
PKG_RELEASE:=1.4.0
PKG_SOURCE_URL:=https://github.com/prplfoundation/prplMesh.git
PKG_MIRROR_HASH:=c60b9d467608754a6f96383a84ecadc394d3b59eb6ffb392ff52e900234856e1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=eb2327daaff7c4e5071dcfb9ddd75c88f2b747a7
PKG_VERSION:=$(PKG_RELEASE)-$(PKG_SOURCE_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/prplmesh/Default
	SECTION:=net
  	CATEGORY:=Network
	TITLE:=prplmesh
	URL:=https://github.com/prplfoundation/prplMesh/README.md
	MAINTAINER:=prplfoundation
	DEPENDS:=+libstdcpp +libpthread +librt +libjson-c +libreadline +libopenssl +libnl +uci +ubus +ubox +libzmq-nc +ebtables
endef

define Package/prplmesh-dwpal
$(call Package/prplmesh/Default)
	TITLE+= - DWPAL
	VARIANT:=dwpal
	PROVIDES:=prplmesh
	DEPENDS+= @TARGET_intel_mips +dwpal_6x-uci +iwlwav-hostap-uci +@WIRELESS_STA +libsafec3 +bridge-ugw
endef

define Package/prplmesh-nl80211
$(call Package/prplmesh/Default)
	TITLE+= - NL80211
	VARIANT:=nl80211
	PROVIDES:=prplmesh
	DEPENDS+= +hostapd-openssl +hostapd-utils +wpa-supplicant-openssl
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
	-DMSGLIB=zmq \
	-H. -B./build

ifeq ($(wildcard $(PKG_BUILD_DIR)/.source_dir),)
	CMAKE_OPTIONS += -DPRPLMESH_REVISION=$(PKG_SOURCE_VERSION)
endif

ifeq ($(BUILD_VARIANT),dwpal)
	CMAKE_OPTIONS+= -DBWL_TYPE=DWPAL \
		-DTARGET_PLATFORM_TYPE=ugw \
        -DCMAKE_FIND_ROOT_PATH="${STAGING_DIR}/opt/intel;${CMAKE_FIND_ROOT_PATH}"

endif

ifeq ($(BUILD_VARIANT),nl80211)
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

define Package/prplmesh-dwpal/install
$(call Package/prplmesh/install,$(1))
endef

define Package/prplmesh-nl80211/install
$(call Package/prplmesh/install,$(1))
endef

$(eval $(call BuildPackage,prplmesh-dwpal))
$(eval $(call BuildPackage,prplmesh-nl80211))
