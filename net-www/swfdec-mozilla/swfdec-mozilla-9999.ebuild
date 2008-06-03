# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools git

DESCRIPTION="Swfdec-mozilla is a decoder/renderer netscape style plugin for Macromedia Flash animations."
HOMEPAGE="http://swfdec.freedesktop.org/"
EGIT_REPO_URI="git://anongit.freedesktop.org/git/swfdec/swfdec-mozilla"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="xulrunner"

DEPEND="=media-libs/swfdec-9999
   xulrunner? ( net-libs/xulrunner )
   !xulrunner? ( || ( www-client/mozilla-firefox www-client/seamonkey ) )"
RDEPEND=""

pkg_setup() {
	if ! built_with_use media-libs/swfdec gtk ; then
		einfo "You must build swfdec with the gtk USE flag to build"
		einfo "swfdec-gtk, which is required by ${PN}"
		die "Please re-emerge media-libs/swfdec with the gtk USE flag"
	fi
}

src_compile () {
	cd "${S}"

	AT_M4DIR="${S}"/m4 eautoreconf

	econf --with-plugin-dir="/usr/$(get_libdir)/nsbrowser/plugins" \
		|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die
}
