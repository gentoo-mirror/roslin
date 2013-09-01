# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Template based DVD authoring software"
LICENSE="GPL-2"
HOMEPAGE="http://www.iki.fi/damu/software/kmediafactory/"
SRC_URI="http://kmediafactory.googlecode.com/files/${P}.tar.bz2"

RESTRICT="mirror"
IUSE="dvdread exiv k3b kaffeine office pdf slideshow xine"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="sys-devel/gettext
	media-libs/fontconfig
	dvdread? ( media-libs/libdvdread )
	|| ( media-libs/phonon
	    dev-qt/qtphonon )"

RDEPEND="${DEPEND}
	app-arch/zip
	>=media-video/dvdauthor-0.6.11
	media-video/mjpegtools
	media-video/mplayer
	virtual/ffmpeg
	slideshow? ( >=media-video/dvd-slideshow-0.7.2 )
	office? ( virtual/ooo
		app-text/ghostscript-gpl )
	pdf? ( app-text/ghostscript-gpl )
	k3b? ( app-cdr/k3b )
	kaffeine? ( media-video/kaffeine )
	xine? ( media-video/xine-ui )
	exiv? ( kde-base/libkexiv2 )"

PATCHES=("${FILESDIR}/${P}-header.patch" \
	"${FILESDIR}/${P}-cmake.patch" \
	"${FILESDIR}/${P}-desktop.patch")
