# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

WANT_AUTOMAKE="1.9"

inherit subversion autotools games

MY_PN="gamediameter"

DESCRIPTION="Arcade-style game with elements of economy and adventure"
HOMEPAGE="http://gamediameter.sourceforge.net/"
SRC_URI=""

ESVN_REPO_URI="https://${MY_PN}.svn.sourceforge.net/svnroot/${MY_PN}"
ESVN_PROJECT=${MY_PN}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=dev-games/guichan-0.6.0
	>=media-libs/libpng-1.2.8
	virtual/opengl
	media-libs/libsdl
	>=media-libs/sdl-image-1.2.4
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0"

pkg_setup() {
	games_pkg_setup

	if ! built_with_use "dev-games/guichan" opengl \
		|| ! built_with_use "dev-games/guichan" sdl ; then
		die "emerge dev-games/guichan with 'opengl' & 'sdl' USE flags."
	fi
}

src_compile() {
	eautoreconf

	# Use our CFLAGS
	sed -i \
		-e "/^CFLAGS=.*march/ d" \
		configure || die "sed configure failed"

	egamesconf || die "egamesconf failed"

	# Change "gamediameter" directory to just "diameter"
	find . -name Makefile | xargs sed -i -e "s:${MY_PN}:${PN}:"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	newicon data/texture/gui/eng/main/logo.png ${PN}.png || die
	make_desktop_entry ${PN} "Diameter" ${PN}.png

	dodoc AUTHORS ChangeLog NEWS README

	prepgamesdirs
}
