# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/ufo-ai/ufo-ai-2.1.1-r1.ebuild,v 1.1 2007/09/27 23:58:39 nyhm Exp $

inherit eutils autotools games

MY_P="${P/o-a/oa}"

DESCRIPTION="UFO: Alien Invasion - X-COM inspired strategy game"
HOMEPAGE="http://ufoai.sourceforge.net/ http://ufoai.ninex.info/"
SRC_URI="mirror://sourceforge/ufoai/${MY_P}-source.tar.bz2
	mirror://sourceforge/ufoai/${MY_P}-data.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug dedicated dev doc editor mmx nls paranoid profile"

# Dependencies and more instructions can be found here:
# http://ufoai.ninex.info/wiki/index.php/Compile_for_Linux
RDEPEND="!dedicated? (
		virtual/opengl
		virtual/glu
		>=media-libs/libsdl-1.2.10
		>=media-libs/sdl-ttf-2.0.7
		>=media-libs/sdl-mixer-1.2.7
		media-libs/jpeg
		media-libs/libpng
		media-libs/libogg
		media-libs/libvorbis
		x11-proto/xf86vidmodeproto
	)
	net-misc/curl
	nls? ( virtual/libintl )
	sys-libs/zlib"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	doc? ( virtual/latex-base )
	dev? ( app-doc/doxygen )"

S=${WORKDIR}/${MY_P}-source
dir=${GAMES_DATADIR}/${PN}

src_unpack() {
	use dev && ewarn "Building developement manual (USE=dev) takes a lot of time and disk space!"

	unpack ${A}
	cd "${S}"
	# move data from packages to source dir
	mv "${WORKDIR}/base" "${S}"

	# Set basedir
	sed -i \
		-e "s:\"fs_basedir\", \"\.\":\"fs_basedir\", \"${dir}\":" \
		src/common/files.c || die "sed files.c failed"

	sed -i \
		-e "s:/usr/local/games/ufoai:${dir}:" \
		src/tools/gtkradiant/games/ufoai.game || die "sed ufoai.game failed"

	# Fixes bug in finding text files - it should use fs_basedir
	sed -i \
		-e "s:FS_GetCwd():\"${dir}\":" \
		src/client/cl_main.c || die "sed cl_main.c failed"
	sed -i \
		-e "s:FS_GetCwd():\"${dir}\":" \
		src/client/cl_language.c || die "sed cl_language.c failed"
	eautoreconf
}

src_compile() {
	local MYOPTS
	if use dedicated; then
		# disable client and enable server
		MYOPTS="--enable-dedicated --disable-client"
	else
		# enable both client and server
		MYOPTS="--enable-dedicated --enable-client"
	fi
	egamesconf \
		$(use_enable mmx) \
		$(use_enable !debug release) \
		$(use_enable profile profiling) \
		$(use_enable editor ufo2map) \
		$(use_enable paranoid) \
		${MYOPTS} \
		--with-shaders

	if use nls ; then
		emake lang || die "emake langs failed"
	fi

	if use doc ; then
		emake pdf-manual || die "emake pdf-manual failed (USE=doc)"
	fi

	if use dev ; then
		emake doxygen-docs || die "emake doxygen-docs failed (USE=dev)"
	fi

	emake || die "emake failed"
}

src_install() {
	# ufo is usually started by a "ufoai" wrapper script.
	# Might as well standardize on the ebuild name, for minimum confusion.
	cd "${S}"
	if use dedicated ; then
		# server
		newgamesbin ufoded ${PN}-ded || die
		newicon src/ports/linux/installer/data/ufo.xpm ${PN}.xpm || die
		make_desktop_entry ${PN}-ded "UFO: Alien Invasion Server" ${PN}.xpm
	else
		# client
		newgamesbin ufo ${PN} || die
		newicon src/ports/linux/installer/data/ufo.xpm ${PN}.xpm || die
		make_desktop_entry ${PN} "UFO: Alien Invasion" ${PN}.xpm
		# server
		newgamesbin ufoded ${PN}-ded || die
		newicon src/ports/linux/installer/data/ufo.xpm ${PN}.xpm || die
		make_desktop_entry ${PN}-ded "UFO: Alien Invasion Server" ${PN}.xpm
	fi

	if use editor ; then
		dogamesbin ufo2map || die
	fi

	insinto "${dir}"
	doins -r base || die "doins -r failed"

	if use doc ; then
		insinto "/usr/share/doc/${PF}/"
		newins src/docs/tex/ufo-manual_EN.pdf ufo-manual_EN.pdf
		elog "PDF manual is located at /usr/share/doc/${PF}/"
	fi

	if use dev ; then
		dohtml -A idx -A php -r src/docs/doxygen/html/*
		elog "Dev doc is located at /usr/share/doc/${PF}/html"
	fi

	prepgamesdirs
}
