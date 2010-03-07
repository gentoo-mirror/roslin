# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

RESTRICT="mirror"

DESCRIPTION="Kydpdict is a graphical frontend to Collins', PWN Oxford & SAP dictionaries."
SRC_URI="http://members.elysium.pl/ytm/src/${P}.tar.bz2"
HOMEPAGE="http://members.elysium.pl/ytm/html/kydpdict.html"
KEYWORDS=""
SLOT="0"
LICENSE="GPL-2"

IUSE=""

DEPEND="x11-libs/qt:3"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.patch" \
	    "${FILESDIR}/${P}-const-char.patch"
}

src_configure() {
	LUPDATE=/usr/qt/3/bin/lupdate \
	LRELEASE=/usr/qt/3/bin/lrelease \
	econf || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog README TODO

	make_desktop_entry ${PN} ${PN} accessories-dictionary "Dictionary;Application;Utility"
}

pkg_postinst() {
	einfo "This is only a front-end to dictionaries."
	einfo "You need to have windows version installed. In fact you need only four files: "
	einfo "dict100.dat, dict101.dat, dict100.idx, dict101.idx"
	einfo "angpol.win polang.win"
}
