# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GSTREAMER_VAAPI1) += gstreamer-vaapi1

#
# Paths and names
#
GSTREAMER_VAAPI1_VERSION	:= 1.14.4
GSTREAMER_VAAPI1_MD5		:= 2fae3442f5f23e7354a0c592bc7b9065
GSTREAMER_VAAPI1		:= gstreamer-vaapi-$(GSTREAMER_VAAPI1_VERSION)
GSTREAMER_VAAPI1_SUFFIX		:= tar.xz
GSTREAMER_VAAPI1_URL		:= http://gstreamer.freedesktop.org/src/gstreamer-vaapi/$(GSTREAMER_VAAPI1).$(GSTREAMER_VAAPI1_SUFFIX)
GSTREAMER_VAAPI1_SOURCE		:= $(SRCDIR)/$(GSTREAMER_VAAPI1).$(GSTREAMER_VAAPI1_SUFFIX)
GSTREAMER_VAAPI1_DIR		:= $(BUILDDIR)/$(GSTREAMER_VAAPI1)
GSTREAMER_VAAPI1_LICENSE	:= LGPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GSTREAMER_VAAPI1_ENABLE-y					:= drm
GSTREAMER_VAAPI1_ENABLE-$(PTXCONF_GSTREAMER_VAAPI1_X11)		+= x11
GSTREAMER_VAAPI1_ENABLE-$(PTXCONF_GSTREAMER_VAAPI1_GLX)		+= glx
GSTREAMER_VAAPI1_ENABLE-$(PTXCONF_GSTREAMER_VAAPI1_WAYLAND)	+= wayland
# EGL backend is gone but configure only looks for OpenGL if glx or egl is enabled
GSTREAMER_VAAPI1_ENABLE-$(PTXCONF_GSTREAMER_VAAPI1_OPENGL)	+= egl

#
# autoconf
#
GSTREAMER_VAAPI1_CONF_TOOL	:= autoconf
GSTREAMER_VAAPI1_CONF_OPT	= \
	$(CROSS_AUTOCONF_USR) \
	$(GSTREAMER1_BASIC_CONF_OPT) \
	\
	--disable-examples \
	--enable-encoders \
	$(addprefix --enable-,$(GSTREAMER_VAAPI1_ENABLE-y)) \
	$(addprefix --disable-,$(GSTREAMER_VAAPI1_ENABLE-)) \
	--with-glapi=$(call ptx/ifdef,PTXCONF_GSTREAMER_VAAPI1_OPENGL,any,no) \
	--without-gtk

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gstreamer-vaapi1.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gstreamer-vaapi1)
	@$(call install_fixup, gstreamer-vaapi1,PRIORITY,optional)
	@$(call install_fixup, gstreamer-vaapi1,SECTION,base)
	@$(call install_fixup, gstreamer-vaapi1,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, gstreamer-vaapi1,DESCRIPTION,missing)

	@$(call install_lib, gstreamer-vaapi1, 0, 0, 0644, \
		gstreamer-1.0/libgstvaapi)

	@$(call install_finish, gstreamer-vaapi1)

	@$(call touch)

# vim: syntax=make
