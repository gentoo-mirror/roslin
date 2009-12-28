# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit games

DESCRIPTION="OpenGFX data files for OpenTTD"
HOMEPAGE="http://dev.openttdcoop.org/projects/opengfx"
SRC_URI="http://bundles.openttdcoop.org/${PN}/releases/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="games-simulation/openttd"
RDEPEND="${DEPEND}"

src_install() {
	insinto ${GAMES_DATADIR}/openttd/data/
	insopts -m640 -ggames
	doins ogfx1_base.grf ogfxc_arctic.grf ogfxe_extra.grf ogfxh_tropical.grf
	doins ogfxi_logos.grf ogfxt_toyland.grf
	doins opengfx.obg
	dodoc changelog.txt readme.txt
}

