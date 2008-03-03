# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2


inherit kde

DESCRIPTION="A kioslave for RAR archives"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=17527"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/17527-${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="x86 amd64"

RDEPEND="|| (
         || ( app-arch/rar app-arch/unrar )
         app-arch/unrar-gpl )"

need-kde 3
