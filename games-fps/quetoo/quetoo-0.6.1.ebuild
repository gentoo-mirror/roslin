# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils games

DESCRIPTION="Quake 2 performance engine"
HOMEPAGE="http://jdolan.dyndns.org/trac/wiki/Quetoo"
SRC_URI="http://jdolan.dyndns.org/jaydolan/files/${P}.tar.bz2
	http://tastyspleen.net/~jdolan/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mysql"

RDEPEND="media-libs/alsa-lib
	virtual/opengl
	media-libs/libsdl
	mysql? ( virtual/mysql )"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-cflags.patch
}

src_configure() {
	egamesconf \
		$(use_with mysql) \
		|| die "egamesconf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# Has no icon, so use quake2 icon if available
	make_desktop_entry ${PN} "Quetoo" quake2

	dodoc README || die "dodoc failed"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	elog "Be warned, there is no user interface in this game."
	elog "To start a map, type e.g.:  map base1"
	elog "The configuration is saved in ~/.quake2/baseq2/quetoo.cfg"
	echo
}
