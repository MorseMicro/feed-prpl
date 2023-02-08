include $(TOPDIR)/rules.mk

PKG_NAME:=prplmesh
PKG_VERSION:=4.0.1
PKG_RELEASE:=1
PKG_REV:=$(PKG_VERSION)

PKG_SOURCE:=prplMesh-$(PKG_REV).tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/prplmesh/prplMesh/-/archive/$(PKG_REV)
PKG_HASH:=7be3c85fbee85b494d9e3786883a0f72606c9247fc6fe43d46c06f4b12239364
PKG_BUILD_DIR:=$(BUILD_DIR)/prplMesh-$(PKG_REV)

PKG_BUILD_PARALLEL:=1
PKG_CONFIG_DEPENDS:= \
	CONFIG_WIRELESS_STA \
	CONFIG_TARGET_intel_mips \
	CONFIG_TARGET_brcmbca \
	CONFIG_USE_PRPLMESH_WHM \
	CONFIG_PACKAGE_libamxb

CMAKE_BINARY_SUBDIR:=build

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/prplmesh/default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=PrplMesh
	TITLE:=prplmesh
	URL:=https://gitlab.com/prpl-foundation/prplmesh/prplMesh/-/blob/master/README.md
	MAINTAINER:=prplfoundation
endef

define Package/prplmesh
	$(Package/prplmesh/default)
	DEPENDS:= \
		+libstdcpp \
		+libpthread \
		+librt \
		+libjson-c \
		+libreadline \
		+libopenssl \
		+libnl \
		+uci \
		+ubus \
		+ubox \
		+ebtables
#	intel_mips specific dependencies:
	DEPENDS+= \
		+TARGET_intel_mips:dwpal_6x-uci \
		+TARGET_intel_mips:iwlwav-hostap-uci \
		+TARGET_intel_mips:libsafec3 \
		+TARGET_intel_mips:bridge-ugw
#	non-intel_mips neither broadcom dependencies:
	DEPENDS+= \
		+!(TARGET_intel_mips||TARGET_brcmbca):hostapd-openssl \
		+!(TARGET_intel_mips||TARGET_brcmbca):hostapd-utils \
		+!(TARGET_intel_mips||TARGET_brcmbca):wpa-supplicant-openssl
#	The ambiorix library is optional, select it if libamxb is selected:
	DEPENDS+= +PACKAGE_libamxb:libamxb \
		+PACKAGE_libamxb:libamxc \
		+PACKAGE_libamxb:libamxd \
		+PACKAGE_libamxb:libamxo \
		+PACKAGE_libamxb:libamxp \
		+PACKAGE_libamxb:mod-amxb-ubus
#	pwhm dependency:
	DEPENDS+= +USE_PRPLMESH_WHM:pwhm
endef

define Package/prplmesh-unit-tests
	$(Package/prplmesh/default)
	TITLE+= - unit tests
	DEPENDS:=+prplmesh
endef

define Package/prplmesh/config
	source "$(SOURCE)/Config.in"
endef

CMAKE_OPTIONS+= \
	-DTARGET_PLATFORM=openwrt \
	-DCMAKE_INSTALL_PREFIX=/opt/prplmesh \
	-DPLATFORM_BUILD_DIR=$(BUILD_DIR) \
	-DPLATFORM_STAGING_DIR=$(STAGING_DIR) \
	-DPLATFORM_INCLUDE_DIR=$(STAGING_DIR)/usr/include \
	-DBUILD_TESTS=ON \

ifeq ($(wildcard $(PKG_BUILD_DIR)/.source_dir),)
	CMAKE_OPTIONS += -DPRPLMESH_REVISION=$(PKG_REV)
endif

CONTROLLER_ROOT_DM:=$(CONFIG_PRPL_CONTROLLER_ROOT_PATH)

ifeq ($(CONFIG_PACKAGE_libamxb),y)
	CMAKE_OPTIONS += -DENABLE_NBAPI=ON
	CMAKE_OPTIONS += -DCONTROLLER_ROOT_DM="$(CONTROLLER_ROOT_DM)"
ifeq ($(CONFIG_PACKAGE_mod-amxb-ubus),y)
	CMAKE_OPTIONS += -DUBUS_SOCK="-DAMBIORIX_BACKEND_PATH=\\\"/usr/bin/mods/amxb/mod-amxb-ubus.so\\\" -DAMBIORIX_BUS_URI=\\\"ubus:/var/run/ubus.sock\\\""
ifeq ($(CONFIG_USE_PRPLMESH_WHM),y)
	CMAKE_OPTIONS += -DUSE_PRPLMESH_WHM=ON
	CMAKE_OPTIONS += -DWBAPI_SOCK="-DAMBIORIX_WBAPI_BACKEND_PATH=\\\"/usr/bin/mods/amxb/mod-amxb-ubus.so\\\" -DAMBIORIX_WBAPI_BUS_URI=\\\"ubus:/var/run/ubus.sock\\\""
endif
endif
endif

ifeq ($(CONFIG_TARGET_intel_mips),y)
	CMAKE_OPTIONS+= -DBWL_TYPE=DWPAL \
		-DTARGET_PLATFORM_TYPE=ugw \
		-DCMAKE_FIND_ROOT_PATH="${STAGING_DIR}/opt/intel;${CMAKE_FIND_ROOT_PATH}"
else
	CMAKE_OPTIONS+= -DBWL_TYPE=NL80211 \
		-DTARGET_PLATFORM_TYPE=turris-omnia
endif

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
	$(SED) '/CONFIG_CONTROLLER_ROOT_DM=/ c\CONFIG_CONTROLLER_ROOT_DM=$(CONTROLLER_ROOT_DM)' $(1)/etc/init.d/prplmesh
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/bin $(1)/opt/prplmesh/
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/scripts $(1)/opt/prplmesh/
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/lib/*.so* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/share $(1)/opt/prplmesh/
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/config $(1)/opt/prplmesh/
endef

define Package/prplmesh-unit-tests/install
	$(INSTALL_DIR) $(1)/opt/prplmesh/tests
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/tests $(1)/opt/prplmesh/
endef

$(eval $(call BuildPackage,prplmesh))
$(eval $(call BuildPackage,prplmesh-unit-tests))
