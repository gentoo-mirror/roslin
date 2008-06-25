SRC_URI="http://alan.umcs.lublin.pl/~pinkworm/dcopexport/dcopexport-0.11.3-20071129-0.6.0.tar.bz2"

inherit kadu

MOD_DEPEND="
    kde-base/kdelibs 
    >=net-im/kadu-dcc-${MIN_REQ}
    >=net-im/kadu-history-${MIN_REQ}
    >=net-im/kadu-notify-${MIN_REQ}
    >=net-im/kadu-sms-${MIN_REQ}
"
MOD_TYPE="ext"

inherit kadu-module kadu-module-func

DESCRIPTION="Kadu module that exports many features via DCOP mechanism"
HOMEPAGE="http://alan.umcs.lublin.pl/~pinkworm/dcopexport"
KEYWORDS="amd64 x86"

src_unpack()
{
	KDEDIR="`kde-config --prefix`"
	MOD_LDFLAGS="-L ${KDEDIR}/lib"
	
	kadu-module_src_unpack

	kadu-module_spec_remove INCLUDES_PATH
	kadu-module_spec_remove LIBS_PATH
	kadu-module_spec_remove CONFIGURE_CMD

	echo "MODULE_INCLUDES_PATH=\"${KDEDIR}/include\"" >> ${NAME}/spec

	cd ${NAME}
	dcopidl DCOPExportIface.h > DCOPExportIface.kidl
	dcopidl2cpp --c++-suffix cpp --no-stub DCOPExportIface.kidl
	cd ..
}
