# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="libMirage is a CD-ROM image access library"
HOMEPAGE="http://cdemu.org"
SRC_URI="mirror://sourceforge/cdemu/${P}.tar.bz2"

LICENSE="GPL-V2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="doc"

DEPEND=">=dev-libs/glib-2.6
		>=media-libs/libsndfile-1.0
		>=sys-devel/flex-2.5.33
		sys-devel/bison
		doc? ( dev-util/gtk-doc )"
RDEPEND="${DEPEND}"

src_compile() {
	local myconf
	
	if use doc ; then
		myconf="--enable-gtk-doc"
	else
		myconf="${myconf}"
	fi

	econf ${myconf} || die "Error: configure failed"
	emake || die "Error: make failed"
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog README TODO
}
