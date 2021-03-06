# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CA_CERTIFICATES) += ca-certificates

#
# Paths and names
#
CA_CERTIFICATES_VERSION		:= 2016.08.08
# The commit hash of the default branch. Update this in sync with the date above.
CA_CERTIFICATES_HASH		:= 79f079284141
CA_CERTIFICATES_MD5		:= 4be3172ed2528ade3574cfbe35eec421
CA_CERTIFICATES			:= ca-certificates-$(CA_CERTIFICATES_VERSION)
CA_CERTIFICATES_SUFFIX		:= txt
CA_CERTIFICATES_URL		:= https://hg.mozilla.org/releases/mozilla-release/raw-file/$(CA_CERTIFICATES_HASH)/security/nss/lib/ckfw/builtins/certdata.$(CA_CERTIFICATES_SUFFIX)
CA_CERTIFICATES_SOURCE		:= $(SRCDIR)/certdata-$(CA_CERTIFICATES_VERSION).$(CA_CERTIFICATES_SUFFIX)
CA_CERTIFICATES_DIR		:= $(BUILDDIR)/$(CA_CERTIFICATES)
CA_CERTIFICATES_LICENSE		:= MPL-2.0
# Use '=' to delay $(shell ...) calls until this is needed
CA_CERTIFICATES_CERTDATA2PEM	 = $(call ptx/in-path, PTXDIST_PATH_SCRIPTS, certdata2pem.py)
CA_CERTIFICATES_BLACKLIST	 = $(call ptx/get-alternative, config/ca-certificates, blacklist.txt)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/ca-certificates.extract:
	@$(call targetinfo)
	@rm -rf $(CA_CERTIFICATES_DIR)
	@mkdir -p $(CA_CERTIFICATES_DIR)
	@cp -v $(CA_CERTIFICATES_SOURCE) $(CA_CERTIFICATES_DIR)/certdata.txt
	@cp -v $(CA_CERTIFICATES_BLACKLIST) $(CA_CERTIFICATES_DIR)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CA_CERTIFICATES_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/ca-certificates.compile:
	@$(call targetinfo)
	@cd $(CA_CERTIFICATES_DIR) && $(CA_CERTIFICATES_CERTDATA2PEM)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ca-certificates.install:
	@$(call targetinfo)
	@rm -rf $(CA_CERTIFICATES_PKGDIR)
	@install -d -m 0755 $(CA_CERTIFICATES_PKGDIR)/etc/ssl/certs/
ifdef PTXCONF_CA_CERTIFICATES_BUNDLE
	@for crt in $(CA_CERTIFICATES_DIR)/*.crt; do \
		sed -e '$$a\\' "$${crt}" >> \
			$(CA_CERTIFICATES_PKGDIR)/etc/ssl/certs/ca-certificates.crt; \
	done
endif
ifdef PTXCONF_CA_CERTIFICATES_CERTS
	@install -m 0644 $(CA_CERTIFICATES_DIR)/*.crt \
		$(CA_CERTIFICATES_PKGDIR)/etc/ssl/certs/
	@OPENSSL_CONF=$(SYSROOT)/usr/lib/ssl/openssl.cnf SSL_CERT_FILE="" \
		c_rehash $(CA_CERTIFICATES_PKGDIR)/etc/ssl/certs/
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ca-certificates.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ca-certificates)
	@$(call install_fixup, ca-certificates,PRIORITY,optional)
	@$(call install_fixup, ca-certificates,SECTION,base)
	@$(call install_fixup, ca-certificates,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, ca-certificates,DESCRIPTION,missing)

	@$(call install_tree, ca-certificates, 0, 0, -, /etc/ssl/certs)

	@$(call install_finish, ca-certificates)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

#$(STATEDIR)/ca-certificates.clean:
#	@$(call targetinfo)
#	@$(call clean_pkg, CA_CERTIFICATES)

# vim: syntax=make
