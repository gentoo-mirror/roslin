# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit toolchain-funcs eutils games

DESCRIPTION="Online 2D platform shooter."
HOMEPAGE="http://www.teeworlds.com"
SRC_URI="http://www.teeworlds.com/files/${P}-src.tar.gz
	http://www.teeworlds.com/files/bam.zip"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa debug dedicated oss"

RDEPEND="!dedicated? (
		alsa? ( media-libs/alsa-lib )
		oss? ( || ( media-sound/oss media-sound/oss-devel ) )
		media-libs/mesa
		x11-libs/libX11 )"
DEPEND="${RDEPEND}
	app-arch/zip"

S=${WORKDIR}/${P}-src

src_prepare() {
	# the data-dir needs to be patched in some files
	sed -i \
		-e "s:data/:${GAMES_DATADIR}/${PN}/data/:g" \
		$(grep -Rl '"data\/' *) \
		|| die "sed failed"
	if use oss; then
		epatch "${FILESDIR}"/teeworlds-oss.patch
	fi
	rm -f license.txt
}

src_compile() {
	cd "${WORKDIR}"/bam
	$(tc-getCC) ${CFLAGS} src/tools/txt2c.c -o src/tools/txt2c || die
	src/tools/txt2c < src/base.bam > src/internal_base.h || die
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} \
		src/lua/src/*.c src/lua/src/lib/*.c src/*.c -o src/bam \
		-I src/lua/include/ -lm -lpthread || die

	cd "${S}"
	sed -i \
		-e "s|cc.flags = \"-Wall -pedantic-errors\"|cc.flags = \"${CXXFLAGS}\"|" \
		-e "s|linker.flags = \"\"|linker.flags = \"${LDFLAGS}\"|" \
		-e "s|-Wall -fstack-protector -fstack-protector-all -fno-exceptions|${CXXFLAGS}|" \
		default.bam || die "sed failed"

	if use dedicated ; then
		../bam/src/bam -v server_release || die "bam failed"
	else
		../bam/src/bam -v release || die "bam failed"
	fi
}

src_install() {
	dogamesbin ${PN}_srv || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"/data/maps
	doins data/maps/* || die "doins failed"

	if ! use dedicated ; then
		dogamesbin ${PN} || die "dogamesbin failed"
		insinto "${GAMES_DATADIR}/${PN}"
		doins -r data || die "doins failed"
		make_desktop_entry ${PN} "Teeworlds"
	fi

	dodoc *.txt || die "dodoc failed"
	prepgamesdirs
}
