# -*-makefile-*-
#
# Copyright (C) 2013 by Sascha Hauer <s.hauer@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DT_UTILS) += dt-utils

#
# Paths and names
#
DT_UTILS_VERSION	:= 2019.01.0
DT_UTILS_MD5		:= d83ebf99b07fa4516aeaa329afb2a6eb
DT_UTILS		:= dt-utils-$(DT_UTILS_VERSION)
DT_UTILS_SUFFIX		:= tar.xz
DT_UTILS_URL		:= https://public.pengutronix.de/software/dt-utils/$(DT_UTILS).$(DT_UTILS_SUFFIX)
DT_UTILS_SOURCE		:= $(SRCDIR)/$(DT_UTILS).$(DT_UTILS_SUFFIX)
DT_UTILS_DIR		:= $(BUILDDIR)/$(DT_UTILS)
DT_UTILS_LICENSE	:= GPL-2.0-only
DT_UTILS_LICENSE_FILES	:= \
	file://COPYING;md5=9ac2e7cff1ddaf48b6eab6028f23ef88 \
	file://src/barebox-state.c;startline=6;endline=13;md5=d2a3fab9d93cf1e5a939e59f75cfc921

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DT_UTILS_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dt-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dt-utils)
	@$(call install_fixup, dt-utils,PRIORITY,optional)
	@$(call install_fixup, dt-utils,SECTION,base)
	@$(call install_fixup, dt-utils,AUTHOR,"Sascha Hauer <s.hauer@pengutronix.de>")
	@$(call install_fixup, dt-utils,DESCRIPTION,missing)

	@$(call install_lib, dt-utils, 0, 0, 0644, libdt-utils)
	@$(call install_copy, dt-utils, 0, 0, 0755, -, /usr/bin/barebox-state)
	@$(call install_copy, dt-utils, 0, 0, 0755, -, /usr/bin/fdtdump)

	@$(call install_finish, dt-utils)

	@$(call touch)

# vim: syntax=make
