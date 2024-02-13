include $(TOPDIR)/rules.mk

PKG_NAME:=prplmesh
PKG_VERSION:=4.2.2
PKG_RELEASE:=1
PKG_REV:=$(PKG_VERSION)

PKG_SOURCE:=prplMesh-$(PKG_REV).tar.gz
PKG_SOURCE_URL:=https://gitlab.com/prpl-foundation/prplmesh/prplMesh/-/archive/$(PKG_REV)
PKG_HASH:=72bd74e1efd5e8c7b9661ebfbdb72d6152b56daaac071ce5aacd132bedf875cf
PKG_BUILD_DIR:=$(BUILD_DIR)/prplMesh-$(PKG_REV)

PKG_BUILD_PARALLEL:=1
PKG_CONFIG_DEPENDS:= \
	CONFIG_WIRELESS_STA \
	CONFIG_TARGET_intel_x86 \
	CONFIG_TARGET_intel_mips \
	CONFIG_TARGET_brcmbca \
	CONFIG_USE_PRPLMESH_WHM \
	CONFIG_PRPLMESH_ENABLE_UNIT_TESTS \
	CONFIG_PRPLMESH_ENABLE_AMBIORIX_UBUS_BACKEND

CMAKE_BINARY_SUBDIR:=build

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/prplmesh/default
	SECTION:=net
	CATEGORY:=prpl Foundation
	SUBMENU:=prplMesh
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
		+libopenssl \
		+libnl \
		+uci \
		+ubus \
		+ubox \
		+ebtables
#	intel_mips and intel_x86 specific dependencies:
	DEPENDS+= \
		+TARGET_intel_mips:dwpal_6x-uci \
		+TARGET_intel_mips:iwlwav-hostap-uci \
		+TARGET_intel_mips:libsafec3 \
		+TARGET_intel_mips:bridge-ugw \
		+(TARGET_intel_x86&&PACKAGE_mod-whm):dwpal_6x-uci-osp \
		+(TARGET_intel_x86&&PACKAGE_mod-whm):iwlwav-hostap-ng-uci \
		+(TARGET_intel_x86&&PACKAGE_mod-whm-debug):dwpal_6x-uci-osp-debug \
		+(TARGET_intel_x86&&PACKAGE_mod-whm-debug):iwlwav-hostap-ng-uci-debug \
		+TARGET_intel_x86:libsafec3 \
		+TARGET_intel_x86:bridge
#	non-intel_x86 neither non-intel_mips neither broadcom dependencies:
	DEPENDS+= \
		+!(TARGET_intel_x86||TARGET_intel_mips||TARGET_brcmbca||TARGET_ipq95xx):hostapd-openssl \
		+!(TARGET_intel_x86||TARGET_intel_mips||TARGET_brcmbca||TARGET_ipq95xx):wpa-supplicant-openssl
	DEPENDS+= \
		+TARGET_ipq95xx:hostapd-qca-openssl \
		+TARGET_ipq95xx:wpa-supplicant-qca-openssl
	DEPENDS+= \
		+PRPLMESH_ENABLE_AMBIORIX_UBUS_BACKEND:libamxb \
		+PRPLMESH_ENABLE_AMBIORIX_UBUS_BACKEND:libamxrt \
		+PRPLMESH_ENABLE_AMBIORIX_UBUS_BACKEND:mod-pcm-svc \
		+PRPLMESH_ENABLE_AMBIORIX_UBUS_BACKEND:pcm-manager \
		+PRPLMESH_ENABLE_AMBIORIX_UBUS_BACKEND:mod-amxb-ubus
#	pwhm dependency:
	DEPENDS+= +USE_PRPLMESH_WHM:pwhm
endef

define Package/prplmesh-unit-tests
	$(Package/prplmesh/default)
	TITLE+= - unit tests
	DEPENDS:=+prplmesh +@PRPLMESH_ENABLE_UNIT_TESTS
endef

define Package/prplmesh/config
	source "$(SOURCE)/Config.in"
endef

CMAKE_OPTIONS+= \
	-DTARGET_PLATFORM=openwrt \
	-DCMAKE_INSTALL_PREFIX=/opt/prplmesh \
	-DPLATFORM_BUILD_DIR=$(BUILD_DIR) \
	-DPLATFORM_STAGING_DIR=$(STAGING_DIR) \
	-DPLATFORM_INCLUDE_DIR=$(STAGING_DIR)/usr/include

ifeq ($(wildcard $(PKG_BUILD_DIR)/.source_dir),)
	CMAKE_OPTIONS += -DPRPLMESH_REVISION=$(PKG_REV)
endif

CMAKE_OPTIONS+=-DPython3_EXECUTABLE=$(STAGING_DIR_HOST)/bin/python3
$(eval $(call TestHostCommand,python3-yaml, \
	Please install the Python3 YAML module, \
	$(STAGING_DIR_HOST)/bin/python3 -c 'import yaml'))

CONTROLLER_ROOT_DM:=$(CONFIG_PRPL_CONTROLLER_ROOT_PATH)

ifeq ($(CONFIG_PRPLMESH_ENABLE_AMBIORIX_UBUS_BACKEND),y)
	CMAKE_OPTIONS += -DENABLE_NBAPI=ON
	CMAKE_OPTIONS += -DCONTROLLER_ROOT_DM="$(CONTROLLER_ROOT_DM)"
	CMAKE_OPTIONS += -DUBUS_SOCK="-DAMBIORIX_BACKEND_PATH=\\\"/usr/bin/mods/amxb/mod-amxb-ubus.so\\\" -DAMBIORIX_BUS_URI=\\\"ubus:/var/run/ubus/ubus.sock\\\""
ifeq ($(CONFIG_USE_PRPLMESH_WHM),y)
	CMAKE_OPTIONS += -DUSE_PRPLMESH_WHM=ON
	CMAKE_OPTIONS += -DWBAPI_SOCK="-DAMBIORIX_WBAPI_BACKEND_PATH=\\\"/usr/bin/mods/amxb/mod-amxb-ubus.so\\\" -DAMBIORIX_WBAPI_BUS_URI=\\\"ubus:/var/run/ubus/ubus.sock\\\""
endif
endif

ifeq ($(CONFIG_TARGET_intel_mips),y)
	CMAKE_OPTIONS+= -DBWL_TYPE=DWPAL \
		-DTARGET_PLATFORM_TYPE=ugw \
		-DCMAKE_FIND_ROOT_PATH="${STAGING_DIR}/opt/intel;${CMAKE_FIND_ROOT_PATH}"
else ifeq ($(CONFIG_TARGET_intel_x86),y)
	CMAKE_OPTIONS+= -DBWL_TYPE=WHM \
		-DTARGET_PLATFORM_TYPE=ugw \
		-DCMAKE_FIND_ROOT_PATH="${STAGING_DIR}/opt/intel;${CMAKE_FIND_ROOT_PATH}"
else
	CMAKE_OPTIONS+= -DBWL_TYPE=NL80211 \
		-DTARGET_PLATFORM_TYPE=turris-omnia
endif

ifeq ($(CONFIG_PRPLMESH_ENABLE_UNIT_TESTS),y)
	CMAKE_OPTIONS += -DBUILD_TESTS=ON
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
