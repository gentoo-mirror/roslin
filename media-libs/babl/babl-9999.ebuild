# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils subversion

DESCRIPTION="Dynamic, any to any, pixel format conversion library"
HOMEPAGE="http://www.gegl.org/babl/"
#SRC_URI="ftp://ftp.gtk.org/pub/${PN}/0.0/${P}.tar.bz2"

ESVN_REPO_URI="http://svn.gnome.org/svn/babl/trunk/"
ESVN_PROJECT="${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE=""

DEPEND=">=sys-devel/libtool-1.4
	>=sys-devel/autoconf-2.54
	>=sys-devel/automake-1.7.9"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_compile() {
	./autogen.sh || die "autogen failed"
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog INSTALL README
}
