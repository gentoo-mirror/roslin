# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Tools package for optimize your system"
HOMEPAGE="http://optimizationkit.org"
SRC_URI="http://download.tuxfamily.org/optimization/OptimizationKit/v0.1/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="X"
DEPEND="X? ( dev-python/pygtk )
        >=dev-lang/python-2.5.1"
RDEPEND="${DEPEND}"

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	dodir /usr/share/OptimizationKit
	insinto /usr/share/OptimizationKit
	insopts -m 744
	doins src/OptimizationKit || die "Failed to install OptimizationKit"
	dosym /usr/share/OptimizationKit/OptimizationKit /usr/sbin/OptimizationKit
	doins src/ok_gen_prefetch_file || die "Failed to install ok_gen_prefetch_file"
	dosym /usr/share/OptimizationKit/ok_gen_prefetch_file /usr/bin/ok_gen_prefetch_file

	if use X; then
		insopts -m 755
		doins src/OptimizationKit-gui || die "Failed to install OptimizationKit-gui"
		dosym /usr/share/OptimizationKit/OptimizationKit-gui /usr/bin/OptimizationKit-gui
	    
	    insopts -m 644
	    dodir /usr/share/OptimizationKit/pl_PL/LC_MESSAGES /usr/share/OptimizationKit/en_US/LC_MESSAGES
	    insinto /usr/share/OptimizationKit/en_US/LC_MESSAGES
	    doins src/en_US/LC_MESSAGES/* || die "Failed to install GUI help file"
	    insinto /usr/share/OptimizationKit/pl_PL/LC_MESSAGES
		doins src/pl_PL/LC_MESSAGES/*  || die "Failed to install GUI help file"
	fi

	insopts -m 644
	insinto /usr/share/OptimizationKit
	doins src/*.py || die "Failed to install python files"

	dodir /etc/OptimizationKit
	insinto /etc/OptimizationKit
	doins conf/* || die "Failed to install configuration files"
	insinto /etc/conf.d
	doins conf.d/OptimizationKit || die "Failed to install configuration file"

	insinto /etc/init.d
	insopts -m 755
	doins distro/gentoo/OptimizationKit || die "Failed to install init script"

	insopts -m 644
	dodoc doc/*
}

pkg_postinst () {
	elog "Run 'rc-update add OptimizationKit default' to add script to runlevel"
	ewarn "Please report bugs at optimizationkit@gmail.com"
}
