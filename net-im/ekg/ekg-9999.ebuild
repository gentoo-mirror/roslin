# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ekg/ekg-1.7.ebuild,v 1.6 2007/10/11 19:26:05 pylon Exp $

inherit cvs eutils autotools

IUSE="ssl ncurses readline zlib python spell threads gif jpeg"

DESCRIPTION="EKG (Eksperymentalny Klient Gadu-Gadu) - a text client for Polish instant messaging system Gadu-Gadu"
HOMEPAGE="http://ekg.chmurka.net/"
#SRC_URI="http://ekg.chmurka.net/${P/_/}.tar.gz"

ECVS_SERVER="ekg.chmurka.net:/home/cvs"
ECVS_MODULE="${PN}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""

S="${WORKDIR}/${P/_/}"

RDEPEND="=net-libs/libgadu-9999
	ssl? ( >=dev-libs/openssl-0.9.6 )
	ncurses? ( sys-libs/ncurses )
	readline? ( sys-libs/readline )
	zlib? ( sys-libs/zlib )
	python? ( dev-lang/python )
	spell? ( >=app-text/aspell-0.50.3 )
	gif? ( media-libs/giflib )
	jpeg? ( media-libs/jpeg )"

DEPEND=">=sys-devel/automake-1.7
	>=sys-devel/autoconf-2.50
	${RDEPEND}"

S=${WORKDIR}/${PN}

src_unpack() {
#	unpack ${A}
	cvs_src_unpack
	cd ${S}
#	epatch ${FILESDIR}/${PN}-1.6_rc3-libgadu.patch
#	epatch ${FILESDIR}/${PN}-1.7_rc2-giflib.patch
#	eautoreconf
	sh autogen.sh
}

src_compile() {
	local myconf="--enable-ioctld --disable-static --enable-dynamic"
	if use ncurses; then
		myconf="$myconf --enable-force-ncurses"
	else
		myconf="$myconf --disable-ui-ncurses"
	fi
	use readline	&& myconf="$myconf --enable-ui-readline"

	econf ${myconf} \
		`use_with python` \
		`use_with threads pthread` \
		`use_with jpeg libjpeg` \
		`use_with gif libgif` \
		`use_with zlib` \
		`use_enable spell aspell` \
		`use_with ssl openssl` \
	|| die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc docs/{*.txt,ULOTKA,TODO,README,FAQ}
}
