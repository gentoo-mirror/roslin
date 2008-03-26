# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

DESCRIPTION="quake1 utilizing a hand drawn engine"
HOMEPAGE="http://www.cs.wisc.edu/graphics/Gallery/NPRQuake/ http://www.tempestgames.com/ryan/"
SRC_URI="http://www.geocities.com/coolguywithgun/NPRQuake.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="cdinstall"

DEPEND="media-libs/libsdl
	sys-libs/glibc"
RDEPEND="${DEPEND}
	cdinstall? ( games-fps/quake1-data )"

S=${WORKDIR}/NPRQuake

GENTOO_LIBDIR=$(games_get_libdir)/${PN}
GENTOO_DATADIR=${GAMES_DATADIR}/quake1

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch \
		"${FILESDIR}"/${PN}-save-in-home.patch \
		"${FILESDIR}"/${PN}-exec-stack.patch \
		"${FILESDIR}"/${PN}-makefiles.patch \
		"${FILESDIR}"/${PN}-sys_printf.patch \
		|| die "epatch failed"

	# fix libdirs
	sed -i \
		-e "s|GENTOO_LIBDIR|\"${GENTOO_LIBDIR}\"|" \
		NPRQuakeSrc/gl_rmisc.c || die "sed"
	sed -i \
		-e "s|brushes|${GENTOO_LIBDIR}/brushes|" \
		dynamic_r/brush.c || die "sed"
	sed -i \
		-e "s|colors.txt|${GENTOO_LIBDIR}/colors.txt|" \
		-e "s|File(\"textures|File(\"${GENTOO_LIBDIR}/textures|" \
		dynamic_r/ainpr.c || die "sed"

	# fix datadir
	sed -i \
		-e "s|GENTOO_DATADIR|\"${GENTOO_DATADIR}\"|" \
		NPRQuakeSrc/common.c || die "sed"

	# some cleanup
	rm -r build/id1 build/textures/CVS \
		build/quake build/tex* || die "rm failed"

	edos2unix build/colors.txt
}

src_compile() {
	emake \
		OPTFLAGS="${CFLAGS}" \
		release \
		|| die "emake failed"
}

src_install() {
	dodoc README CHANGELOG

	newgamesbin NPRQuakeSrc/release*/bin/* nprquake-sdl \
		|| die "newgamesbin failed"

	mv build/dr_default.so build/default.so

	insinto "${GENTOO_LIBDIR}"
	doins -r \
		build/brushes build/textures build/*.txt || die "doins failed"
	exeinto "${GENTOO_LIBDIR}"
	doexe build/*.so || die "dolib.so failed"

	dosym "${GENTOO_LIBDIR}"/sketch.so "${GENTOO_LIBDIR}"/dr_default.so

	prepgamesdirs
}
