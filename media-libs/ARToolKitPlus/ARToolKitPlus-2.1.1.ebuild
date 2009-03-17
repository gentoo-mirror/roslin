# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit eutils qt3


DESCRIPTION="argumented reality tracking library plus"
HOMEPAGE="http://studierstube.icg.tu-graz.ac.at/handheld_ar/artoolkitplus.php"
SRC_URI="http://studierstube.icg.tu-graz.ac.at/handheld_ar/download/${PN}_${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="x11-libs/qt:3"
DEPEND=""


S=${WORKDIR}/${MY_PN}

#src_unpack(){
#	unpack ${A}
#	cd "${S}"
#	#epatch ${FILESDIR}/"${P}.diff"
#	#sed -i -e "s:resources/:"${GAMES_DATADIR}"/"${PN}"/resources/:" -i src/sound.d
#
#}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/gcc43.patch"
}

src_compile() {
	export ARTKP="${S}"
	cp -R "${S}"/src "${S}"/include/ARToolKitPlus/src
	qmake artoolkitplus.pro \
	QMAKE=${QTDIR}/bin/qmake \
	QMAKE_CFLAGS_RELEASE="${CFLAGS}" \
	QMAKE_CXXFLAGS_RELEASE="${CXXFLAGS}" \
	QMAKE_RPATH= \
	"CONFIG += no_fixpath release thread" \
	|| die "couldn't create fresh Makefiles"
	emake -j1 || die
}

src_install() {
	epatch "${FILESDIR}"/includepath.diff
	insinto /usr/include/ARToolKitPlus
	doins include/ARToolKitPlus/*
	insinto /usr/include/ARToolKitPlus/extra/
	doins include/ARToolKitPlus/extra/*
	insinto /usr/include/ARToolKitPlus/src/
	doins include/ARToolKitPlus/src/*
	insinto /usr/include/ARToolKitPlus/src/core
	doins include/ARToolKitPlus/src/core/*
	insinto /usr/include/ARToolKitPlus/src/extra
	doins include/ARToolKitPlus/src/extra/*
	insinto /usr/include/ARToolKitPlus/src/librpp
	doins include/ARToolKitPlus/src/librpp*
	insinto /usr/include/ARToolKitPlus/src/math
	doins include/ARToolKitPlus/src/math/*
	insinto /usr/lib
	doins lib/lib*
}
