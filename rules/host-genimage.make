# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GENIMAGE) += host-genimage

#
# Paths and names
#
HOST_GENIMAGE_VERSION	:= 10
HOST_GENIMAGE_MD5	:= 7ac961222a7aa04f43e3bf3fc387d501
HOST_GENIMAGE		:= genimage-$(HOST_GENIMAGE_VERSION)
HOST_GENIMAGE_SUFFIX	:= tar.xz
HOST_GENIMAGE_URL	:= http://www.pengutronix.de/software/genimage/download/$(HOST_GENIMAGE).$(HOST_GENIMAGE_SUFFIX)
HOST_GENIMAGE_SOURCE	:= $(SRCDIR)/$(HOST_GENIMAGE).$(HOST_GENIMAGE_SUFFIX)
HOST_GENIMAGE_DIR	:= $(HOST_BUILDDIR)/$(HOST_GENIMAGE)
HOST_GENIMAGE_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_GENIMAGE_CONF_TOOL	:= autoconf
HOST_GENIMAGE_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--enable-largefile

# vim: syntax=make
