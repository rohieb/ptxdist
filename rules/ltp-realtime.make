# -*-makefile-*-
# $Id: template-make 7759 2008-02-12 21:05:07Z mkl $
#
# Copyright (C) 2008 by 
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LTP_REALTIME) += ltp-realtime

#
# Paths and names
#
LTP_REALTIME_VERSION	= $(LTP_VERSION)
LTP_REALTIME		= ltp-realtime-$(LTP_VERSION)
LTP_REALTIME_PKGDIR	= $(PKGDIR)/$(LTP_REALTIME)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ltp-realtime_get: $(STATEDIR)/ltp-realtime.get

$(STATEDIR)/ltp-realtime.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ltp-realtime_extract: $(STATEDIR)/ltp-realtime.extract

$(STATEDIR)/ltp-realtime.extract:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ltp-realtime_prepare: $(STATEDIR)/ltp-realtime.prepare

$(STATEDIR)/ltp-realtime.prepare:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ltp-realtime_compile: $(STATEDIR)/ltp-realtime.compile

$(STATEDIR)/ltp-realtime.compile:
	@$(call targetinfo, $@)
	@cd $(LTP_DIR)/testcases/realtime; $(LTP_ENV) make $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ltp-realtime_install: $(STATEDIR)/ltp-realtime.install

$(STATEDIR)/ltp-realtime.install:
	@$(call targetinfo, $@)
	@mkdir -p $(LTP_REALTIME_PKGDIR)/bin
	@ln -sf $(LTP_REALTIME_PKGDIR)/bin $(LTP_DIR)/testcases/bin
	@cd $(LTP_DIR)/testcases/realtime; $(LTP_ENV) make $(PARALLELMFLAGS) install
	@rm $(LTP_DIR)/testcases/bin
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ltp-realtime_targetinstall: $(STATEDIR)/ltp-realtime.targetinstall

$(STATEDIR)/ltp-realtime.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, ltp-realtime)
	@$(call install_fixup, ltp-realtime,PACKAGE,ltp-realtime)
	@$(call install_fixup, ltp-realtime,PRIORITY,optional)
	@$(call install_fixup, ltp-realtime,VERSION,$(LTP_VERSION))
	@$(call install_fixup, ltp-realtime,SECTION,base)
	@$(call install_fixup, ltp-realtime,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ltp-realtime,DEPENDS,)
	@$(call install_fixup, ltp-realtime,DESCRIPTION,missing)

	@for file in `find $(LTP_REALTIME_PKGDIR)/bin -type f`; do \
		PER=`stat -c "%a" $$file` \
		$(call install_copy, ltp-realtime, 0, 0, $$PER, $$file, $(LTP_BIN_DIR)/$$file); \
	done


	@$(call install_finish, ltp-realtime)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltp-realtime_clean:
	rm -rf $(STATEDIR)/ltp-realtime.*
	rm -rf $(IMAGEDIR)/ltp-realtime_*
	rm -rf $(LTP_REALTIME_DIR)

# vim: syntax=make
