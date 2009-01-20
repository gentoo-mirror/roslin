# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="Text-based subtitles editor."
HOMEPAGE="http://sourceforge.net/projects/subcomposer"
SRC_URI="mirror://sourceforge/subcomposer/${P}.tar.bz2"

SLOT="4.1"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="gstreamer xcb xine"
RESTRICT="mirror"

DEPEND="!kdeprefix? ( !media-video/subtitlecomposer:0 )
	gstreamer? ( media-libs/gstreamer )
	xine? ( media-libs/xine-lib[xcb?] )"
RDEPEND="${DEPEND}"

