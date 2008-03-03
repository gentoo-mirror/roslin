# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kio-locate/kio-locate-0.4.5.ebuild,v 1.4 2006/09/14 21:26:03 gustavoz Exp $

inherit kde

DESCRIPTION="kio slave to direcly access clipboard data"
HOMEPAGE="http://www.kde-apps.org/content/show.php/kio_clipboard?content=48046"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/48046-${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""


need-kde 3.5

LANGS="de fr"
S="${WORKDIR}/${PN/-/_}-${PV}"

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	einstall
	dodoc AUTHORS ChangeLog
}
