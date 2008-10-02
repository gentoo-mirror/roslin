# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/openttd/openttd-0.5.3.ebuild,v 1.3 2007/10/20 18:59:16 pylon Exp $

inherit eutils games

MY_P=${P/_rc/-RC}

SCENARIOS_048="${PN}-0.4.8-scenarios.tar.bz2"
SCENARIOS_050="${PN}-0.5.0-scenarios.tar.bz2"

DESCRIPTION="OpenTTD is a clone of Transport Tycoon Deluxe"
HOMEPAGE="http://www.openttd.com/"
SB="mirror://sourceforge/openttd"
SRC_URI="${SB}/${MY_P}-source.tar.bz2
		scenarios? ( ${SB}/${SCENARIOS_048}
			${SB}/${SCENARIOS_050} )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="alsa debug dedicated iconv png scenarios static timidity unicode zlib"

DEPEND="!dedicated? (
			media-libs/libsdl
			media-libs/fontconfig
		)
		iconv? ( virtual/libiconv )
		png? ( media-libs/libpng )
		zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}
		!dedicated? (
			timidity? ( media-sound/timidity++ )
			!timidity? ( alsa? ( media-sound/alsa-utils ) )
		)"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	if ! use dedicated && ! built_with_use media-libs/libsdl X ; then
		die "Please emerge media-libs/libsdl with USE=X"
	fi
	games_pkg_setup
}

src_unpack() {
	unpack ${MY_P}-source.tar.bz2

	if use scenarios ; then
		cd "${S}"/bin/scenario/
		unpack ${SCENARIOS_048}
		unpack ${SCENARIOS_050}
	fi

	cd "${S}"
	epatch "${FILESDIR}/libiconv.patch"
}

src_compile() {
	local myopts=""
	use debug && myopts="${myopts} --enable-debug=3"
	use dedicated && myopts="${myopts} --enable-dedicated --without-sdl"
	use unicode || myopts="${myopts} --disable-unicode"
	if ! use dedicated; then
		myopts="${myopts} --with-sdl --with-freetype --with-fontconfig"
		if ! use timidity; then
			use alsa && myopts="${myopts} --with-midi=/usr/bin/aplaymidi"
		fi
	fi

	# configure is a hand-written sh-script, so econf will not work
	./configure --os=UNIX --shared-dir="${GAMES_DATADIR}"/${PN}/ \
		$(use_enable static) \
		$(use_with iconv) \
		$(use_with png) \
		$(use_with zlib) \
		${myopts} \
		|| die "configure failed"

	emake \
		MANUAL_CONFIG=1 \
		INSTALL=1 \
		USE_HOMEDIR=1 \
		DEST_DIR="${D}" \
		PERSONAL_DIR=.openttd \
		PREFIX="${GAMES_PREFIX}" \
		INSTALL_DATA_DIR="${GAMES_DATADIR}"/${PN}/ \
		|| die "emake failed"
}

src_install() {
	dogamesbin bin/openttd || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}"/${PN}/data
	doins  bin/data/* || die "doins failed (data)"

	insinto "${GAMES_DATADIR}"/${PN}/lang
	doins bin/lang/*.lng || die "doins failed (lang)"

	if use scenarios ; then
		insinto "${GAMES_DATADIR}"/${PN}/scenario
		doins bin/scenario/*.scn || die "doins failed (scenario)"
		doins bin/scenario/*/*.scn || die "doins failed (scenario)"
	fi

	insinto "${GAMES_DATADIR}"/${PN}/scripts
	doins bin/scripts/*.example || die "doins failed (scripts)"

	for i in {16,32,48,64,128}; do
		insinto /usr/share/icons/hicolor/${i}x${i}/apps
		newins media/openttd.${i}.png openttd.png
	done

	if ! use dedicated ; then
		if use timidity || use alsa ; then
			make_desktop_entry "openttd -m extmidi" "OpenTTD" openttd
		else
			make_desktop_entry openttd "OpenTTD" openttd
		fi
	else
		newinitd "${FILESDIR}"/openttd.initd openttd
	fi

	dodoc readme.txt known-bugs.txt changelog.txt docs/Manual.txt \
		docs/multiplayer.txt
	dohtml -a html,gif,png,svg docs/*
	newdoc scripts/readme.txt readme_scripts.txt
	doman docs/openttd.6
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	elog
	elog "In order to play, you must copy the following 6 files from "
	elog "a version of TTD to ${GAMES_DATADIR}/${PN}/data/."
	elog
	elog "From the WINDOWS version you need: "
	elog "  sample.cat trg1r.grf trgcr.grf trghr.grf trgir.grf trgtr.grf"
	elog "OR from the DOS version you need: "
	elog "  SAMPLE.CAT TRG1.GRF TRGC.GRF TRGH.GRF TRGI.GRF TRGT.GRF"
	elog
	elog "File names are case sensitive so make sure they are "
	elog "correct for whichever version you have."
	elog

	if use scenarios ; then
		elog "Scenarios are installed into:"
		elog "${GAMES_DATADIR}/${PN}/scenario,"
		elog "you will have to symlink them to ~/.openttd/scenario in order"
		elog "to use them."
		elog "Example:"
		elog " ln -s ${GAMES_DATADIR}/${PN}/scenario ~/.openttd/scenario"
		elog
	fi

	if use dedicated ; then
		ewarn "Warning: The init script will kill all running openttd"
		ewarn "processes when run, including any running client sessions!"
	else
		if use timidity || use alsa ; then
			elog "If you want music, you must copy the gm/ directory to"
			elog "${GAMES_DATADIR}/${PN}/"
			elog "You can enable MIDI by running:"
			elog "  openttd -m extmidi"
			elog
			if use timidity ; then
				elog "You also need soundfonts for timidity, if you don't"
				elog "know what that is, do:"
				elog
				elog "emerge media-sound/timidity-eawpatches"
			else
				elog "You have emerged with 'aplaymidi' for playing MIDI."
				elog "You have to set the environment variable ALSA_OUTPUT_PORTS."
				elog "Available ports can be listed by using 'aplaymidi -l'."
			fi
		else
			elog "timidity and/or alsa not in USE so music will not be played during the game."
		fi
		elog
	fi
}
