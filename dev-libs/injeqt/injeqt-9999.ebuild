# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="Dependency injection framework for Qt5"
HOMEPAGE="https://github.com/vogel/injeqt"
SRC_URI=""
EGIT_REPO_URI="https://github.com/vogel/injeqt.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="
	>=dev-qt/qtcore-5.4.2:5
"
DEPEND="${RDEPEND}
	test? ( >=dev-qt/qttest-5.4.2:5 )
"

src_configure() {
	local mycmakeargs=(
		-DDISABLE_EXAMPLES=ON
		$(cmake-utils_use_disable test TESTS)
	)
	cmake-utils_src_configure
}
