# -*-makefile-*-
#
# Copyright (C) 2022 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CARGO_C) += host-cargo-c

#
# Paths and names
#
HOST_CARGO_C_VERSION		:= 0.9.12+cargo-0.64
HOST_CARGO_C_MD5		:= 621dde74255805a5beeade4921e90343
HOST_CARGO_C			:= cargo-c-$(HOST_CARGO_C_VERSION)
HOST_CARGO_C_SUFFIX		:= tar.gz
HOST_CARGO_C_URL		:= https://crates.io/api/v1/crates/cargo-c/$(HOST_CARGO_C_VERSION)/download
HOST_CARGO_C_SOURCE		:= $(SRCDIR)/$(HOST_CARGO_C).$(HOST_CARGO_C_SUFFIX)
HOST_CARGO_C_DIR		:= $(HOST_BUILDDIR)/$(HOST_CARGO_C)
HOST_CARGO_C_LICENSE		:= MIT AND unknown
HOST_CARGO_C_LICENSE_FILES	:= \
	file://LICENSE;md5=384ed0e2e0b2dac094e51fbf93fdcbe0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cargo
#
HOST_CARGO_C_CONF_TOOL	:= cargo

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

HOST_CARGO_C_TOOLS	:= \
	cargo-capi \
	cargo-cbuild \
	cargo-cinstall \
	cargo-ctest

$(STATEDIR)/host-cargo-c.install:
	@$(call targetinfo)
	@$(call world/execute, HOST_CARGO_C, \
		install -v -m755 -t $(HOST_CARGO_C_PKGDIR)/bin \
		$(addprefix $(HOST_CARGO_C_DIR)/target/release/, $(HOST_CARGO_C_TOOLS)))
	@$(call touch)

# vim: syntax=make
