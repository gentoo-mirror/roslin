# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit distutils games

DESCRIPTION="Loemu is a free application that provides a simple front end for
various game emulators"
SRC_URI="http://loemu.pegueroles.com/dists/${P}.tar.gz"
HOMEPAGE="http://loemu.pegueroles.com"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"

DEPEND="dev-libs/libxml2
	dev-libs/libxslt
	dev-python/pygtk
	gnome-base/libglade"

RDEPEND="${DEPEND}"

src_compile() {
	python_version
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
