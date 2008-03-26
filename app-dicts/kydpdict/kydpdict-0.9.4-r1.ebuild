# Copyright 1999-2008 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

RESTRICT="nomirror strip"

inherit kde

S=${WORKDIR}/${P}
DESCRIPTION="Kydpdict is a graphical frontend to Collins', PWN Oxford & SAP dictionaries."
SRC_URI="http://members.elysium.pl/ytm/src/${P}.tar.bz2"
HOMEPAGE="http://members.elysium.pl/ytm/html/kydpdict.html"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

need-qt 3


src_compile(){
    myconf="$myconf --prefix=/usr --with-x --datadir=/usr/share"
    kde_src_compile configure make
}

src_install(){
    cd ${S}
    kde_src_install
    
    make_desktop_entry ${PN} ${PN} accessories-dictionary "Dictionary;Application;Utility"
}

pkg_postinst(){
    einfo "This is only a front-end to dictionaries."
    einfo "You need to have windows version installed. In fact you need only four files: "
    einfo "dict100.dat, dict101.dat, dict100.idx, dict101.idx"
    einfo "angpol.win polang.win"
}
