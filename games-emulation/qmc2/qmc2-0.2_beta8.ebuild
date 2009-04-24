# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils qt4 games

MY_PV=${PV/_beta/.b}

DESCRIPTION="An MAME frontend for SDLMAME"
HOMEPAGE="http://www.mameworld.net/mamecat/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug joystick opengl phonon"

DEPEND="x11-libs/qt-gui:4[accessibility]
	phonon? ( media-sound/phonon )
	joystick? ( media-libs/libsdl[joystick] )
	opengl? ( virtual/opengl )"

RDEPEND="${DEPEND}
	games-emulation/sdlmame"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.2_beta7-makefile.patch"

	## This is not as it appears, ARCH means something different to qmc2's Makefile
	## then it means to the portage/portage-compatible package manager
	sed -ie 's%ifndef ARCH%ifdef ARCH%' Makefile
}

src_compile() {
	# Should really use GAMES_DATADIR, but then it bombs out
	FLAGS="QTDIR=/usr DESTDIR=${D} PREFIX=${GAMES_PREFIX} DATADIR=${GAMES_DATADIR} CTIME=0"

	use debug || FLAGS="${FLAGS} DEBUG=0"
	use joystick && FLAGS="${FLAGS} JOYSTICK=1"
	use opengl && FLAGS="${FLAGS} OPENGL=1"
	use phonon || FLAGS="${FLAGS} PHONON=0"
	emake ${FLAGS} || die "make failed"
}

src_install() {
	emake ${FLAGS} install || die "make install failed"

	## Not a big fan of doing this, but it's necessary due to build system
	sed -ie "s%${D}%/%g" "${D}etc/${PN}/${PN}.ini"
	rm "${D}etc/${PN}/${PN}.inie"

	prepgamesdirs
}
