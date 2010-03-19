# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

MY_PN="SFML"

DESCRIPTION="Simple and fast multimedia library"
HOMEPAGE="http://sfml.sourceforge.net/"
SRC_URI="mirror://sourceforge/sfml/${MY_PN}-${PV}-sdk-linux.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-libs/freetype
	media-libs/libsndfile
	media-libs/openal
	media-libs/jpeg
	media-libs/libpng
	media-libs/glew
	sys-libs/zlib"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare()
{
	rm -f lib/*.so.*
	rm -Rf src/${MY_PN}/Graphics/{GLEW,lib{jpeg,png},zlib}
	epatch "${FILESDIR}"/${PN}-1.4-destdir-r5.patch || die "epatch failed"
	epatch "${FILESDIR}"/${PN}-1.4-deps.patch || die "epatch failed"
}

src_install()
{
	emake install DESTDIR="${D}" prefix=/usr || die "emake install failed"
}
