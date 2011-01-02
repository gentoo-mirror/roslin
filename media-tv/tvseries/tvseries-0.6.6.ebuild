# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:$

EAPI="2"
PYTHON_DEPEND="2"

inherit distutils flag-o-matic

DESCRIPTION="TVRage parser"
HOMEPAGE="http://crs.wafel.com/"
SRC_URI="http://crs.wafel.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/lxml"
RDEPEND="${DEPEND}"

DOCS="AUTHORS LICENSE README"

src_install() {
	distutils_src_install
}
