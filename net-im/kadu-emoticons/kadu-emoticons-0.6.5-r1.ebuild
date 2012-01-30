# Copyright 1999-2012 Gentoo Foundation
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
	http://www.kadu.net/download/additions/kadu-0.6.5.4-emots-tango.tar.gz
	http://wilku.tk/files/emots_gg10.zip"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/kadu/themes/emoticons/
	doins -r * || die
}
