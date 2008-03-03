# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils games

DESCRIPTION="ble ble"
HOMEPAGE="http://taxipilot.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="arts kde"

RDEPEND="kde? ( kde-base/kdebase )
	arts? ( kde-base/arts )
	kde-base/kdelibs"
DEPEND="${RDEPEND}"

src_compile() {
	./configure --libdir=/usr/games/lib \
	--datadir=/usr/share/games --sysconfdir=/etc/games \
	--localstatedir=/var/games "--prefix=/usr/kde/3.5/" \
		$(use_enable arts) || die "egamesconf failed"
	emake || die "emake failed"
}
