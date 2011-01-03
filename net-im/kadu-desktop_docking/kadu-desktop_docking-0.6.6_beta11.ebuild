# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.6_beta11"
KADU_DIR="unstable"

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-docking-${PV}"

inherit kadu-mod

DESCRIPTION="Kadu module for desktop docking"
HOMEPAGE="http://kadu.net"
KEYWORDS=""
IUSE=""

S="${WORKDIR}/kadu-${K_PV}"
