# -*-makefile-*-
#
# Copyright (C) 2013 by Sascha Hauer <s.hauer@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
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
DT_UTILS_VERSION	:= 2018.05.0
DT_UTILS_MD5		:= 3ab2d646639bb10607716a5b57e2ddf8
DT_UTILS		:= dt-utils-$(DT_UTILS_VERSION)
DT_UTILS_SUFFIX		:= tar.xz
DT_UTILS_URL		:= https://public.pengutronix.de/software/dt-utils/$(DT_UTILS).$(DT_UTILS_SUFFIX)
DT_UTILS_SOURCE		:= $(SRCDIR)/$(DT_UTILS).$(DT_UTILS_SUFFIX)
DT_UTILS_DIR		:= $(BUILDDIR)/$(DT_UTILS)
DT_UTILS_LICENSE	:= GPL-2.0-only

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
