# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Extra sound themes for Kadu"
HOMEPAGE="http://kadu.net/"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
RESTRICT="primaryuri"

SRC_URI="http://download.kadu.im/additions/kadu-sound-bns.tar.bz2
	http://download.kadu.im/additions/kadu-sound-drums.tar.bz2
	http://download.kadu.im/additions/kadu-sound-florkus.tar.bz2
	http://download.kadu.im/additions/kadu-sound-michalsrodek.tar.bz2
	http://download.kadu.im/additions/kadu-sound-percussion.tar.bz2
	http://download.kadu.im/additions/kadu-sound-ultr.tar.bz2"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/kadu/themes/sounds/
	doins -r * || die
}
