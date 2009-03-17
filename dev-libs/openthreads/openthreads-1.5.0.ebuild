# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils fixheadtails toolchain-funcs multilib

MY_PN="OpenThreads"
OSG_V=1.2
DESCRIPTION="a minimal & complete Object-Oriented thread interface for C++"
HOMEPAGE="http://www.openscenegraph.org/"
SRC_URI="http://www.openscenegraph.org/downloads/stable_releases/OpenSceneGraph-1.2/source/OSG_OP_OT-${OSG_V}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc examples"

DEPEND="app-arch/unzip
	doc? ( app-doc/doxygen )"
RDEPEND="!>=dev-games/openscenegraph-2.8.0"

S="${WORKDIR}/OSG_OP_OT-${OSG_V}/${MY_PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch

	ht_fix_all
}

src_compile() {
	emake CXX="$(tc-getCXX)" || die "emake failed"

	if use doc; then
		cd docs
		doxygen doxyfile
	fi
}

src_install() {
	emake INST_LOCATION="${D}"/usr install || die "emake install failed"

	dosym /usr/$(get_libdir)/lib${MY_PN}.so{.${PV},} || die "dosym failed"
	dosym /usr/$(get_libdir)/lib${MY_PN}.so.{${PV},${PV%%.*}} || die "dosym failed"

	insinto /usr/$(get_libdir)/pkgconfig
	doins Make/openthreads.pc || die "doins failed"

	dodoc AUTHORS.txt ChangeLog README.txt TODO.txt || die "dodoc failed"
	use doc && { dohtml -r docs/html/* || die "dohtml failed" ; }

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples_src/* || die "doins failed"
	fi
}
