# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/zsnes/zsnes-1.51-r1.ebuild,v 1.4 2007/12/04 05:08:45 vapier Exp $

EAPI=2

inherit eutils autotools flag-o-matic toolchain-funcs games

DESCRIPTION="SNES (Super Nintendo) emulator that uses x86 assembly"
HOMEPAGE="http://www.zsnes.com/ http://ipherswipsite.com/zsnes/"
SRC_URI="http://zsnes.sf.net/${PN}${PV//./}src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86 ~x86-fbsd"
IUSE="ao custom-cflags experimental opengl png"

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
	epatch "${FILESDIR}/${PN}-1.51-CC-quotes.patch" \
		"${FILESDIR}/${PN}-1.51-depbuild.patch" \
		"${FILESDIR}/${PN}-1.51-libpng.patch" \
		"${FILESDIR}/${PN}-1.51-libpng15.patch" \
		"${FILESDIR}/${PN}-1.51-cross-compile.patch" \
		"${FILESDIR}/${PN}-1.51-gcc47.patch"

	sed -i '1i#define OF(x) x' zip/zunzip.h

	# Remove hardcoded CFLAGS and LDFLAGS
	sed -i \
		-e '/^CFLAGS=.*local/s:-pipe.*:-Wall -I.":' \
		-e '/^LDFLAGS=.*local/d' \
		-e '/\w*CFLAGS=.*fomit/s:-O3.*$STRIP::' \
		-e 's:-O99999999:-O1:' \
		configure.in \
		|| die "sed failed"
	eautoreconf
}

src_configure() {
	tc-export CC
	use amd64 && multilib_toolchain_setup x86
	use custom-cflags || strip-flags
	append-flags -U_FORTIFY_SOURCE

	local myconf
	use experimental || myconf="--enable-release"

	egamesconf \
		$(use_enable ao libao) \
		$(use_enable png libpng) \
		$(use_enable opengl) \
		--disable-debug \
		--disable-cpucheck \
		${myconf} \
		force_arch=no \
		|| die
}

src_compile() {
	emake makefile.dep || die "emake makefile.dep failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin zsnes || die "dogamesbin failed"
	newman linux/zsnes.1 zsnes.6
	dodoc ../docs/{readme.1st,*.txt,README.LINUX}
	dodoc ../docs/readme.txt/*
	dohtml -r ../docs/readme.htm/*
	make_desktop_entry zsnes ZSNES
	newicon icons/48x48x32.png ${PN}.png
	prepgamesdirs
}
