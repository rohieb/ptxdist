# -*-makefile-*-
#
# Copyright (C) 2021 by Denis Osterland-Heim <Denis.Osterland@diehl.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

HOST_PACKAGES-$(PTXCONF_HOST_YUBIHSM_SHELL) += host-yubihsm-shell

#
# Paths and names
#
HOST_YUBIHSM_SHELL_VERSION	:= 2.1.0
HOST_YUBIHSM_SHELL_MD5		:= 7363c0bc4ed037e262474beaa6e1407b
HOST_YUBIHSM_SHELL		:= yubihsm-shell-$(HOST_YUBIHSM_SHELL_VERSION)
HOST_YUBIHSM_SHELL_SUFFIX	:= tar.gz
HOST_YUBIHSM_SHELL_URL		:= https://github.com/Yubico/yubihsm-shell/archive/$(HOST_YUBIHSM_SHELL_VERSION).$(HOST_YUBIHSM_SHELL_SUFFIX)
HOST_YUBIHSM_SHELL_SOURCE	:= $(SRCDIR)/$(HOST_YUBIHSM_SHELL).$(HOST_YUBIHSM_SHELL_SUFFIX)
HOST_YUBIHSM_SHELL_DIR		:= $(HOST_BUILDDIR)/$(HOST_YUBIHSM_SHELL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
HOST_YUBIHSM_SHELL_CONF_TOOL	:= cmake
HOST_YUBIHSM_SHELL_CONF_OPT	:=  \
	$(HOST_CMAKE_OPT) \
	-DBUILD_ONLY_LIB=OFF \
	-DENABLE_COVERAGE=OFF \
	-DSUPRESS_MSVC_WARNINGS=ON \
	-DWITHOUT_MANPAGES=1

# vim: syntax=make
