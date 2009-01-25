# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu

DESCRIPTION="Collection of Kadu icon themes"
HOMEPAGE="http://www.kadu.net/wiki/index.php/Pobierz:dodatki"
KEYWORDS="amd64 x86"

LICENSE="freedist"

IUSE=""
SLOT="0"
RDEPEND="net-im/kadu-core"

SRC_URI="
	http://www.kadu.net/download/additions/kadu-theme-crystal-16.tar.bz2
	http://www.kadu.net/download/additions/kadu-theme-crystal-22.tar.bz2
	http://www.kadu.net/download/additions/kadu-theme-gg3d.tar.bz2
	http://www.kadu.net/download/additions/kadu-theme-glass_16.tar.gz
	http://www.kadu.net/download/additions/kadu-theme-glass_22.tar.gz
	http://www.kadu.net/download/additions/kadu-theme-noia-16.tar.bz2
	http://www.kadu.net/download/additions/kadu-theme-nuvola-16.tar.gz
	http://www.kadu.net/download/additions/kadu-theme-nuvola-22.tar.gz
	http://www.kadu.net/download/additions/kadu-theme-old_default.tar.bz2
	http://www.kadu.net/download/additions/kadu-theme-piolnet.tar.bz2
	http://www.kadu.net/download/additions/kadu-theme-real_gg.tar.bz2
	http://www.kadu.net/download/additions/kadu-theme-kadu05.tar.gz
	http://kadu.net/~obeny/inne/rozgwiazda.tar.gz
	http://kadu.net/~obeny/inne/gg7.tar.bz2
"

DEST="/usr/share/kadu/themes/icons"

#
# PACKAGE BUILDING AND INSTALLATION
#
src_compile()
{
	# Crystal iconset fixup
	echo "ShowOnlyDescriptionUsers=online_d.png" >> "${WORKDIR}"/kadu-theme-crystal-16/icons.conf
	echo "ShowOnlyDescriptionUsers=online_d.png" >> "${WORKDIR}"/kadu-theme-crystal-22/icons.conf
}

src_install()
{
	einfo "Creating ${DEST} directory and moving icons..."
	dodir ${DEST}

	# Moving icons packages to kadu directory
	mv -f "${WORKDIR}"/kadu-theme-crystal-16 "${D}"${DEST}/crystal16
	mv -f "${WORKDIR}"/kadu-theme-crystal-22 "${D}"${DEST}/crystal22
	mv -f "${WORKDIR}"/kadu-theme-gg3d "${D}"${DEST}/gg3d
	mv -f "${WORKDIR}"/kadu-theme-glass_16 "${D}"${DEST}/glass16
	mv -f "${WORKDIR}"/kadu-theme-glass_22 "${D}"${DEST}/glass22
	mv -f "${WORKDIR}"/kadu-theme-noia-16 "${D}"${DEST}/noia16
	mv -f "${WORKDIR}"/kadu-theme-nuvola-16 "${D}"${DEST}/nuvola16
	mv -f "${WORKDIR}"/kadu-theme-nuvola-22 "${D}"${DEST}/nuvola22
	mv -f "${WORKDIR}"/kadu-theme-old_default "${D}"${DEST}/old_default
	mv -f "${WORKDIR}"/kadu-theme-piolnet "${D}"${DEST}/piolnet
	mv -f "${WORKDIR}"/kadu-theme-real_gg "${D}"${DEST}/real_gg
	mv -f "${WORKDIR}"/kadu05 "${D}"${DEST}/kadu05
	mv -f "${WORKDIR}"/rozgwiazda "${D}"${DEST}/rozgwiazda
	mv -f "${WORKDIR}"/gg7 "${D}"${DEST}/gg7

	# Fix file permissions
	cd  "${D}"${DEST}
	kadu_install_fix_perms

	for THEME in `find . -maxdepth 1 -type d | grep "/[a-z]"`
	do
	    ln -snf ${DEST}/default/external_modules ${THEME}/external_modules
	    grep "external_modules" ${DEST}/default/icons.conf >> ${THEME}/icons.conf
	done
}
