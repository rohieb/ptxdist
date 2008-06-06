# -*-makefile-*-
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FCGI) += fcgi

#
# Paths and names
#
FCGI_VERSION    := 2.4.0
FCGI		:= fcgi-$(FCGI_VERSION)
FCGI_SUFFIX	:= tar.gz
FCGI_URL	:= http://www.fastcgi.com/dist/fcgi.$(FCGI_SUFFIX)
FCGI_SOURCE	:= $(SRCDIR)/$(FCGI).$(FCGI_SUFFIX)
FCGI_DIR	:= $(BUILDDIR)/$(FCGI)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(FCGI_SOURCE):
	@$(call targetinfo)
	@$(call get, FCGI)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

fcgi_extract: $(STATEDIR)/fcgi.extract

$(STATEDIR)/fcgi.extract: $(fcgi_extract_deps_default)
	@$(call targetinfo)
	@$(call clean, $(FCGI_DIR))
	@$(call extract, FCGI)
	@$(call patchin, FCGI)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FCGI_PATH	=  PATH=$(CROSS_PATH)
FCGI_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
FCGI_AUTOCONF =  $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fcgi.targetinstall:
	@$(call targetinfo)
	@$(call install_init, fcgi)
	@$(call install_fixup, fcgi,PACKAGE,fcgi)
	@$(call install_fixup, fcgi,PRIORITY,optional)
	@$(call install_fixup, fcgi,VERSION,$(FCGI_VERSION))
	@$(call install_fixup, fcgi,SECTION,base)
	@$(call install_fixup, fcgi,AUTHOR,"Daniel Schnell <danielsch\@marel.com>")
	@$(call install_fixup, fcgi,DEPENDS,)
	@$(call install_fixup, fcgi,DESCRIPTION,missing)

	@$(call install_copy, fcgi, 0, 0, 0755, $(FCGI_DIR)/cgi-fcgi/cgi-fcgi, \
		/usr/bin/cgi-fcgi)

	@$(call install_copy, fcgi, 0, 0, 0755, $(FCGI_DIR)/libfcgi/.libs/libfcgi.so.0.0.0, \
		/usr/lib/libfcgi.so.0.0.0)
	@$(call install_link,  fcgi, libfcgi.so.0.0.0,  /usr/lib/libfcgi.so.0)
	@$(call install_link,  fcgi, libfcgi.so.0, /usr/lib/libfcgi.so)

	@$(call install_finish, fcgi)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

fcgi_clean:
	rm -rf $(STATEDIR)/fcgi.*
	rm -rf $(PKGDIR)/fcgi_*
	rm -rf $(FCGI_DIR)

# vim: syntax=make
