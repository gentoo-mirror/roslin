# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games subversion autotools flag-o-matic

DESCRIPTION="Playstation2 emulator"
HOMEPAGE="http://www.pcsx2.net/"

PCSX2_SVN_URI="http://pcsx2-playground.googlecode.com/svn/trunk"
ESVN_REPO_URI="${PCSX2_SVN_URI}/pcsx2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="custom-cflags debug devbuild nls sse3 sse4"

CDEPEND="sys-libs/zlib
	>=x11-libs/gtk+-2"

DEPEND="${CDEPEND}
	x11-proto/xproto"

RDEPEND="${CDEPEND}"

S="${WORKDIR}/${P}/pcsx2"

LANGS="ar bg cz de du el es fr hb it ja pe pl po po_BR ro ru sh sw tc tr"

for i in ${LANGS}; do
	IUSE="${IUSE} linguas_${i}"
done

pkg_setup() {
	local x

	if ! use nls; then
		for x in ${LANGS}; do
			if [ -n "$(usev linguas_${x})" ]; then
				eerror "Any language other than English is not supported with USE=\"-nls\""
				die "Language ${x} not supported with USE=\"-nls\""
			fi
		done
	fi
}



src_unpack() {
		# Download just the dirs we need, not the whole repo
		subversion_src_unpack
		subversion_fetch "${PCSX2_SVN_URI}/bin" "../bin"
		subversion_fetch "${PCSX2_SVN_URI}/common" "../common"
		cd ${S}
		
		# Preserve custom CFLAGS passed to configure.
		#epatch "${FILESDIR}"/${PN}-custom-cflags.patch

		# Allow plugin inis to be stored in ~/.pcsx2/inis.
		#epatch "${FILESDIR}"/${PN}-plugin-inis.patch
		
		eautoreconf -v --install || die
}

src_compile() {
	local myconf
	filter-flags -O0
	
	egamesconf  \
		$(use_enable devbuild) \
		$(use_enable debug) \
		$(use_enable sse3) \
		$(use_enable sse4) \
		$(use_enable custom-cflags customcflags) \
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

	cd ../bin
	dohtml -r compat_list/* || die
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r *.xml .pixmaps patches || die
	insinto "${GAMES_DATADIR}/${PN}/Langs"

	for x in ${LANGS}; do
		if use linguas_${x}; then
			[[ "${x/_/}" == "${x}" ]] && x=${x}_`echo ${x} | tr 'a-z' 'A-Z'`
			doins -r Langs/${x} || die "doins for language ${x} failed"
		fi
	done

	make_desktop_entry pcsx2pp "PCSX2 PP" xgame

	prepgamesdirs
}

