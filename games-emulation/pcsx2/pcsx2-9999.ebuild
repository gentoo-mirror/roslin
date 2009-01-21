# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games subversion autotools flag-o-matic

DESCRIPTION="Playstation2 emulator"
HOMEPAGE="http://www.pcsx2.net/"

PCSX2_SVN_URI="https://${PN}.svn.sourceforge.net/svnroot/${PN}"
ESVN_REPO_URI="${PCSX2_SVN_URI}/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="alsa debug devbuild nls oss sse3 vmbuild"

CDEPEND="sys-libs/zlib
		>=x11-libs/gtk+-2"

DEPEND="${CDEPEND}
		x11-proto/xproto"

RDEPEND="${CDEPEND}
		=games-emulation/ps2emu-zerogs-9999
		=games-emulation/ps2emu-zeropad-9999
		=games-emulation/ps2emu-cdvdnull-9999
		=games-emulation/ps2emu-dev9null-9999
		=games-emulation/ps2emu-spu2null-9999
		=games-emulation/ps2emu-fwnull-9999
		=games-emulation/ps2emu-usbnull-9999
		alsa? ( =games-emulation/ps2emu-peopsspu2-9999 )
		oss? ( =games-emulation/ps2emu-peopsspu2-9999 )
		ieee1394? ( =games-emulation/ps2emu-fwlinuz-9999 )
		usb? ( =games-emulation/ps2emu-usblinuz-9999 )"

S=${WORKDIR}/${PN}

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

	if use vmbuild; then
		ewarn "Warning: Compilation is known to fail with the vmbuild use flag enabled"
		ebeep 5
	fi
}

src_unpack() {
		# Download just the dirs we need, not the whole repo
		subversion_src_unpack
		subversion_fetch ${PCSX2_SVN_URI}/bin ../bin

		cd "${S}"

		# Preserve custom CFLAGS passed to configure.
		epatch "${FILESDIR}"/${PN}-0.9.4-custom-cflags.patch

		# Add nls support to the configure script.
		epatch "${FILESDIR}"/${PN}-0.9.4-add-nls.patch

		# Allow plugin inis to be stored in ~/.pcsx2/inis.
		epatch "${FILESDIR}"/${PN}-0.9.4-plugin-inis.patch

		# GCC 4.3 fix
		epatch "${FILESDIR}"/${PN}-gcc43.patch

		eautoreconf -v --install || die
}

src_compile() {
	local myconf
	filter-flags -O0

	if ! use x86 && ! use amd64; then
		einfo "Recompiler not supported on this architecture. Disabling."
		myconf=" --disable-recbuild"
	fi

	egamesconf \
		$(use_enable devbuild) \
		$(use_enable debug) \
		$(use_enable nls) \
		$(use_enable sse3) \
		$(use_enable vmbuild) \
		${myconf} \
		|| die

	emake || die
}

src_install() {
	local x

	keepdir "`games_get_libdir`/ps2emu/plugins"
	dodoc Docs/*.txt || die "dodoc failed"
	newgamesbin Linux/${PN} ${PN}.bin || die

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

	make_desktop_entry pcsx2 PCSX2 xgame

	prepgamesdirs
}

