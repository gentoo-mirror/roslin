# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

MY_PV=1.0.2beta
S=${WORKDIR}/${PN}-${MY_PV}

DESCRIPTION="An ASCII-based ski jump game."
HOMEPAGE="http://asciijump.prv.pl/"
SRC_URI="http://otak.k-k.pl/asciijump/tgz/asciijump-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-libs/slang
	dev-util/ctags"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-ctags.patch
	epatch ${FILESDIR}/${PV}-paths.patch
}

src_compile() {
	egamesconf || die "conf failed"
	emake || die "make failed"
}

src_install() {
	egamesinstall \
	vardir=${D}/var \
		|| die "install failed"
	prepgamesdirs
}
