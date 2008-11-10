# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games subversion autotools flag-o-matic

DESCRIPTION="Playstation2 emulator"
HOMEPAGE="http://www.pcsx2.net/"

ESVN_REPO_URI="http://pcsx2-playground.googlecode.com/svn/trunk/pcsx2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug devbuild sse3 vmbuild"

CDEPEND="sys-libs/zlib
		>=x11-libs/gtk+-2"

DEPEND="${CDEPEND}
		x11-proto/xproto"

RDEPEND="${CDEPEND}"

pkg_setup() {
	if use vmbuild; then
		ewarn "Warning: Compilation is known to fail with the vmbuild use flag enabled"
		ebeep 5
	fi
}

src_unpack() {
		# Download just the dirs we need, not the whole repo
		subversion_fetch
		cd ${S}

		# Preserve custom CFLAGS passed to configure.
		epatch "${FILESDIR}"/${PN}-custom-cflags.patch

		# Allow plugin inis to be stored in ~/.pcsx2/inis.
		#epatch "${FILESDIR}"/${PN}-plugin-inis.patch
		
		eautoreconf -v --install || die
}

src_compile() {
	local myconf
	filter-flags -O0
	
	if ! use x86 && ! use amd64; then
		einfo "Recompiler not supported on this architecture. Disabling."
		myconf=" --disable-recbuild"
	fi

	egamesconf  \
		$(use_enable devbuild) \
		$(use_enable debug) \
		$(use_enable sse3) \
		$(use_enable vmbuild) \
		|| die

	emake || die
}

src_install() {
	dodoc Docs/*.txt || die "dodoc failed"
	newgamesbin Linux/pcsx2 ${PN}.bin || die

	sed \
		-e "s:%GAMES_BINDIR%:${GAMES_BINDIR}:" \
		-e "s:%GAMES_DATADIR%:${GAMES_DATADIR}:" \
		-e "s:%GAMES_LIBDIR%:`games_get_libdir`:" \
		"${FILESDIR}/${PN}" > "${D}${GAMES_BINDIR}/${PN}" || die

	make_desktop_entry pcsx2pp "PCSX2 PP" xgame

	prepgamesdirs
}

