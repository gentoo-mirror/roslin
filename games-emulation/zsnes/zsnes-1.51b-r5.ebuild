# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/zsnes/zsnes-1.51-r1.ebuild,v 1.4 2007/12/04 05:08:45 vapier Exp $

EAPI=5

inherit eutils autotools flag-o-matic toolchain-funcs multilib pax-utils games

DESCRIPTION="SNES (Super Nintendo) emulator that uses x86 assembly"
HOMEPAGE="http://www.zsnes.com/ http://ipherswipsite.com/zsnes/"
SRC_URI="http://zsnes.sf.net/${PN}${PV//./}src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86 ~x86-fbsd"
IUSE="ao custom-cflags experimental opengl pax_kernel png"

RDEPEND="
	|| (
		(
			media-libs/libsdl[sound,video,abi_x86_32(-)]
			>=sys-libs/zlib-1.2.3-r1[abi_x86_32(-)]
			ao? ( media-libs/libao[abi_x86_32(-)] )
			opengl? ( virtual/opengl[abi_x86_32(-)] )
			png? ( media-libs/libpng[abi_x86_32(-)] )
		)
		amd64? (
			app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)]
			ao? ( app-emulation/emul-linux-x86-soundlibs[-abi_x86_32(-)] )
			opengl? ( app-emulation/emul-linux-x86-opengl[-abi_x86_32(-)] )
			>=app-emulation/emul-linux-x86-sdl-10.1[-abi_x86_32(-)]
		)
	)"
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

	# The sdl detection logic uses AC_PROG_PATH instead of
	# AC_PROG_TOOL, so force the var to get set the way we
	# need for things to work correctly.
	tc-is-cross-compiler && export ac_cv_path_SDL_CONFIG=${CHOST}-sdl-config

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
	if use pax_kernel; then
		pax-mark m "${D}""${GAMES_BINDIR}"/zsnes || die
	fi
	newman linux/zsnes.1 zsnes.6
	dodoc \
		../docs/{readme.1st,authors.txt,srcinfo.txt,stdards.txt,support.txt,thanks.txt,todo.txt,README.LINUX} \
		../docs/readme.txt/*
	dohtml -r ../docs/readme.htm/*
	make_desktop_entry zsnes ZSNES
	newicon icons/48x48x32.png ${PN}.png
	prepgamesdirs
}