# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils python

MY_P="${PN}_${PV}_source"
dir="/usr/$(get_libdir)/${PN}"

DESCRIPTION="Utility for batch processing images"
HOMEPAGE="http://www.nac.gov.pl/ImagiNAC1.01"
SRC_URI="http://www.nac.gov.pl/files/${MY_P}.tar"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.5
	dev-python/PyQt4
	dev-python/imaging"
RDEPEND="${DEPEND}
	media-gfx/exiv2"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	esvn_clean
}

src_install() {
	# insert files into libdir
	insinto ${dir}
	doins -r filesUtils graphicsUtils gui threadUtils *.py || die

	# the main script needs extra work
	fperms a+x "${dir}/Imaginac.py" || die
	dosym "${dir}/Imaginac.py" /usr/bin/${PN}

	# install dev docs into separate dir
	dohtml -r manual/*
	dohtml -p api -r documentation/html/*

	# desktop entry
	make_desktop_entry ${PN}
}

pkg_postinst() {
	python_mod_optimize "${dir}"
	python_need_rebuild
}

pkg_postrm() {
	python_mod_cleanup "${dir}"
}