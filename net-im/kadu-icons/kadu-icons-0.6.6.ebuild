# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Extra icon themes for Kadu"
HOMEPAGE="http://kadu.net/"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
RESTRICT="primaryuri"

SRC_URI="http://www.kadu.net/download/additions/kadu-0.6.6-theme-glass.tar.gz
	http://www.kadu.net/download/additions/kadu-0.6.6-theme-oxygen.tar.gz
	http://www.kadu.net/download/additions/kadu-0.6.6-theme-tango.tar.gz"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/kadu/themes/icons/
	doins -r * || die
}
