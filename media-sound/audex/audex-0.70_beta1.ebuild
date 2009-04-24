# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit kde4-base

DESCRIPTION="audex is a new audio grabber tool based on KDE 4"
HOMEPAGE="http://opensource.maniatek.de/audex"
SRC_URI="http://opensource.maniatek.de/${PN}/files/${P/_beta/b}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-sound/cdparanoia
	>=kde-base/libkcddb-${KDE_MINIMAL}
	>=kde-base/libkcompactdisc-${KDE_MINIMAL}"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

pkg_postinst() {
    elog "If you upgraded from a version prior to 0.70,"
    elog "please purge your old configuration file"
    elog "located at ~/.kde/share/config/audexrc."
}
