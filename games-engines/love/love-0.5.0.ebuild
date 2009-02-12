# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games

MY_P="${P/5.0/5-0}"

DESCRIPTION="An unquestionably awesome 2D game engine"
HOMEPAGE="http://love2d.org/"
SRC_URI=" mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-games/physfs
	dev-libs/boost
	media-libs/devil
	media-libs/libsdl"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-gcc43.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "einstall failed"
}
