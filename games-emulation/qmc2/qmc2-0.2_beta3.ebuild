# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils qt4 games

MY_PV=${PV/_beta/.b}

DESCRIPTION="An MAME frontend for SDLMAME"
HOMEPAGE="http://www.mameworld.net/mamecat/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.bz2"

EAPI="1"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug joystick opengl"

DEPEND="|| ( >=x11-libs/qt-4.3.0:4
	    x11-libs/qt-gui:4 )
	joystick? ( media-libs/libsdl )
	opengl? ( virtual/opengl )"

RDEPEND="${DEPEND}
	games-emulation/sdlmame"

S="${WORKDIR}/${PN}"

pkg_setup() {
	if has_version ">=x11-libs/qt-4.3:4"; then
		QT4_BUILT_WITH_USE_CHECK="accessibility"
	else
		if ! built_with_use "x11-libs/qt-gui:4" accessibility; then
			eerror "You have to built x11-libs/qt-gui:4 with accessibility."
			die "accessibility in qt-gui disabled"
		fi
	fi
	qt4_pkg_setup
}


src_unpack() {
	unpack ${A}
	cd ${S}
	
	epatch "${FILESDIR}/${PN}-makefile.patch"
}

src_compile() {
	## This is not as it appears, ARCH means something different to qmc2's Makefile
	## then it means to the portage/portage-compatible package manager
	sed -ie 's%ifndef ARCH%ifdef ARCH%' Makefile

	# Should really use GAMES_DATADIR, but then it bombs out
	FLAGS="QTDIR=/usr DESTDIR=${D} PREFIX=${GAMES_PREFIX} DATADIR=${GAMES_DATADIR} CTIME=0"

	use debug && FLAGS="${FLAGS} DEBUG=0"
	use joystick && FLAGS="${FLAGS} JOYSTICK=1"
	use opengl && FLAGS="${FLAGS} OPENGL=1"
	emake ${FLAGS} || die "make failed"
}

src_install() {
	emake ${FLAGS} install || die "make install failed"

	## Not a big fan of doing this, but it's necessary due to build system
	sed -ie "s%${D}%/%g" "${D}etc/${PN}/${PN}.ini" 
	rm "${D}etc/${PN}/${PN}.inie"
	make_desktop_entry ${PN}
	
	prepgamesdirs
}
