# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python

DESCRIPTION="Minirok is a small music player written in Python using Qt/KDE and GStreamer"
HOMEPAGE="http://chistera.yi.org/~dato/code/minirok/"
SRC_URI="http://chistera.yi.org/~dato/code/minirok/files/tarballs/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus flac mp3 musepack vorbis"

DEPEND="kde-base/pykde4
	media-libs/mutagen
	|| ( dev-python/simplejson
	    >=dev-lang/python-2.6 )
	dev-python/gst-python
	media-plugins/gst-plugins-alsa
	dbus? ( dev-python/dbus-python )
	flac? ( media-plugins/gst-plugins-flac )
	mp3? ( media-plugins/gst-plugins-mad
	    media-libs/gst-plugins-good )
	musepack? ( media-plugins/gst-plugins-musepack )
	vorbis? ( media-plugins/gst-plugins-vorbis )"
RDEPEND="${DEPEND}"

src_install() {
	DEBIAN_PREFIX="${D}" sh setup.sh install || die
}

pkg_postinst() {
	python_mod_optimize "/usr/share/${PN}"
	python_need_rebuild
}

pkg_postrm() {
	python_mod_cleanup "/usr/share/${PN}"
}