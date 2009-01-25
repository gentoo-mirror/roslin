# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu

MOD_DEPEND="kde-base/arts >=net-im/kadu-sound-${MIN_REQ}"

inherit kadu-module kadu-module-func

SRC_URI="http://www.kadu.net/download/stable/kadu-${K_PV}.tar.bz2"
DESCRIPTION="Kadu module that play sounds using ARTS"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
IUSE=""

src_unpack()
{
	kadu-module_src_unpack

	kadu-module_spec_remove CONFIGURE_CMD
	kadu-module_spec_remove TOOLS
	kadu-module_spec_remove 3RDPARTY
}

src_compile()
{
	export MOD_CXXFLAGS="`artsc-config --cflags`"
	export MOD_LDFLAGS="`artsc-config --libs`"

	einfo "Building arts_connector..."
	sed -i -r -e "s%../../../%%g" ${NAME}/arts_connector/arts_connector.c
	mkdir ${NAME}/bin

	gcc ${NAME}/arts_connector/arts_connector.c -I /usr/include/kadu \
		`artsc-config --cflags` `artsc-config --libs` \
		${CFLAGS} ${LDFLAGS} -o ${NAME}/bin/arts_connector \
		|| die "Error: arts_connector compilation failed!"

	kadu-module_src_compile
}
