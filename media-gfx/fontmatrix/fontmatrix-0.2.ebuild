# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit subversion flag-o-matic multilib python

ESVN_REPO_URI="http://svn.gna.org/svn/undertype/branches/fontmatrix002"

DESCRIPTION="A font manager"
HOMEPAGE="http://www.fontmatrix.net/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE=""

RDEPEND=">=x11-libs/qt-4.3
	>=media-libs/freetype-2"

src_compile() {
	qmake -o Makefile typotek.pro || die "qmake failed"
	emake || die "emake failed"
}

src_install() {
	exeinto /usr/bin
	doexe bin/fontmatrix
	newicon ${PN}.png ${PN}.png
	make_desktop_entry ${PN} "Fontmatrix" ${PN}.png 
}

pkg_postinst() {
	einfo "If you encounter problems or just have questions or if you have"
	einfo " suggestions, please take time to suscribe to the undertype-users"
	einfo " mailing list ( https://mail.gna.org/listinfo/undertype-users )."
	einfo " Otherwise, there is a chance that you see us as vlada or pierremarc"
	einfo " on #scribus IRC channel or ##fonts."
}
