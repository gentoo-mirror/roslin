# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit base subversion

DESCRIPTION="Random content downloader"
HOMEPAGE="http://rsget.pl/"
#SRC_URI=""
ESVN_REPO_URI="http://svn.pld-linux.org/svn/toys/rsget.pl/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="captcha"

DEPEND=""
RDEPEND="dev-perl/URI
	dev-perl/WWW-Curl
	captcha? ( app-text/tesseract
	dev-perl/GD )"

S=${WORKDIR}/${PN/-/.}

DOCS=("README" "README.config" "README.dev" "README.requirements")

src_prepare() {
	sed -i \
		-e "s./usr/local./usr." Makefile || die "sed failed"
}
