# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Simple gtk+ painting program"
HOMEPAGE="http://mtpaint.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gif jpeg tiff"

DEPEND="
	>=sys-libs/zlib-1.2.1
	>=media-libs/libpng-1.2.7
	>=sys-devel/gettext-0.14.1
	>=dev-libs/glib-2.6.4
	>=x11-libs/gtk+-2.6.4
	>=x11-libs/pango-1.8.0
	gif? ( >=media-libs/giflib-4.1.4 )
	jpeg? ( >=media-libs/jpeg-6b )
	tiff? ( >=media-libs/tiff-3.6.1 )"

RDEPEND="${DEPEND}"

src_compile() {
	local myconf res conffile

	myconf="${myconf} --prefix=/usr"

	# build international version
	myconf="${myconf} intl --locale=/usr/share/locale"
	# build manuals
	myconf="${myconf} man --mandir=/usr/share/man"

	if use gif ; then
		myconf="${myconf} GIF"
	else
		myconf="${myconf} nogif"
	fi

	if use jpeg ; then
		myconf="${myconf} jpeg"
	else
		myconf="${myconf} nojpeg"
	fi

	if use tiff ; then
		myconf="${myconf} tiff"
	else
		myconf="${myconf} notiff"
	fi

	myconf="${myconf} cflags gtk2"

	# run configure
	econf ${myconf} || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "einstall failed"
	dodoc README NEWS
}