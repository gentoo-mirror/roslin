# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

MY_PV="${PV/./}"
MY_PV="${MY_PV/_p/-bld}"

DESCRIPTION="Macroassembler AS"
HOMEPAGE="http://john.ccac.rwth-aachen.de:8000/as/"
SRC_URI="http://john.ccac.rwth-aachen.de:8000/ftp/as/source/c_version/asl-current-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/asl-current"

PATCHES=(
	"${FILESDIR}"/${PN}-makefile.patch \
	"${FILESDIR}"/${PN}-amd64-ifdef.patch
)

src_prepare() {
	cp Makefile.def.tmpl Makefile.def
	sed -i install.sh \
	    -e "s:mkdirhier:mkdir -p:g" \
	    -e "/strip/d" \
	    || die "sed failed"
	default
}
