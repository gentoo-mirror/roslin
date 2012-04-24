# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

MY_PV="${PV/0./}"
MY_PV="${MY_PV/_/}"
MY_P="bsnes_v${MY_PV}-source"

DESCRIPTION="Stand-alone Super Nintendo debugger based on bsnes"
HOMEPAGE="http://byuu.org/bsnes/"
SRC_URI="http://bsnes.googlecode.com/files/${MY_P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="gtk qt4"

REQUIRED_USE="^^ ( gtk qt4 )"

RDEPEND="media-libs/alsa-lib
	gtk? ( x11-libs/gtk+:2 )
	qt4? ( >=x11-libs/qt-gui-4.5:4 )"

DEPEND="${RDEPEND}
	>=sys-devel/gcc-4.6"

S="${WORKDIR}/${MY_P}/bsnes"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch \
		"${FILESDIR}"/${P}-profile.patch

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r profile || die

	# regenerate .moc if needed
	if use qt4; then
		cd phoenix/qt && moc -i -I. -o platform.moc platform.moc.hpp
	fi
}

src_compile() {
	emake \
		compiler=gcc \
		ui=target-debugger || die "emake failed"
}

src_install() {
	dobin out/${PN} || die
	# install cheat db and profile files
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r profile || die
}
