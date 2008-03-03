# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Convert an SVG file to a PDF file (using cairo)"
HOMEPAGE="http://cairographics.org/"
SRC_URI="http://cairographics.org/snapshots/${P}.tar.gz"

LICENSE="usc-isi"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/libsvg-cairo-0.1.6"
# depend by README, but works without it?
#	media-libs/libpixman
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR=${D} install || die "einstall failed"
}
