# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit versionator autotools

MY_P="${P/_/~}"

DESCRIPTION="A light and easy to use libvte based X Terminal Emulator"
HOMEPAGE="http://lilyterm.luna.com.tw"
SRC_URI="${HOMEPAGE}/file/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:2
	x11-libs/vte:0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

DOCS=( AUTHORS ChangeLog README TODO )

S=${WORKDIR}/${MY_P}

src_prepare() {
	./autogen.sh || die "autogen.sh failed with exit code $?"
}
