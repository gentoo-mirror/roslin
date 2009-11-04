# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

DESCRIPTION="Random content downloader"
HOMEPAGE="http://svn.pld-linux.org/svn/toys/rsget.pl/"
#SRC_URI=""
ESVN_REPO_URI="http://svn.pld-linux.org/svn/toys/rsget.pl/"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE="captcha"

DEPEND=""
RDEPEND="dev-perl/GD
	dev-perl/WWW-Curl
	captcha? ( app-text/tesseract )"

MY_PN="rsget.pl"

S=${WORKDIR}/${MY_PN}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	dodoc README* || die "dodoc failed"
}
