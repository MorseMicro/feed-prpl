include $(TOPDIR)/rules.mk

PKG_NAME:=libocispec
PKG_VERSION:=2021-05-15
SHORT_DESCRIPTION:=A library for easily parsing of OCI runtime and OCI image files from C

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=46b870958a39547026c5dc9a044951e232ecbd9c
PKG_SOURCE_URL:=https://github.com/containers/libocispec.git
PKG_MIRROR_HASH:=11294acb85705cc4ce0176f18239de4e9ad1c48e3f818fcfa239dbbc20c2da40
PKG_MAINTAINER:=Soft At Home <support.opensource@softathome.com>
PKG_LICENSE:=SAH BSD-2-Clause-Patent
PKG_LICENSE_FILES:=LICENSE.SAH LICENSE.BSD

PKG_RELEASE:=1

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	CATEGORY:=prpl Foundation
	SUBMENU:=Libraries
	TITLE:=$(SHORT_DESCRIPTION)
	URL:=https://github.com/containers/libocispec.git
	DEPENDS += +yajl
	MENU:=1
endef

define Package/$(PKG_NAME)/description
	A library for easily parsing of OCI runtime and OCI image files from C
endef

IMAGE_SPEC_VER:=1.0.1
IMAGE_SPEC_BUNDLE:=image-spec-$(IMAGE_SPEC_VER)
IMAGE_SPEC_ARCHIVE:=$(IMAGE_SPEC_BUNDLE).zip
define Download/imagespec
	FILE:=$(IMAGE_SPEC_ARCHIVE)
	URL_FILE:=v$(IMAGE_SPEC_VER).zip
	URL:=https://github.com/opencontainers/image-spec/archive/refs/tags/
	HASH:=b60fba7fe7b81a92d5fa2bf60ff9523e9024ecb67a899fb822e36c0392a5b7aa
endef

$(eval $(call Download,imagespec))

RUNTIME_SPEC_VER:=1.0.2
RUNTIME_SPEC_BUNDLE:=runtime-spec-$(RUNTIME_SPEC_VER)
RUNTIME_SPEC_ARCHIVE:=$(RUNTIME_SPEC_BUNDLE).zip
define Download/runtimespec
	FILE:=$(RUNTIME_SPEC_ARCHIVE)
	URL_FILE:=v$(RUNTIME_SPEC_VER).zip
	URL:=https://github.com/opencontainers/runtime-spec/archive/refs/tags/
	HASH:=8b941f5458f63ee179cd226176310c04864e656fb708d23151a05f7e80513f26
endef

$(eval $(call Download,runtimespec))

define Build/Prepare
	$(Build/Prepare/Default)
	cd $(PKG_BUILD_DIR) && \
		rm -Rf image-spec && \
		unzip $(DL_DIR)/$(IMAGE_SPEC_ARCHIVE) && \
		mv $(IMAGE_SPEC_BUNDLE) image-spec
	cd $(PKG_BUILD_DIR) && \
		rm -Rf runtime-spec && \
		unzip $(DL_DIR)/$(RUNTIME_SPEC_ARCHIVE) && \
		mv $(RUNTIME_SPEC_BUNDLE) runtime-spec
endef

CONFIGURE_ARGS += --libdir=/usr/lib --includedir=/usr/include --disable-dependency-tracking --disable-static
define Build/Configure
	$(call Build/Configure/Default)
endef

define Package/$(PKG_NAME)/install
	$(call Build/Install/Default)
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libocispec.so* $(1)/usr/lib/
endef

define Build/InstallDev
	$(call Build/Install/Default)
	$(INSTALL_DIR) $(1)/usr/include/libocispec
	$(CP) $(PKG_INSTALL_DIR)/usr/include/libocispec/*.h $(1)/usr/include/libocispec
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libocispec.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
