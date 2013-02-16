# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils distutils

MY_PV="${PV}dev"
MY_P="fs-uae-${MY_PV}"

DESCRIPTION="WxPython launcher for FS-UAE"
HOMEPAGE="http://fengestad.no/fs-uae/"
SRC_URI="http://fengestad.no/fs-uae/devel/${MY_PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/wxpython
	dev-python/pygame"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}/launcher"

src_install() {
	distutils_src_install
	make_desktop_entry ${PN} "FS-UAE Launcher" fs-uae
}
