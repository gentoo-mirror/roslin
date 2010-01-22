# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/zsnes/zsnes-1.51-r1.ebuild,v 1.4 2007/12/04 05:08:45 vapier Exp $

EAPI=2

inherit eutils autotools flag-o-matic toolchain-funcs games

DESCRIPTION="SNES (Super Nintendo) emulator that uses x86 assembly"
HOMEPAGE="http://www.zsnes.com/ http://ipherswipsite.com/zsnes/"
SRC_URI="http://zsnes.sf.net/${PN}${PV//./}src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64 x86 ~x86-fbsd"
IUSE="ao experimental opengl png"

RDEPEND="media-libs/libsdl[joystick]
	>=sys-libs/zlib-1.2.3-r1
	amd64? ( >=app-emulation/emul-linux-x86-sdl-10.1 )
	ao? ( media-libs/libao )
	opengl? ( virtual/opengl )
	png? ( media-libs/libpng )"
DEPEND="${RDEPEND}
	dev-lang/nasm
	amd64? ( >=sys-apps/portage-2.1 )"

S=${WORKDIR}/${PN}_${PV//./_}/src

src_prepare() {
	# Remove hardcoded CFLAGS and LDFLAGS
	sed -i -e '/^\s*CFLAGS=.* -fomit-frame-pointer /d' \
		configure.in || die
	append-flags -fomit-frame-pointer
	use experimental || append-flags -D__RELEASE__

	sed -i \
		-e 's:^\s*STRIP="-s":STRIP="":'	\
		-e 's:^\s*CFLAGS=.* -I\/usr\/local\/include .*$:CFLAGS="${CFLAGS} -I.":'	\
		-e '/^\s*LDFLAGS=.* -L\/usr\/local\/lib /d'		\
		-e 's:-O99999999:-O1:' \
		configure.in || die

	epatch "${FILESDIR}/${PN}-1.51-FORTIFY_SOURCE.patch"

	eautoreconf
}

src_configure() {
	tc-export CC

	use amd64 && multilib_toolchain_setup x86

	local myconf="--disable-cpucheck force_arch=no"
	use experimental || myconf="${myconf} --enable-release"

	egamesconf \
		$(use_enable ao libao) \
		$(use_enable png libpng) \
		$(use_enable opengl) \
		--disable-debug \
		${myconf} \
		|| die
}

src_install() {
	dogamesbin zsnes || die "dogamesbin failed"
	newman linux/zsnes.1 zsnes.6
	dodoc ../docs/{readme.1st,*.txt,README.LINUX}
	dodoc ../docs/readme.txt/*
	dohtml -r ../docs/readme.htm/*
	make_desktop_entry zsnes ZSNES zsnes
	newicon icons/48x48x32.png ${PN}.png
	prepgamesdirs
}
