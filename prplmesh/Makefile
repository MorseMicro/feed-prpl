include $(TOPDIR)/rules.mk

PKG_NAME:=prplmesh
PKG_VERSION:=1.12.4
PKG_RELEASE:=1
PKG_REV:=$(PKG_VERSION)

PKG_SOURCE_VERSION:=v1.12.4
PKG_SOURCE_URL:=https://github.com/MorseMicro/prplmesh
PKG_SOURCE_PROTO:=git
PKG_MIRROR_HASH:=97f4b6843a60174a0bc4b81d977dc4d1b501c724e691ac2c69a34aeabb268deb

PKG_BUILD_DEPENDS+=wpa_supplicant_s1g
HOST_BUILD_DEPENDS:=python3/host
include $(INCLUDE_DIR)/host-build.mk

#Installing host-side Python package pyyaml required for prplmesh
PYTHON3_PKG_BUILD:=0
HOST_PYTHON3_PACKAGE_BUILD_DEPENDS:=./pyyaml.txt
include $(TOPDIR)/feeds/packages/lang/python/pypi.mk

# PKG_BUILD_PARALLEL:=1
# PKG_CONFIG_DEPENDS:= \
# 	CONFIG_WIRELESS_STA \
# 	CONFIG_PACKAGE_libamxb

CMAKE_BINARY_SUBDIR:=build

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

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
		+ebtables \
		+wpa_supplicant_s1g \
		+hostapd_s1g \
		+@MORSE_HOSTAPD_S1G_EAP \
		+@MORSE_HOSTAPD_S1G_ACS \
		+@BUSYBOX_CONFIG_GETOPT \
		+@BUSYBOX_CONFIG_FEATURE_GETOPT_LONG \
		+libwpa_client \
		+@MORSE_WPA_SUPPLICANT_S1G_MESH_NETWORKING \
		+@MORSE_WPA_SUPPLICANT_S1G_EAP

		# prplmesh has more dependency on hostapd_s1g and wpa_supplicant_s1g configs,
		# but since we already had them enabled by default in the make file and we don't
		# have a config for them, I don't add them to DEPENDS. these configs include:
		# MORSE_WPA_SUPPLICANT_S1G_WPS  MORSE_WPA_SUPPLICANT_S1G_CLI
		# MORSE_WPA_SUPPLICANT_S1G_AP_SUPPORT MORSE_HOSTAPD_S1G_WPS

#	The ambiorix library is optional, select it if libamxb is selected:
	DEPENDS+= \
		+libamxb \
		+libamxc \
		+libamxd \
		+libamxo \
		+libamxp \
		+mod-amxb-ubus

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

CMAKE_OPTIONS += \
	-DCMAKE_INSTALL_PREFIX=/opt/prplmesh \
	-DPLATFORM_BUILD_DIR=$(BUILD_DIR) \
	-DPLATFORM_STAGING_DIR=$(STAGING_DIR) \
	-DPLATFORM_INCLUDE_DIR=$(STAGING_DIR)/usr/include \
	-DTARGET_PLATFORM="MorseMicro" \
	-DTARGET_PLATFORM_TYPE="EHK01" \
	-DBEEROCKS_BRIDGE_IFACE="br-prpl" \
	-DBWL_TYPE="NL80211"

CMAKE_OPTIONS+=-DPython3_EXECUTABLE=$(STAGING_DIR_HOSTPKG)/bin/python3

ifeq ($(wildcard $(PKG_BUILD_DIR)/.source_dir),)
	CMAKE_OPTIONS += -DPRPLMESH_REVISION=$(PKG_REV)
	CMAKE_OPTIONS += -DPRPLMESH_VERSION=$(PKG_VERSION)
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
ifeq ($(CONFIG_PRPLMESH_NBAPI),y)
	CMAKE_OPTIONS += -DENABLE_NBAPI=ON
	PKG_BUILD_DEPENDS += libamxc libamxp libamxd libamxb libamxo
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

# CMakeCache.txt has slipped into initial tarball release. Remove
# here, to be fixed in another package release.
define Build/Configure
	rm $(PKG_BUILD_DIR)/CMakeCache.txt -rf
	$(call Py3Build/InstallBuildDepends)
	$(call Build/Configure/Default)
endef

define Package/prplmesh/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DIR) $(1)/opt/prplmesh
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/etc/uci-defaults/* $(1)/etc/uci-defaults/
	$(SED) '/CONFIG_CONTROLLER_ROOT_DM=/ c\CONFIG_CONTROLLER_ROOT_DM=$(CONTROLLER_ROOT_DM)' $(1)/etc/init.d/prplmesh
	$(INSTALL_BIN) ./scripts/morse-check-prplmesh.sh $(1)/usr/sbin/
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/bin $(1)/opt/prplmesh/
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/scripts $(1)/opt/prplmesh/
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/lib/*.so* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/share $(1)/opt/prplmesh/
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/config $(1)/opt/prplmesh/
	$(INSTALL_BIN) ./files/opt/prplmesh/scripts/* $(1)/opt/prplmesh/scripts/
endef

define Package/prplmesh-unit-tests/install
	$(INSTALL_DIR) $(1)/opt/prplmesh/tests
	$(CP) $(PKG_INSTALL_DIR)/opt/prplmesh/tests $(1)/opt/prplmesh/
endef

$(eval $(call HostBuild))
$(eval $(call BuildPackage,prplmesh))
$(eval $(call BuildPackage,prplmesh-unit-tests))
