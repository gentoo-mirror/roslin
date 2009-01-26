# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_DIR="travail"
MOD_TITLE="Travail"
MOD_USES_QRACK=y

inherit eutils games games-mod

DESCRIPTION="Large Quake 1 mission with 2 episodes, supporting co-op play"
HOMEPAGE="http://www.quakeone.com/travail/"
SRC_URI="${SRC_ADDICT}/${MOD_DIR}.zip
	soundtrack? ( ${SRC_ADDICT}/${MOD_DIR}_soundtrack.zip )"

IUSE="soundtrack"
MOD_DEPEND="soundtrack? ( media-sound/mp32ogg )"

pkg_setup() {
	games_pkg_setup

	if use !darkplaces && use soundtrack; then
		einfo ""
		einfo "Darkplaces can play a \"fake\" soundtrack from OGG files."
		einfo "Please make sure your engine of choice has this feature."
		einfo "Otherwise, installing the soundtrack is just a waste of space."
		einfo ""
	fi
}

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"

	if use soundtrack; then
		mkdir cdtracks
		mv T*mp3 cdtracks
		for i in cdtracks/T*; do mv "$i" "${i//T/track}"; done
	fi

	games-mod_src_unpack_tidy

	echo "r_novis 0" > "${MOD_DIR}"/autoexec.cfg
}

src_compile() {
	if use soundtrack; then
		mp32ogg --delete cdtracks || die "mp32ogg failed"
	fi
}

src_install() {
	if use soundtrack; then
		insinto "${dir}/${MOD_DIR}"
		doins -r cdtracks || die "doins failed"
	fi

	games-mod_src_install

	prepgamesdirs
}
