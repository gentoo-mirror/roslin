# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Portable library for SSA/ASS subtitles rendering."
HOMEPAGE="http://sourceforge.net/projects/libass"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
