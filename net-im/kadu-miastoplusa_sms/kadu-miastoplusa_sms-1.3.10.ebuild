SRC_URI="http://kadu.net/~patryk/miastoplusa_sms/miastoplusa_sms-0.6-${PV}.tar.bz2"

inherit kadu

MOD_DEPEND=">=net-im/kadu-sms-${MIN_REQ}"
MOD_PATCHES="miastoplusa_sms-fix-includes.patch"
MOD_TYPE="ext"

inherit kadu-module kadu-module-func

DESCRIPTION="Kadu module that supports sending sms via miastoplusa gateway"
HOMEPAGE="http://kadu.net/~patryk"
KEYWORDS="~amd64 ~x86"

pkg_setup()
{
	# Break if qt3 is compiled without gif use flag
	if has_version '=net-misc/curl-7*' && ! built_with_use 'net-misc/curl' ssl
	then
	    die "Please re-emerge net-misc/curl with the 'ssl' flag set"
	fi
}
						
src_unpack()
{
	kadu-module_src_unpack
	
	kadu-module_spec_clean_nonmod
}
