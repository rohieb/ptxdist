# -*-makefile-*-
# $Id: gtk1210.make,v 1.1 2003/08/19 12:04:27 robert Exp $
#
# (c) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#             Pengutronix <info@pengutronix.de>, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_GTK1210
PACKAGES += gtk1210
endif

#
# Paths and names
#
GTK1210_VERSION		= 1.2.10
GTK1210			= gtk+-$(GTK1210_VERSION)
GTK1210_SUFFIX		= tar.gz
GTK1210_URL		= ftp://ftp.gtk.org/pub/gtk/v1.2/$(GTK1210).$(GTK1210_SUFFIX)
GTK1210_SOURCE		= $(SRCDIR)/$(GTK1210).$(GTK1210_SUFFIX)
GTK1210_DIR		= $(BUILDDIR)/$(GTK1210)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gtk1210_get: $(STATEDIR)/gtk1210.get

gtk1210_get_deps	=  $(GTK1210_SOURCE)

$(STATEDIR)/gtk1210.get: $(gtk1210_get_deps)
	@$(call targetinfo, gtk1210.get)
	touch $@

$(GTK1210_SOURCE):
	@$(call targetinfo, $(GTK1210_SOURCE))
	@$(call get, $(GTK1210_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gtk1210_extract: $(STATEDIR)/gtk1210.extract

gtk1210_extract_deps	=  $(STATEDIR)/gtk1210.get

$(STATEDIR)/gtk1210.extract: $(gtk1210_extract_deps)
	@$(call targetinfo, gtk1210.extract)
	@$(call clean, $(GTK1210_DIR))
	@$(call extract, $(GTK1210_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gtk1210_prepare: $(STATEDIR)/gtk1210.prepare

#
# dependencies
#
gtk1210_prepare_deps =  \
	$(STATEDIR)/gtk1210.extract \
	$(STATEDIR)/glib1210.install \
#	$(STATEDIR)/virtual-xchain.install

GTK1210_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
GTK1210_ENV 	=  $(CROSS_ENV)
GTK1210_ENV	+= ac_cv_have_x='have_x=yes ac_x_includes=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include ac_x_libraries=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib'

#
# autoconf
#
GTK1210_AUTOCONF	=  --prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)
GTK1210_AUTOCONF	+= --build=$(GNU_HOST)
GTK1210_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)

GTK1210_AUTOCONF	+= --with-threads=posix
GTK1210_AUTOCONF 	+= --with-glib-prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)
GTK1210_AUTOCONF	+= --with-x

$(STATEDIR)/gtk1210.prepare: $(gtk1210_prepare_deps)
	@$(call targetinfo, gtk1210.prepare)
	@$(call clean, $(GTK1210_BUILDDIR))
	cd $(GTK1210_DIR) && \
		$(GTK1210_PATH) $(GTK1210_ENV) \
		./configure $(GTK1210_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gtk1210_compile: $(STATEDIR)/gtk1210.compile

gtk1210_compile_deps =  $(STATEDIR)/gtk1210.prepare

$(STATEDIR)/gtk1210.compile: $(gtk1210_compile_deps)
	@$(call targetinfo, gtk1210.compile)
	$(GTK1210_PATH) $(GTK1210_ENV) make -C $(GTK1210_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gtk1210_install: $(STATEDIR)/gtk1210.install

$(STATEDIR)/gtk1210.install: $(STATEDIR)/gtk1210.compile
	@$(call targetinfo, gtk1210.install)
	$(GTK1210_PATH) $(GTK1210_ENV) make -C $(GTK1210_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gtk1210_targetinstall: $(STATEDIR)/gtk1210.targetinstall

gtk1210_targetinstall_deps	=  $(STATEDIR)/gtk1210.compile

$(STATEDIR)/gtk1210.targetinstall: $(gtk1210_targetinstall_deps)
	@$(call targetinfo, gtk1210.targetinstall)

	# glib 
	install $(GTK1210_DIR)/gdk/.libs/libgdk-1.2.so.0.9.1 $(ROOTDIR)/lib
	ln -s libgdk-1.2.so.0.9.1 $(ROOTDIR)/lib/libgdk-1.2.so.0
	ln -s libgdk-1.2.so.0.9.1 $(ROOTDIR)/lib/libgdk-1.2.so

	# gtk
	install $(GTK1210_DIR)/gtk/.libs/libgtk-1.2.so.0.9.1 $(ROOTDIR)/lib
	ln -s libgtk-1.2.so.0.9.1 $(ROOTDIR)/lib/libgtk-1.2.so.0
	ln -s libgtk-1.2.so.0.9.1 $(ROOTDIR)/lib/libgtk-1.2.so

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gtk1210_clean:
	rm -rf $(STATEDIR)/gtk1210.*
	rm -rf $(GTK1210_DIR)

# vim: syntax=make
