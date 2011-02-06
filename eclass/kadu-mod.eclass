# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Author: Michał "mziab" Ziąbkowski
# Module-specific functions for modular Kadu ebuilds

# Proper deps for external modules
if [ "${MOD_TYPE}" != "ext" ]
then
	K_PV="${PV}"
else
	K_PV="${MIN_VER}"
fi

K_PV="${K_PV/_p/.}"
K_PV="${K_PV/_/-}"

RDEPEND=">=net-im/kadu-core-${MIN_VER}
	${MOD_DEPEND}"

if [ "${KADU_DIR}" = "unstable" ]
then
	KADU_URI="http://kadu.googlecode.com/files/"
else
	KADU_URI="mirror://gentoo/"
fi

SRC_URI="${KADU_URI}kadu-${K_PV}.tar.bz2
	${MOD_URI}"

kadu-mod_src_unpack() {
	# Unpack the sources
	unpack ${A}
	cd "${S}"

	# Disable everything else
	kadu-disable_all

	# Enable module
	echo module_${NAME}=m >> "${S}/.config"

	# Remove other subdirectories
	sed -e "/add_subdirectory/d" -i "${S}/CMakeLists.txt" \
	    || die "sed failed"
	echo "add_subdirectory (modules)" >>"${S}/CMakeLists.txt"

	# Disable docs install to avoid collisions
	sed -e "/README/d" -i "${S}/CMakeLists.txt" \
	    || die "sed failed"

	# If external module, move its sources to kadu/modules
	[ "${MOD_TYPE}" = "ext" ] && mv -f \
	    "${WORKDIR}/${NAME}" "${S}/modules"

	# Apply patches, if any
	if [ ! -z "${MOD_PATCHES}" ]
	then
		cd "${S}/modules/${NAME}"
		for i in ${MOD_PATCHES}
		do
			epatch "${FILESDIR}/${i}"
		done
	fi
}

EXPORT_FUNCTIONS src_unpack
