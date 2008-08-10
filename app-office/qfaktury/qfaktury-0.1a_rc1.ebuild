# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit qt3 eutils

MY_PV=0_1a_rc1
MY_P=${PN}_gpl_${MY_PV}

DESCRIPTION="Invoice management"
HOMEPAGE="http://www.e-linux.pl/qfaktury/qfaktury_nowa_wersja_/przeznaczenie_programu.html"
SRC_URI="http://www.e-linux.pl/components/com_jooget/file/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
EAPI="1"
IUSE="+vat vatmp"

DEPEND=">=x11-libs/qt-3.3:3"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e "s:qmake:${QTDIR}/bin/qmake/:" -i configure || die "sed failed"
}

src_compile() {
	local myconf
	use vat || myconf="--no_vat"
	use vatmp && myconf="${myconf} --vatmp"
	econf ${myconf} || die "econf failed"

	eqmake3 faktury.pro || die "qmake faktury.pro failed"
	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "make install failed"
	dodoc faq todo ChangeLog readme
}

