inherit kadu

MOD_DEPEND=">=net-im/kadu-dcc-${MIN_REQ} >=net-im/kadu-sound-${MIN_REQ}"
MOD_LDFLAGS="voice/libgsm/lib/libgsm.a"

inherit kadu-module kadu-module-func

SRC_URI="http://www.kadu.net/download/stable/kadu-${K_PV}.tar.bz2"
DESCRIPTION="Kadu module that supports voice communication"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"

src_unpack()
{
	kadu-module_src_unpack
	
	kadu-module_spec_remove 3RDPARTY
	kadu-module_spec_remove LDFLAGS
}

src_compile()
{
	cd ${NAME}/libgsm
	make
	cd ../..
	
	kadu-module_src_compile
}
