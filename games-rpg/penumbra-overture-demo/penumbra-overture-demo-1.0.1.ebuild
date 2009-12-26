# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

DESCRIPTION="Scary first-person adventure game which focuses on story, immersion and puzzles"
HOMEPAGE="http://www.penumbra-overture.com/"
SRC_URI="PenumbraOvertureDemo-${PV}.sh"

# See /opt/penumbra-overture-demo/eng_license.rtf
LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="icon"
RESTRICT="fetch strip"

DEPEND=""
RDEPEND="dev-libs/libxml2
	icon? ( media-gfx/imagemagick )
	x86? (
		media-libs/libsdl
		virtual/glu
		virtual/opengl
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libXext
		x11-libs/libXft
		x11-libs/libXrender )
	amd64? (
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-sdl )"

# Provided in lib directory
#	media-libs/freealut
#	media-libs/jpeg
#	media-libs/libogg
#	media-libs/openal
#	media-libs/libpng
#	media-libs/libsdl
#	media-libs/sdl-image
#	media-libs/sdl-ttf
#	media-libs/libvorbis
#	x11-libs/fltk

S=${WORKDIR}/install
dir=${GAMES_PREFIX_OPT}/${PN}

QA_TEXTRELS="${dir:1}/lib/libSDL-1.2.so.0.11.0
	${dir:1}/lib/libSDL-1.2.so.0"

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
	echo
}

src_unpack() {
	unpack_makeself ${A}

	bin/linux/x86/libc.so.6/lzma-decode instarchive_all pack.tar \
		|| die "lzma-decode"

	mkdir "${S}" || die
	cd "${S}" || die
	unpack ./../pack.tar

	if use icon ; then
		convert penumbra.{ico,png} || die "convert"
	fi

	# Prevent warning that chcon does not exist
	sed -i \
		-e "s:which chcon:which chcon 2>/dev/null:" \
		penumbrademo || die "sed penumbrademo"
}

src_install() {
	insinto "${dir}"
	doins -r * || die "doins"

	exeinto "${dir}"
	doexe openurl.sh penumbrademo{,.bin} || die "doexe"

	exeinto "${dir}"/lib
	doexe lib/* || die "doexe lib"

	# Symlinks
	cd "${D}/${dir}"/lib || die
	local d f fn sym
	for f in $(find "${S}"/lib -maxdepth 1 -type l) ; do
		echo "f=${f}"
		sym=$(basename "${f}")
		echo "sym=${sym}"
		d=$(find "${S}"/lib -maxdepth 1 -name "${sym}.*")
		echo "d=${d}"
		fn=$(basename "${d}")
		if [[ -e "${fn}" ]] ; then
			# Create symlink for lib
			ln -sfn "${fn}" "${sym}" || die
		fi
	done
	# Manual exception
	ln -sfn libpng12.so.0.1.2.8 libpng.so.3 || die "ln libpng"
	cd "${S}"

	if use icon ; then
		newicon penumbra.png ${PN}.png || die "newicon"
	fi

	games_make_wrapper ${PN} "./penumbrademo.bin" "${dir}" "${dir}"/lib
	make_desktop_entry ${PN} "Penumbra: Overture (Demo)" ${PN}

	prepgamesdirs
}
