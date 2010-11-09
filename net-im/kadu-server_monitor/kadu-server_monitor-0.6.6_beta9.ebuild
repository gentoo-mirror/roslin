# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.6_beta9"
KADU_DIR="unstable"

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-gadu_protocol-${PV}"

inherit kadu-mod

DESCRIPTION="Server monitor module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS=""
IUSE=""

S="${WORKDIR}/kadu-${K_PV}"