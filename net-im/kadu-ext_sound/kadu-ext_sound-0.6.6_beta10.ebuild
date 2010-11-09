# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.6_beta10"
KADU_DIR="unstable"

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-sound-${PV}"

inherit kadu-mod

DESCRIPTION="External sound module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS=""
IUSE=""

S="${WORKDIR}/kadu-${K_PV}"