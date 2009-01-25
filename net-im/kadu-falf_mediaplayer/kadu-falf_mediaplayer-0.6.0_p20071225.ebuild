# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

SRC_URI="http://kadu.net/download/modules_extra/falf_mediaplayer/falf_mediaplayer-${PV/0.6.0_p/}.tar.bz2"

inherit kadu

MOD_DEPEND="media-sound/falf net-im/kadu-mediaplayer"
MOD_TYPE="ext"

inherit kadu-module

DESCRIPTION="Kadu module for FALF Player"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
IUSE=""
