# Proper deps for external modules
if [ "${MOD_TYPE}" != "ext" ]
then
	K_PV="${PV}"
else
	K_PV="${MIN_VER}"
fi

K_PV="${K_PV/_p/-}"
K_PV="${K_PV/_/-}"

DEPEND=">=dev-util/cmake-2.6.0"

RDEPEND=">=net-im/kadu-core-${MIN_VER}
	${MOD_DEPEND}"

SRC_URI="http://www.kadu.net/download/stable/kadu-${K_PV}.tar.bz2
	${MOD_URI}"


kadu-mod_src_unpack()
{
	# Unpack the sources
	unpack ${A}
	cd "${S}"
	
	# Disable everything else
	kadu-disable_all

	# Enable module
	echo module_${NAME}=m >> "${S}/.config"
	
	# Remove other subdirectories
	sed -e "/add_subdirectory/d" -i "${S}/CMakeLists.txt"
	echo "add_subdirectory (modules)" >>"${S}/CMakeLists.txt"
	
	if [ "${MOD_TYPE}" = "ext" ]
	then
		# If external module, move its sources to kadu/modules
		mv -f "${WORKDIR}/${NAME}" "${WORKDIR}/kadu/modules"
	fi

	# Apply patches, if any
	if [ ! -z "${MOD_PATCHES}" ]
	then
		cd "${WORKDIR}/kadu/modules/${NAME}"
		for i in ${MOD_PATCHES}
		do
			epatch "${FILESDIR}/${i}"
		done
	fi
}

EXPORT_FUNCTIONS src_unpack

