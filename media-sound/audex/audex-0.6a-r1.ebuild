# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit qt4 eutils

DESCRIPTION="Audio CD extraction tool with focus on archival funtions"
HOMEPAGE="http://www.anyaudio.de/audex"
SRC_URI="http://opensource.maniatek.de:8080/audex-files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
NEED_KDE=":kde-4"
IUSE="mysql postgres"

RDEPEND="media-sound/cdparanoia
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql )
	>=kde-base/libkcddb-4.0
	>=kde-base/libkcompactdisc-4.0"
DEPEND="${RDEPEND}
	dev-util/cmake"

S="${WORKDIR}/${PN}-${PV/a/}"

src_compile() {
	cd "${S}"
	mkdir build && cd build
	cmake -DCMAKE_INSTALL_PREFIX=/usr .. || die
	emake || die
}

src_install() {
	cd "${S}/build"
	make DESTDIR="${D}" install || die
	make_desktop_entry "${PN}" "Audex" audex \
		"AudioVideo;Audio"
}

