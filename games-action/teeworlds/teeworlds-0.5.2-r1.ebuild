# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit confutils toolchain-funcs eutils games

BAM_P="bam-0.2.0"
DESCRIPTION="Online 2D platform shooter."
HOMEPAGE="http://www.teeworlds.com"
SRC_URI="http://www.teeworlds.com/files/${P}-src.tar.gz -> ${P}-src.tar.gz
	http://teeworlds.com/trac/bam/browser/releases/bam-0.2.0.tar.gz?format=raw -> ${BAM_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug dedicated instagib racemod"

RDEPEND="dev-lang/lua
	!dedicated? (
		media-libs/libpnglite
		media-libs/libsdl[X,opengl]
		media-sound/wavpack
		sys-libs/zlib
	)"
# has modified wavpack and pnglite in its sources
# not worth of effort patching up to system ones
DEPEND="${RDEPEND}
	app-arch/zip"

S=${WORKDIR}/${P}-src
# that's a temporary fix for datadir location
dir=${GAMES_DATADIR}/${PN}

pkg_setup() {
	confutils_use_conflict instagib racemod
	dodir /etc/${P}
	enewgroup games
	enewuser teeworlds -1 -1 -1 games
}

src_prepare() {
	rm -f license.txt

	epatch "${FILESDIR}"/system-libs.patch
	epatch "${FILESDIR}"/new-wavpack.patch
#	epatch "${FILESDIR}"/fix_datadir_search.patch
	use instagib && epatch "${FILESDIR}"/instagib-2.2.patch
	use racemod && epatch "${FILESDIR}/${PV}-racemod-2.3.patch"
}

src_compile() {
	# compile bam
	ebegin "Preparing BAM"
	cd "${WORKDIR}/${BAM_P}"
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} \
		src/tools/txt2c.c -o src/tools/txt2c || die
	src/tools/txt2c src/base.bam src/driver_gcc.bam \
	src/driver_cl.bam > src/internal_base.h || die
	# internal lua sources!
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} \
		src/lua/*.c src/*.c -o src/bam \
		-I /usr/include/ -lm -lpthread || die
	eend $?
	# compile game
	cd "${S}"

	sed -i -e "s:audio/:${GAMES_DATADIR}/${PN}/data/audio/:g" datasrc/content.py || die "sed failed"
	sed -i -e "s:/usr/share/${PN}:${GAMES_DATADIR}/${PN}:g" src/engine/e_engine.c || die "sed failed"
	sed -i -e "s:mapres/:${GAMES_DATADIR}/${PN}/data/mapres/:g" $(grep -Rl '"mapres\/' *) || die "sed failed"
	sed -i -e "s:maps/:${GAMES_DATADIR}/${PN}/data/maps/:g" $(grep -Rl '"maps\/' *) || die "sed failed"
	sed -i -e "s:skins/:${GAMES_DATADIR}/${PN}/data/skins/:g" $(grep -Rl '"skins\/' *) || die "sed failed"
	sed -i -e "s:editor/:${GAMES_DATADIR}/${PN}/data/editor/:g" $(grep -Rl '"editor\/' *) || die "sed failed"
	sed -i -e "s:fonts/:${GAMES_DATADIR}/${PN}/data/fonts/:g" $(grep -Rl '"fonts\/' *) || die "sed failed"
	sed -i -e "s:[a-z_]*\.png:${GAMES_DATADIR}/${PN}/data\/&:ig" datasrc/content.py || die "sed failed"
	sed -i -e "s:[a-z_]*\.png:${GAMES_DATADIR}/${PN}/data\/&:ig" scripts/png.py || die "sed failed"
	sed -i -e "s:[a-z_]*\.png:${GAMES_DATADIR}/${PN}/data\/&:ig" src/engine/client/ec_client.c || die "sed failed"
	sed -i -e "s:[a-z_]*\.png:${GAMES_DATADIR}/${PN}/data\/&:ig" src/engine/client/ec_gfx.c || die "sed failed"
	sed -i -e "s:[a-z_]*\.png:${GAMES_DATADIR}/${PN}/data\/&:ig" src/game/client/components/menus.cpp || die "sed failed"
	sed -i -e "s:x_ninja:${GAMES_DATADIR}/${PN}/data\/&:ig" src/game/client/components/players.cpp || die "sed failed"
	sed -i -e "s:\"skins\"\,:\"${GAMES_DATADIR}/${PN}/data\/skins\"\,:i" src/game/client/components/skins.cpp || die "sed failed"

	sed -i \
		-e "s|Add(\"-Wall\", \"-fno-exceptions|Add(\"|" \
		-e "s|cc.flags:Add(\"-fstack-protector\", \"-fstack-protector-all\")|cc.flags:Add(\"${CXXFLAGS}\")|" \
		-e "s|link.flags:Add(\"-fstack-protector\", \"-fstack-protector-all\")|link.flags:Add(\"${LDFLAGS}\")|" \
		default.bam || die "sed failed"

	local opts=""
	use dedicated && opts="server_"
	use debug && opts="${opts}debug" || opts="${opts}release"

	../${BAM_P}/src/bam -v ${opts}
}

src_install() {
	if use debug ; then
		newgamesbin ${PN}_srv_d ${PN}_srv || "newgamesbin failed"
	else
		dogamesbin ${PN}_srv || die "dogamesbin failed"
	fi

	if ! use dedicated ; then
		if use debug ; then
			newgamesbin ${PN}_d ${PN} || die "newgamesbin failed"
		else
			dogamesbin ${PN} || die "dogamesbin failed"
		fi
		newicon other/icons/Teeworlds.ico ${PN}.ico
	    make_desktop_entry ${PN} "Teeworlds"
		insinto "${dir}"
		doins -r data || die "doins failed"
	else
		insinto "${dir}"/data/maps
		doins data/maps/* || die "doins failed"
	fi

	dodoc *.txt
	prepgamesdirs
	newinitd "${FILESDIR}"/teeworlds_init teeworlds
}