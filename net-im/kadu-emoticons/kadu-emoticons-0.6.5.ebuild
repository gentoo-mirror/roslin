# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Extra emoticons for Kadu"
HOMEPAGE="http://kadu.net/"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
RESTRICT="primaryuri"

SRC_URI="http://www.kadu.net/download/additions/kompatybilne_z_GG6.tar.gz
	http://www.kadu.net/download/additions/tango_static.tar.gz"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/kadu/themes/emoticons/
	doins -r * || die
}
