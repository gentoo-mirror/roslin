# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="Basic side-scrolling shoot 'em up '80s style arcade game"
HOMEPAGE="http://wordwarvi.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

# See Attribution.txt for sound files licenses
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="portaudio"

DEPEND=">=x11-libs/gtk+-2.10.14
	dev-libs/atk
	portaudio? (
		media-libs/libvorbis
		media-libs/portaudio
		media-sound/vorbis-tools
		)"
RDEPEND="${DEPEND}"

dir=${GAMES_DATADIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	use portaudio && mv sounds/Attribution.txt "${S}"

	if use portaudio; then
		sed -i \
			-e "s!sounds/!${dir}/sounds/!" \
			wordwarvi.c || die "sed failed"
	fi
}

src_compile() {
	yesno() { useq $1 && echo yes || echo no; }
	emake \
		WITHAUDIO=$(yesno portaudio) \
		DATADIR="${dir}" \
		OPTIMIZE_FLAG="${CFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dodoc *.txt || die "dodoc failed"
	doman ${PN}.6 || die "doman failed"

	if use portaudio; then
		insinto "${dir}"
		doins -r sounds || die "doins failed"
	fi

	dogamesbin ${PN} || die "dogamesbin failed"

	prepgamesdirs
}
