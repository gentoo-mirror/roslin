# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

MIN_VER="0.9.2"

inherit kadu-base

MOD_DEPEND=">=net-libs/libgadu-1.9.0_rc4[threads] >=app-crypt/qca-2.0"

inherit kadu-mod

DESCRIPTION="GaduGadu support module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
IUSE=""

pkg_postinst() {
	if has_version =net-libs/libgadu-1.9*; then
		elog "You have built gadu_protocol against libgadu-1.9.*."
		elog "Please consider updating to >=libgadu-1.10.1"
		elog "and rebuilding for additional features such as"
		elog "multi-logon and composing notifications."
	fi
}
