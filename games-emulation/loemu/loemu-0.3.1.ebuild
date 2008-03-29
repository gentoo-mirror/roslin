# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Loemu is a free application that provides a simple front end for
various game emulators"
SRC_URI="http://loemu.pegueroles.com/dists/${P}.tar.gz"
HOMEPAGE="http://loemu.pegueroles.com"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL"

DEPEND="dev-lang/python
    dev-libs/libxml2
    dev-libs/libxslt
    dev-python/pygtk
    gnome-base/libglade"


src_install() {
	local mypyconf
	python_version
	local site_pkgs=/usr/$(get_libdir)/python${PYVER}/site-packages

	dodir ${site_pkgs}

	python setup.py ${mypyconf} install --prefix=/usr --root="${D}" \
		|| die "setup.py install failed"
}
