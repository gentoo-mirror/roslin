# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit distutils games

DESCRIPTION="A simple, GTK+ frontend / launcher for mednafen, written in python."
HOMEPAGE="http://mednafenfe.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/mednafenfe/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="dev-python/configobj
	dev-python/pygtk
	doc? ( dev-python/gtkmozembed-python )"
RDEPEND="${DEPEND}
	games-emulation/mednafen"

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install \
		--install-scripts="${GAMES_BINDIR}"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	distutils_pkg_postinst
}