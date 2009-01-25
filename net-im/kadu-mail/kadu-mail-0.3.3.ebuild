# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

SRC_URI="http://www.kadu.net/~weagle/mail/mail-${PV}.tar.bz2"

inherit kadu

MOD_DEPEND=">=net-im/kadu-notify-${MIN_REQ}"
MOD_TYPE="ext"

inherit kadu-module

DESCRIPTION="Kadu module notifying user about incoming e-mail messages"
HOMEPAGE="http://kadu.net/~weagle"
KEYWORDS="amd64 x86"
IUSE=""
