# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

BZR_BRANCH="http://bazaar.launchpad.net/~exaile-devel/exaile/main"
#EBAZ_BRANCH="main"

inherit eutils python toolchain-funcs bzr

DESCRIPTION="a media player aiming to be similar to KDE's AmaroK, but for GTK"
HOMEPAGE="http://www.exaile.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="aac alsa cdaudio fam flac gnome ipod libnotify libsexy mad musepack ogg oss serpentine streamripper vorbis"

RDEPEND=">=dev-lang/python-2.4
	>=dev-python/pygtk-2.8.6
    >=dev-python/pysqlite-2
    >=media-libs/gstreamer-0.10
    >=media-libs/gst-plugins-good-0.10
	>=media-plugins/gst-plugins-gnomevfs-0.10
	>=dev-python/gst-python-0.10
	>=media-libs/mutagen-1.6
	dev-python/elementtree
	dev-python/dbus-python
	fam? ( app-admin/gamin )
	alsa? ( >=media-plugins/gst-plugins-alsa-0.10 )
	oss? ( >=media-plugins/gst-plugins-oss-0.10 )
	mad? ( >=media-plugins/gst-plugins-mad-0.10 )
	ogg? ( >=media-plugins/gst-plugins-ogg-0.10 )
	vorbis? ( >=media-plugins/gst-plugins-vorbis-0.10 )
	flac? ( >=media-plugins/gst-plugins-flac-0.10 )
	aac? ( >=media-plugins/gst-plugins-faad-0.10 )
	libnotify? ( dev-python/notify-python )
	libsexy? ( dev-python/sexy-python )
	musepack? ( >=media-plugins/gst-plugins-musepack-0.10 )
	gnome? ( dev-python/gnome-python-extras )
	ipod? ( >=media-libs/libgpod-0.3.2-r1
	    >=media-plugins/gst-plugins-faad-0.10 )
	cdaudio? ( media-plugins/gst-plugins-cdparanoia
	dev-python/cddb-py )
	serpentine? ( app-cdr/serpentine )
    streamripper? ( media-sound/streamripper )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}

pkg_setup() {
   if use ipod && ! built_with_use media-libs/libgpod python ; then
		eerror "libgpod has to be built with python support"
		die "libgpod python use-flag not set"
	fi
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
