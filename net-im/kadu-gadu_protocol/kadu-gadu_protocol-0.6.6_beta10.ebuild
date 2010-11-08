# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

MIN_VER="0.6.6_beta10"
KADU_DIR="unstable"

inherit kadu-base

MOD_DEPEND=">=net-libs/libgadu-1.9.0_rc2[threads] >=app-crypt/qca-2.0"

inherit kadu-mod

DESCRIPTION="GaduGadu support module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS=""
IUSE=""

S="${WORKDIR}/kadu-${K_PV}"
