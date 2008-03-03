# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games subversion

DESCRIPTION="Unique 2D RPG engine"
HOMEPAGE="http://www.fifengine.de/"
#SRC_URI="mirror://sourceforge/${PN}/FIFE_${PV}_src.tar.bz2"

ESVN_REPO_URI="https://svn1.cvsdude.com/fife/engine/trunk"
ESVN_PROJECT="${PN}"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/boost
	=dev-games/guichan-0.6.1
	media-libs/libogg
	media-libs/libvorbis
	dev-lang/lua
	media-libs/openal
	dev-util/scons
	media-libs/sdl-image
	media-libs/sdl-ttf
	>=dev-lang/python-2.5"
RDEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
#	unpack ${A}
	subversion_src_unpack
	cd ${S}
	sed -i \
		-e "s|lua5.1|lua|" \
		build/linux2-config-dist.py || die "sed python something failed"
}

src_compile() {
#	python build/linux2-config-dist.py || die "python something failed"
	scons ext=1 || die "scons ext=1 failed"
	scons || die "scons failed"
}
