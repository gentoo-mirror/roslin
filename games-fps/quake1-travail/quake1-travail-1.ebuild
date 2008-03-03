# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MOD_DIR="travail"
MOD_TITLE="Travail"
MOD_USES_QRACK=y
MOD_USES_JOEQUAKE=y

inherit eutils games games-mod

DESCRIPTION="Large Quake 1 mission with 2 episodes, supporting co-op play"
HOMEPAGE="http://www.quakeone.com/travail/"

src_unpack() {
	games-mod_src_unpack

	echo "r_novis 0" > "${MOD_DIR}"/autoexec.cfg
}