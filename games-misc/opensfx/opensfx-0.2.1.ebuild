# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit games

DESCRIPTION="OpenSFX data files for OpenTTD"
HOMEPAGE="http://dev.openttdcoop.org/projects/opensfx"
SRC_URI="http://bundles.openttdcoop.org/${PN}/releases/${P}.zip"

LICENSE="CCPL-Sampling-Plus-1.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=games-simulation/openttd-1.0.0_beta1"
RDEPEND="${DEPEND}"

src_install() {
	insinto ${GAMES_DATADIR}/openttd/data/
	insopts -m640 -ggames
	doins opensfx.cat opensfx.obs
	dodoc changelog.txt readme.txt
}
