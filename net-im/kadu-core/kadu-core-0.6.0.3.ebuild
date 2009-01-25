# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils flag-o-matic kadu

DESCRIPTION="Core of Kadu IM"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"

IUSE="debug"

DEPEND="=x11-libs/qt-3*
	!<net-libs/libgadu-1.8.0"

RDEPEND="${DEPEND}"

SRC_URI="http://www.kadu.net/download/stable/kadu-${K_PV}.tar.bz2"

S="${WORKDIR}/kadu"

module_config()
{
	sed -i -r "s/(^module_${1}\\s*=\\s*).*/\\1${2}/" .config
}

pkg_setup()
{
	# Break if qt3 is compiled without gif use flag
	if has_version '=x11-libs/qt-3*' && ! built_with_use --missing true '=x11-libs/qt-3*' gif
	then
		die "Please re-emerge x11-libs/qt-3.x with the 'gif' flag set"
	fi

#	if has_version "<net-im/kadu-core-${MIN_REQ}"
#	then
#		die "Please unmerge old Kadu before you install this version"
#	fi
}

src_unpack()
{
	# Unpack the sources
	unpack ${A}
	cd "${S}"

	# Rewrite .config file to contain only internal modules defaulted to "n"
	rm -f .config
	for I in `find modules -maxdepth 1 -type d | grep "/[[:alnum:]_]\+" | cut -d "/" -f 2`
	do
		echo "module_${I}=n" >> .config
	done

	# Enable default icons
	echo "icons_default=y" >> .config

	# Enable default emoticons
	echo "emoticons_penguins=y" >> .config

	# Apply patches
	einfo "Applying patches..."
	epatch "${FILESDIR}/misc_opts.patch"
}

src_compile()
{
	# Regenerate configure script
	einfo "Reconfiguring package..."
	admin/configure-gen

	# Filter compiler flags
	filter-flags -fno-rtti

	local myconf
	myconf="${myconf} --disable-autodownload --enable-dist-info=Gentoo"

	if has_version '>=net-libs/libgadu-1.8.0'
	then
	    myconf="${myconf} --with-existing-libgadu"

	    ewarn "Kadu will be linked against existing libgadu - dcc features may work improperly"
	    ewarn "If you have problems, unmerge libgadu and reemerge kadu then"
	fi

	# Compile package
	econf \
		${myconf} \
		$(use_enable debug) \
		|| die "Error: econf failed!"

	emake \
		|| die "Error: emake failed!"
}

src_install()
{
	# Install compiled package
	make install DESTDIR="${D}" \
		|| die "Error: make install failed!"

	# Prepare docs
	dodoc {AUTHORS,COPYING,ChangeLog,HISTORY,README,THANKS}

	# Prepare environment for further compilation of modules
	cp kadu-core/kadu-headers.h "${D}"/usr/include/kadu
	cp kadu-stdint.h "${D}"/usr/include/kadu
	cp modules/Makefile "${D}"/usr/share/kadu/modules

	sed "${D}"/usr/share/kadu/modules/Makefile -i -e "s%^shared_modules =.*%shared_modules = %g"
	sed "${D}"/usr/share/kadu/modules/Makefile -i -e "s%^static_modules =.*%static_modules = %g"

	sed "${D}"/usr/share/kadu/modules/Makefile -i -e "s%^CFLAGS =.*%CFLAGS = %g"
	sed "${D}"/usr/share/kadu/modules/Makefile -i -e "s%^CXXFLAGS =.*%CXXFLAGS = %g"
	sed "${D}"/usr/share/kadu/modules/Makefile -i -e "s%^LDFLAGS =.*%LDFLAGS = %g"

	# Fixup headers
	kadu_src_repair_includes "${D}"/usr/include/kadu core
}
