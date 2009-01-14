# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games distutils

DESCRIPTION="A graphical frontend for the FCEUX emulator"
HOMEPAGE="http://fceux.com/web/htdocs/"
SRC_URI="mirror://sourceforge/fceultra/fceux-${PV}.src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.5
	dev-python/pygtk"
RDEPEND="${DEPEND}
	>=games-emulation/fceux-2.0"

S="${WORKDIR}/${PN}"

