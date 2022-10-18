# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_XFREE86_TYPE1) += xorg-font-xfree86-type1

#
# Paths and names
#
XORG_FONT_XFREE86_TYPE1_VERSION	:= 1.0.4
XORG_FONT_XFREE86_TYPE1_MD5	:= 3eeb3fb44690b477d510bbd8f86cf5aa
XORG_FONT_XFREE86_TYPE1		:= font-xfree86-type1-$(XORG_FONT_XFREE86_TYPE1_VERSION)
XORG_FONT_XFREE86_TYPE1_SUFFIX	:= tar.bz2
XORG_FONT_XFREE86_TYPE1_URL	:= $(call ptx/mirror, XORG, individual/font/$(XORG_FONT_XFREE86_TYPE1).$(XORG_FONT_XFREE86_TYPE1_SUFFIX))
XORG_FONT_XFREE86_TYPE1_SOURCE	:= $(SRCDIR)/$(XORG_FONT_XFREE86_TYPE1).$(XORG_FONT_XFREE86_TYPE1_SUFFIX)
XORG_FONT_XFREE86_TYPE1_DIR	:= $(BUILDDIR)/$(XORG_FONT_XFREE86_TYPE1)

ifdef PTXCONF_XORG_FONT_XFREE86_TYPE1
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-xfree86-type1.targetinstall
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_FONT_XFREE86_TYPE1_CONF_TOOL := autoconf
XORG_FONT_XFREE86_TYPE1_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/Type1

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-xfree86-type1.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-xfree86-type1.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/Type1

	@find $(XORG_FONT_XFREE86_TYPE1_DIR) \
		-name "*.pfa" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/Type1; \
	done

	@$(call touch)

# vim: syntax=make
