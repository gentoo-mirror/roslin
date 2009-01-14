# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils python games

MY_PN="FretsOnFire"
DESCRIPTION="A game of musical skill and fast fingers"
HOMEPAGE="http://fretsonfire.sourceforge.net/"
SRC_URI="mirror://sourceforge/fretsonfire/${MY_PN}-src-${PV}.tar.gz
	mirror://sourceforge/fretsonfire/${MY_PN}-${PV}-linux.tar.gz"
#	ghmod? ( http://www.phonotheque.ca/fof/GHmod${PV}.rar )"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
#IUSE="ghmod glew guitarhero psyco"
IUSE="glew guitarhero psyco"

DEPEND=""
RDEPEND=">=dev-lang/python-2.3
	>=dev-python/numeric-23.8
	>=dev-python/pyopengl-2.0.1.09
	dev-python/pyvorbis
	dev-python/pygame
	dev-python/PyAmanith
	dev-python/imaging
	dev-python/numpy
	psyco? ( dev-python/psyco )
	glew? ( dev-python/glewpy )
	guitarhero? ( media-sound/vorbis-tools )
	media-libs/sdl-mixer[vorbis]"

S="${WORKDIR}/${MY_PN}-src-${PV}"

src_prepare() {
	rm -f Makefile

	sed -i -e "s:\(FretsOnFire.py\):$(games_get_libdir)/${PN}/\1:" \
		src/FretsOnFire.py || die "sed FretsOnFire.py failed"
	sed -i -e "s:os.path.join(\"..\", \"\(data\)\"):\"${GAMES_DATADIR}/${PN}/\1\":" \
		src/Version.py || die "sed Version.py failed"
}

src_install() {
	insinto "$(games_get_libdir)/${PN}"
	doins -r src/*.py src/midi || die "doins failed (*.py)"

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r ../FretsOnFire/data || die "doins failed (data)"

#	if use ghmod ; then
#	    insinto "${GAMES_DATADIR}/${PN}"
#	    doins -r "../GHmod${PV}/FretsOnFire/data" || die "doins failed (ghmod)"
#	fi

	games_make_wrapper ${MY_PN} "python FretsOnFire.py" "$(games_get_libdir)/${PN}"

	dodoc readme.txt todo.txt
	dohtml -r doc/html/*

	newicon ../FretsOnFire/data/icon.png ${PN}.png
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
