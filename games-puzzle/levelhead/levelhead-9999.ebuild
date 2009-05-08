# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/levelhead-9999.ebuild,v 1.0 2009/03/15 08:41:32 frostwork Exp $

EAPI=2

inherit eutils games flag-o-matic subversion

ESVN_REPO_URI="http://www.inclusiva-net.es/svn/levelhead/trunk"

DESCRIPTION="webcam, manufactured cube controlled game"
HOMEPAGE="http://selectparks.net/~julian/levelhead"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="=dev-games/openscenegraph-1.2
	media-libs/osgcal
	media-libs/ARToolKit[gstreamer]
	media-libs/ARToolKitPlus
	media-libs/cal3d
	virtual/opengl
	virtual/glu
	media-libs/libv4l"

S=${WORKDIR}/${PN}${MY_PV}

src_prepare() {
	epatch "${FILESDIR}"/makefile.diff \
		"${FILESDIR}"/paths.diff \
		"${FILESDIR}"/gcc43.patch

	sed -i \
		-e "s:Data/:"${GAMES_DATADIR}"/"${PN}"/Data/:" \
		include/osgART/GenericTracker \
		src/levelHead/levelHead.cpp \
		src/osgWrappers/osgART/GenericTracker.cpp \
		src/osgART/GenericTracker.cpp \
		src/osgART/Tracker/ARToolKit/ARToolKitTracker \
		src/osgART/Tracker/ARToolKitPlus/ARToolKitPlusTracker \
		src/osgART/Tracker/ARToolKitPlus/ARToolKitPlusTracker.cpp \
		bin/Data/markers_listpaddle.dat \
		bin/Data/multi/marker.dat \
		bin/Data/multi/marker.dat_BUP \
		bin/Data/levelHead_markers.dat || die "sed failed"

	sed -i \
		-e "s:fonts/:"${GAMES_DATADIR}"/"${PN}"/fonts/:g" \
		-e "s:models/:"${GAMES_DATADIR}"/"${PN}"/models/:g" \
		-e "s:shaders/:"${GAMES_DATADIR}"/"${PN}"/shaders/:g" \
		src/levelHead/levelHead.cpp || die "sed failed"
		
	sed -i \
		-e "s:games_libdir:$(games_get_libdir):" \
		bin/levelhead || die "sed failed"
}

src_compile() {
	cd "${S}"/bin
	emake || die "emake failed"
}


src_install() {
	dogamesbin bin/levelhead || die "dogamesbin failed"
	dogamesbin bin/levelHead || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r bin/Data bin/fonts bin/models bin/shaders || die "doins failed"
	insinto "$(games_get_libdir)"
	doins bin/*.so || die "doins failed"

	newicon "${FILESDIR}"/${PN}.png ${PN}.png
	make_desktop_entry ${PN} ${PN}
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "Instructions on how to build the required cubes, including the patterns"
	elog "can be found in \"${GAMES_DATADIR}\"/${PN}/Data/images/"
	elog ""
	elog "the game is launched with the script in /usr/games/bin/levelhead"
	elog "it also contains some variables which might not fit to your system"
}

