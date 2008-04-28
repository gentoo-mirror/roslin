# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit qt4 eutils

DESCRIPTION="Audio CD extraction tool with focus on archival funtions"
HOMEPAGE="http://www.anyaudio.de/audex"
SRC_URI="http://www.maniatek.de:8080/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mysql postgres"

RDEPEND="$(qt4_min_version 4.3)
	media-sound/cdparanoia
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql )
	kde-base/libkcddb:kde-4
	kde-base/libkcompactdisc:kde-4
	kde-base/kdelibs:kde-4"
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
	make_desktop_entry "${PN}" "Audex" /usr/share/icons/hicolor/128x128/apps/audex.png \
		"AudioVideo;Audio"
}

