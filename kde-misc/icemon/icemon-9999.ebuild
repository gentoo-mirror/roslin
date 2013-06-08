# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils git-2

DESCRIPTION="Icecream GUI Monitor"
HOMEPAGE="https://github.com/icecc/icemon"
SRC_URI=""

EGIT_REPO_URI="git://github.com/icecc/icemon.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-qt/qtgui:4"
RDEPEND="${DEPEND}"
