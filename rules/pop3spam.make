# -*-makefile-*-
# $Id$
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_POP3SPAM
PACKAGES += pop3spam
endif

#
# Paths and names
#
POP3SPAM_VERSION	= 0.9
POP3SPAM		= pop3spam-$(POP3SPAM_VERSION)
POP3SPAM_SUFFIX		= tar.bz2
POP3SPAM_URL		= $(PTXCONF_SFMIRROR)/pop3spam/$(POP3SPAM).$(POP3SPAM_SUFFIX)
POP3SPAM_SOURCE		= $(SRCDIR)/$(POP3SPAM).$(POP3SPAM_SUFFIX)
POP3SPAM_DIR		= $(BUILDDIR)/$(POP3SPAM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

pop3spam_get: $(STATEDIR)/pop3spam.get

pop3spam_get_deps = $(POP3SPAM_SOURCE)

$(STATEDIR)/pop3spam.get: $(pop3spam_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(POP3SPAM))
	touch $@

$(POP3SPAM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(POP3SPAM_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pop3spam_extract: $(STATEDIR)/pop3spam.extract

pop3spam_extract_deps = $(STATEDIR)/pop3spam.get

$(STATEDIR)/pop3spam.extract: $(pop3spam_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(POP3SPAM_DIR))
	@$(call extract, $(POP3SPAM_SOURCE))
	@$(call patchin, $(POP3SPAM))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

pop3spam_prepare: $(STATEDIR)/pop3spam.prepare

#
# dependencies
#
pop3spam_prepare_deps =  $(STATEDIR)/pop3spam.extract
pop3spam_prepare_deps += $(STATEDIR)/virtual-xchain.install
pop3spam_prepare_deps += $(STATEDIR)/pcre.install

POP3SPAM_PATH	=  PATH=$(CROSS_PATH)
POP3SPAM_ENV 	=  $(CROSS_ENV)
#POP3SPAM_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#POP3SPAM_ENV	+=

#
# autoconf
#
POP3SPAM_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/pop3spam.prepare: $(pop3spam_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(POP3SPAM_DIR)/config.cache)
	cd $(POP3SPAM_DIR) && \
		$(POP3SPAM_PATH) $(POP3SPAM_ENV) \
		./configure $(POP3SPAM_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pop3spam_compile: $(STATEDIR)/pop3spam.compile

pop3spam_compile_deps = $(STATEDIR)/pop3spam.prepare

$(STATEDIR)/pop3spam.compile: $(pop3spam_compile_deps)
	@$(call targetinfo, $@)
	cd $(POP3SPAM_DIR) && $(POP3SPAM_ENV) $(POP3SPAM_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pop3spam_install: $(STATEDIR)/pop3spam.install

$(STATEDIR)/pop3spam.install: $(STATEDIR)/pop3spam.compile
	@$(call targetinfo, $@)
	cd $(POP3SPAM_DIR) && $(POP3SPAM_ENV) $(POP3SPAM_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pop3spam_targetinstall: $(STATEDIR)/pop3spam.targetinstall

pop3spam_targetinstall_deps =  $(STATEDIR)/pop3spam.compile
pop3spam_targetinstall_deps += $(STATEDIR)/pcre.targetinstall

$(STATEDIR)/pop3spam.targetinstall: $(pop3spam_targetinstall_deps)
	@$(call targetinfo, $@)
	$(call copy_root, 0, 0, 0555, $(POP3SPAM_DIR)/src/pop3spam, /usr/bin/pop3spam)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pop3spam_clean:
	rm -rf $(STATEDIR)/pop3spam.*
	rm -rf $(POP3SPAM_DIR)

# vim: syntax=make
