# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools git

DESCRIPTION="Macromedia Flash decoding library"
HOMEPAGE="http://swfdec.freedesktop.org"
EGIT_REPO_URI="git://anongit.freedesktop.org/git/swfdec/swfdec"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""

IUSE="alsa debug doc gstreamer gtk pulseaudio"

RESTRICT="test"

RDEPEND=">=dev-libs/glib-2.14
   >=dev-libs/liboil-0.3.6
   >=x11-libs/pango-1.16
   >=x11-libs/cairo-1.2
   alsa? ( >=media-libs/alsa-lib-1.0.12 )
   gstreamer? ( >=media-libs/gstreamer-0.10.11 )
   gtk? (
      >=x11-libs/gtk+-2.8.0
      >=net-libs/libsoup-2.4
      )
   pulseaudio? ( media-sound/pulseaudio )"

DEPEND="${RDEPEND}
   dev-util/pkgconfig"

pkg_setup() {
	if use !gtk ; then
		ewarn "swfdec will be built without swfdec-gtk convenience"
		ewarn "library, which is needed by swfdec-mozilla and"
		ewarn "swfdec-gnome. Please add 'gtk' to your USE flags"
		ewarn "unless you really know what you are doing."
	fi
}

src_compile() {
	cd ${S}
	AT_M4DIR="${S}"/m4 eautoreconf

	local myaudio
	local myconf

	#--with-audio=[auto/alsa/pulseaudio/none]
	myaudio="none"
	use pulseaudio && myaudio="pa"
	use alsa && myaudio="alsa"
	myconf=" --with-audio=$myaudio"

	econf \
		$(use_enable doc gtk-doc) \
		$(use_enable gstreamer) \
		$(use_enable gtk) \
		$(use_enable debug vivified) \
		${myconf} || die "configure failed"

	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog README
}
