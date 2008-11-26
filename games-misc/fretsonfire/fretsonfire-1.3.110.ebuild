# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils python games

MY_PN="FretsOnFire"
DESCRIPTION="A game of musical skill and fast fingers"
HOMEPAGE="http://fretsonfire.sourceforge.net/"
SRC_URI="mirror://sourceforge/fretsonfire/${MY_PN}-${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="glew guitarhero psyco"

DEPEND=""
RDEPEND=">=dev-lang/python-2.4
	>=dev-python/numeric-23.8
	>=dev-python/pyopengl-3.0.0_beta
	dev-python/pyvorbis
	dev-python/pygame
	dev-python/imaging
	dev-python/numpy
	psyco? ( dev-python/psyco )
	glew? ( dev-python/glewpy )
	guitarhero? ( media-sound/vorbis-tools )"

S="${WORKDIR}/Frets on Fire-${PV}"

pkg_setup() {
	if ! built_with_use media-libs/sdl-mixer vorbis ; then
		die "Please emerge media-libs/sdl-mixer with USE=vorbis"
	fi
	games_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f Makefile

	sed -i -e "s:\(FretsOnFire.py\):$(games_get_libdir)/${PN}/\1:" \
		src/FretsOnFire.py || die "sed FretsOnFire.py failed"
	sed -i -e "s:os.path.join(\"..\", \"\(data\)\"):\"${GAMES_DATADIR}/${PN}/\1\":" \
		src/Version.py || die "sed Version.py failed"
}

src_install() {
	# remove some cruft
	rm -f data/PyOpenGL__init__.pyc
	insinto "$(games_get_libdir)/${PN}"
	doins -r src/*.py src/midi || die "doins failed (*.py)"

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data || die "doins failed (data)"

	games_make_wrapper ${MY_PN} "python FretsOnFire.py" "$(games_get_libdir)/${PN}"

	dodoc readme.txt todo.txt
	dohtml -r doc/html/*

	newicon data/icon.png ${PN}.png
	make_desktop_entry ${MY_PN} "Frets on Fire"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	python_mod_optimize "${ROOT}$(games_get_libdir)/${PN}"
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}$(games_get_libdir)/${PN}"
}
