SRC_URI="http://kadu.net/download/modules_extra/amarok_mediaplayer/amarok_mediaplayer-${PV}.tar.bz2"

inherit kadu kde

need-kde 3.5

MOD_DEPEND="media-sound/amarok ~net-im/kadu-mediaplayer-${MIN_REQ}"
MOD_TYPE="ext"

inherit kadu-module kadu-module-func

DESCRIPTION="Kadu module for Amarok"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"

src_unpack()
{
	MOD_LDFLAGS="-L ${KDEDIR}/lib"

	kadu-module_src_unpack
	
	kadu-module_spec_remove INCLUDES_PATH
	kadu-module_spec_remove LIBS_PATH
				
	echo "MODULE_INCLUDES_PATH=\"${KDEDIR}/include\"" >> ${NAME}/spec
}
