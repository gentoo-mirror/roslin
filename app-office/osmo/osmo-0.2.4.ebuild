# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/osmo/osmo-0.2.0.ebuild,v 1.2 2008/07/24 16:00:03 armin76 Exp $

DESCRIPTION="a personal organizer which includes calendar, task manager and address book."
HOMEPAGE="http://clayo.org/osmo"
SRC_URI="mirror://sourceforge/${PN}-pim/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="syncml"

RDEPEND=">=x11-libs/gtk+-2.10
	dev-libs/libxml2
	>=dev-libs/libical-0.27
	dev-libs/libgringotts
	>=x11-libs/libnotify-0.4.4
	syncml? ( >=app-pda/libsyncml-0.4.0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	sed -i -e 's:Management:Management;:' "${S}"/osmo.desktop
}

src_compile() {
	econf --disable-dependency-tracking $(use_with syncml libsyncml)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README TRANSLATORS
}
