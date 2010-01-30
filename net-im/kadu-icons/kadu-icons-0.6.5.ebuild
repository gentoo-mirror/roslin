# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Extra icon themes for Kadu"
HOMEPAGE="http://kadu.net/"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
RESTRICT="primaryuri"

SRC_URI="http://www.kadu.net/download/additions/kadu-0.6.5-theme-glass-16.tar.gz
	http://www.kadu.net/download/additions/kadu-0.6.5-theme-glass-22.tar.gz
	http://www.kadu.net/download/additions/kadu-0.6.5-theme-kadu05.tar.gz
	http://www.kadu.net/download/additions/kadu-0.6.5-theme-oxygen-16.tar.gz
	http://www.kadu.net/download/additions/kadu-0.6.5-theme-tango-16.tar.gz"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/kadu/themes/icons/
	doins -r * || die
}
