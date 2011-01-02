# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit base

DESCRIPTION="Send text message using your mobile phone through a bluetooth connection"
HOMEPAGE="http://code.google.com/p/phonetooth"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gammu"

RDEPEND="dev-python/pygtk
	dev-python/pybluez
	dev-python/pyserial
	app-mobilephone/obex-data-server
	dev-python/dbus-python
	gammu? ( app-mobilephone/gammu[python] )"
DEPEND="${RDEPEND}"

DOCS=("AUTHORS" "ChangeLog" "README")
PATCHES=("${FILESDIR}/${P}-glade-locale.patch")
