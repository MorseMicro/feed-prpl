#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=miniupnpd-prpl
PKG_VERSION:=2.3.3
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://miniupnp.tuxfamily.org/files
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_HASH:=6fd7019f936ff88c41e7c822f46f10b51bd72d665978f6586483de75b30c36bf

PKG_MAINTAINER:=
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE
PKG_CPE_ID:=cpe:/a:miniupnp_project:miniupnpd

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/version.mk

define Package/miniupnpd-prpl
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:= \
	+libcap-ng \
	+libmnl \
	+libuuid \
	+IPV6:ip6tables \
	+IPV6:libip6tc \
	+iptables \
	+libip4tc \
	+libnetfilter-conntrack
  PROVIDES:=miniupnpd-iptables
  CONFLICTS:=miniupnpd-iptables miniupnpd-nftables
  TITLE:=Lightweight UPnP IGD, NAT-PMP & PCP daemon
  SUBMENU:=Firewall
  URL:=https://miniupnp.tuxfamily.org/
endef

define Package/miniupnpd-nftables
  $(call Package/miniupnpd/Default)
  DEPENDS+= \
	+libnftnl
  TITLE+= (nftables)
  VARIANT:=nftables
  DEFAULT_VARIANT:=1
  CONFLICTS:=miniupnpd-iptables
endef

define Build/Prepare
	$(call Build/Prepare/Default)
	echo "$(VERSION_NUMBER)" | tr '() ' '_' >$(PKG_BUILD_DIR)/os.openwrt
endef

CONFIGURE_ARGS = \
	$(if $(CONFIG_IPV6),--ipv6) \
	--igd2 \
	--leasefile \
	--portinuse \
	--firewall=$(BUILD_VARIANT) \
	--disable-fork

TARGET_CFLAGS += $(FPIC) -flto
TARGET_LDFLAGS += -Wl,--gc-sections,--as-needed

define Package/miniupnpd-prpl/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/miniupnpd $(1)/usr/sbin/miniupnpd
endef

$(eval $(call BuildPackage,miniupnpd-prpl))
