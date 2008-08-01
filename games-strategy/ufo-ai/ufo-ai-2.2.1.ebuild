# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/ufo-ai/ufo-ai-2.1.1-r1.ebuild,v 1.1 2007/09/27 23:58:39 nyhm Exp $

inherit eutils autotools games

MY_P="${P/o-a/oa}"
DESCRIPTION="UFO: Alien Invasion - X-COM inspired strategy game"
HOMEPAGE="http://ufoai.sourceforge.net/ http://ufoai.ninex.info/"
SRC_URI="mirror://sourceforge/ufoai/${MY_P}-source.tar.bz2
	mirror://sourceforge/ufoai/${MY_P}-data.tar"
	# mirror://sourceforge/ufoai/${MY_P}-mapsource.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="alsa arts debug dedicated dga doc ipv6 jack master oss paranoid nls openal dev"

# Dependencies and more instructions can be found here:
# http://ufoai.ninex.info/wiki/index.php/Compile_for_Linux
RDEPEND="virtual/opengl
	virtual/glu
	>=media-libs/libsdl-1.2.10
	>=media-libs/sdl-ttf-2.0.7
	>=media-libs/sdl-mixer-1.2.7
	media-libs/jpeg
	media-libs/libpng
	media-libs/libogg
	media-libs/libvorbis
	net-misc/curl
	virtual/libintl
	x11-proto/xf86vidmodeproto
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	dga? ( x11-libs/libXxf86dga )
	jack? ( media-sound/jack-audio-connection-kit )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	doc? ( virtual/latex-base )
	dev? ( app-doc/doxygen )"

S=${WORKDIR}/${MY_P}-source
dir=${GAMES_DATADIR}/${PN}

src_unpack() {
	if use dev ; then
		ewarn "Building developement manual (USE=dev) takes a lot of time and disk space!"
	fi

	unpack ${A}
	cd "${S}"
	# move data from packages to source dir
	mv "${WORKDIR}/base" ${S}

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
# Forces building of client.
# gettext is required to show the intro text.
	egamesconf \
		$(use_enable dedicated) \
		$(use_enable master) \
		$(use_enable !debug release) \
		$(use_enable paranoid) \
		--with-vid-glx \
		--with-vid-vidmode \
		--with-sdl \
		--with-snd-sdl \
		--with-shaders \
		$(use_with alsa snd-alsa) \
		$(use_with arts snd-arts) \
		$(use_with jack snd-jack) \
		$(use_with oss snd-oss) \
		$(use_with dga vid-dga) \
		$(use_with ipv6) \
		--with-gettext \
		$(use_with openal) \
		|| die "egamesconf failed"
	if use nls ; then
		# emake update-po || die "emake updating langs failed"
		emake lang || die "emake langs failed"
	fi
	# we want maps, what could we do for it?
	# they say we could compile them, but it is not working, so use bundled ones
	# (taging also download link)
	# emake maps || die "emake maps failed"
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
	cd ${S}
	newgamesbin ufo ${PN} || die
	newicon src/ports/linux/installer/data/ufo.xpm ${PN}.xpm || die
	make_desktop_entry ${PN} "UFO: Alien Invasion" ${PN}.xpm
	if use dedicated ; then
		dogamesbin ufoded || die
	fi

	if use master ; then
		dogamesbin ufomaster || die
	fi

	if [[ -f ufo2map ]] ; then
		dogamesbin ufo2map || die
	fi
	insinto "${dir}"
	doins -r base || die "doins -r failed"

	if use doc ; then
#		dohtml -r docs/html/*
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
