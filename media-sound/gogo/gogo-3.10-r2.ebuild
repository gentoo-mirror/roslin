# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gogo/gogo-3.10-r1.ebuild,v 1.18 2006/06/16 21:24:28 flameeyes Exp $

inherit eutils
IUSE="debug"

MY_PV=310pl3
DESCRIPTION="GoGo is an assembly optimized version of LAME 3.91"
HOMEPAGE="http://member.nifty.ne.jp/~pen/free/gogo3/mct_gogo.htm"
SRC_URI="http://member.nifty.ne.jp/~pen/free/gogo3/down/petit${MY_PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc -sparc"

DEPEND="dev-lang/nasm"

RDEPEND=""

S=${WORKDIR}/petit${MY_PV}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-nasm-floats.patch" \
	"${FILESDIR}/${PN}-makefile.patch"
}

src_compile() {
	local myconf=""

	use debug \
		&& myconf="$myconf --enable-debug=yes" \
		|| myconf="$myconf --enable-debug=no"

	econf \
		--enable-shared \
		--enable-nasm \
		--enable-extopt=full \
		${myconf} || die

	emake || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man
	dodir /usr/share/doc

	emake exec_prefix="${D}usr" \
		mandir="${D}usr/share/man" \
		install || die

	dodoc readme_e.txt
	dohtml -r ./
}
