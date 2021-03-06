# -*-makefile-*-
#
# Copyright (C) 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CDRKIT) += host-cdrkit

#
# Paths and names
#
HOST_CDRKIT_VERSION	:= 1.1.10
HOST_CDRKIT_MD5		:= 3c25505d567113c269dc6e71640646d8
HOST_CDRKIT		:= cdrkit_$(HOST_CDRKIT_VERSION).orig
HOST_CDRKIT_SUFFIX	:= tar.gz
HOST_CDRKIT_URL		:= http://snapshot.debian.org/archive/debian/20101109T151711Z/pool/main/c/cdrkit/$(HOST_CDRKIT).$(HOST_CDRKIT_SUFFIX)
HOST_CDRKIT_SOURCE	:= $(SRCDIR)/$(HOST_CDRKIT).$(HOST_CDRKIT_SUFFIX)
HOST_CDRKIT_DIR		:= $(HOST_BUILDDIR)/$(HOST_CDRKIT)

# vim: syntax=make
