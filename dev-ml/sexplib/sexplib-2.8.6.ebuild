# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit findlib

DESCRIPTION="sexplib"
HOMEPAGE="http://www.ocaml.info/home/ocaml_sources.html"
SRC_URI="http://www.ocaml.info/ocaml_sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~sparc ~x86"
IUSE=""

DEPEND="dev-ml/findlib"

src_compile() {
	make || die "emake failed"
}

src_install() {
	findlib_src_install
#	emake DESTDIR="${D}" install || die "install failed"
#	dolib lib/*.o || die

	dodoc CHANGES COPYRIGHT README.txt VERSION
}
