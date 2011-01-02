# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MIN_VER="0.6.6_beta10"

inherit kadu-base

MOD_DEPEND=">=net-im/kadu-history-${PV}"

inherit kadu-mod

DESCRIPTION="Protection against unwanted chats for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS=""
IUSE=""

S="${WORKDIR}/kadu-${K_PV}"
