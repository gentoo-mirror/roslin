# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

MY_PN="rsget.pl"

DESCRIPTION="Random content downloader"
HOMEPAGE="http://rsget.pl/"
#SRC_URI=""
ESVN_REPO_URI="http://svn.pld-linux.org/svn/toys/rsget.pl/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="captcha"

DEPEND=""
RDEPEND="dev-perl/WWW-Curl
	captcha? ( app-text/tesseract
	dev-perl/GD )"

S=${WORKDIR}/${MY_PN}

src_prepare() {
	sed -i -e "s:/usr/local:/usr:" || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	dodoc README* || die "dodoc failed"
}
