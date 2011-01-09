# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit fdo-mime eutils

DESCRIPTION="Tlen IM client"
HOMEPAGE="http://tlen.pl"
SRC_URI="amd64? ( http://j.o2.pl/idi/${PN}64-${PV}.bin )
	x86? ( http://j.o2.pl/idi/${P}.bin )"

LICENSE="tlen"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="phonon qt-static"
PROPERTIES="interactive"
RESTRICT="strip"

RDEPEND="!qt-static? ( >=x11-libs/qt-gui-4.7:4
	phonon? (
		|| ( >=x11-libs/qt-phonon-4.7:4
	        media-sound/phonon )
	        )
	)
	x11-misc/xdg-utils"
DEPEND=""

S="${WORKDIR}"

TLEN_DIR="/opt/tlen"
STATIC_FILES="designer/* imageformats/* phonon_backend/* qt_libs/*"
SHARED_FILES="plugins/* tlen_libs/* tlen-bin updater"

pkg_setup() {
	check_license
}

src_unpack() {
	unpack_makeself
}

src_prepare() {
	cd "${S}/data"
	# Fix RPATH
	if use qt-static; then
		# Change RPATH
		./chrpath -r "${TLEN_DIR}/qt_libs:${TLEN_DIR}/tlen_libs" ${SHARED_FILES} > /dev/null
		./chrpath -r "${TLEN_DIR}/qt_libs" ${STATIC_FILES} > /dev/null
	else
		# Change RPATH
		./chrpath -r "${TLEN_DIR}/tlen_libs" ${SHARED_FILES} > /dev/null
		# Disable LD and QT unsets
		sed -i "s:unset:# unset:" tlen || die
		# Remove unneeded libs
		rm -rf qt_libs imageformats phonon_backend
	fi
	# Desktop icon fix
	sed -i "s:^Icon=.*:Icon=${PN}:" "${S}/tlen.desktop"
}

src_install() {
	# Prepare directory
	insinto "${TLEN_DIR}"
	# Copy data
	doins -r data/* || die
	# Install desktop file and icon
	domenu tlen.desktop || die
	newicon data/icon.png ${PN}.png || die
	# Install mime type
	insinto /usr/share/mime/packages/
	doins tlen.pl-extension.xml || die
	# Install symlink and fix permissions
	fperms a+x "${TLEN_DIR}/"{tlen,tlen-bin,updater}
	dosym "${TLEN_DIR}/tlen" /usr/bin/tlen
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	### @todo deactivate auto-update by default
	elog "It is not recommended to use the Updater plugin."
	elog "You should deselect Updater in:"
	elog "\"Tlen\" -> \"Preferences\" -> \"Plugins\"."
	elog
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
