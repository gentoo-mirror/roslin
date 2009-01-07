inherit eutils flag-o-matic kadu

DEPEND="~net-im/kadu-core-${MIN_REQ} ${MOD_DEPEND}"
LICENSE="GPL-2"
IUSE=""
SLOT="0"
S="${WORKDIR}/${PN}"

NAME="${PN#*-}"

if [ ! -z "${MOD_EXTRAS_PATCHES}" ]
then
	IUSE="${IUSE} extras"
fi

kadu-module_spec_clean()
{
	sed -e "/^\(#\|$\)/d" -i ${NAME}/spec
}

kadu-module_src_apply_patches()
{
	for PATCH in `echo "${MOD_PATCHES}" | xargs`
	do
		epatch ${FILESDIR}/${PATCH}
	done

	if [ ! -z "${MOD_EXTRAS_PATCHES}" ]
	then
		if use extras
		then
			for PATCH in `echo "${MOD_EXTRAS_PATCHES}" | xargs`
			do
	    			epatch ${FILESDIR}/${PATCH}
			done
		fi
	fi
}

kadu-module_src_unpack()
{
	# Unpack source
	mkdir ${S}
	unpack ${A}
	cd ${S}

	# Do some specific steps for internal or external module
	if [ "${MOD_TYPE}" = "ext" ]
	then
		# Unpack and move external module
		mv -f ${WORKDIR}/${NAME} ${S}
	else
		# Unpack and move internal module
		mv -f ${WORKDIR}/kadu/modules/${NAME} ${S}
	fi

	# Prepare environment
	cp /usr/share/kadu/modules/Makefile .
	AUTOMAKE="`grep '^AUTOMAKE.* automake-' Makefile | sed -e 's/.*automake-//g'`"
	mkdir ../admin
	cp /usr/share/automake-${AUTOMAKE}/mkinstalldirs ../admin
	sed Makefile -i -e "s%^shared_modules =.*%shared_modules = ${NAME}%g"

	sed Makefile -i -e "s%^CFLAGS =.*%CFLAGS = ${CFLAGS}%g"
	sed Makefile -i -e "s%^CXXFLAGS =.*%CXXFLAGS = ${CXXFLAGS}%g"
	sed Makefile -i -e "s%^LDFLAGS =.*%LDFLAGS = ${LDFLAGS}%g"

	# Apply patches
	if [ "${MOD_PATCHES}${MOD_EXTRAS_PATCHES}" ]
	then
		kadu-module_src_apply_patches
	fi

	# Repair includes
	kadu_src_repair_includes ${NAME} mod
}

kadu-module_src_compile()
{
	filter-flags -fno-rtti

	# Clean spec from unneeded stuff
	kadu-module_spec_clean

	# Set CXXFLAGS
	SPEC_INCLUDES="`grep 'MODULE_INCLUDES_PATH' ${NAME}/spec | cut -d '=' -f 2 | sed -e 's/"//g'`"
	if [ "${SPEC_INCLUDES}" ]
	then
		for INC in ${SPEC_INCLUDES}
		do
	    		INCLUDES="${INCLUDES} -I ${INC}"
		done
		
		einfo "Adding \"${INCLUDES}\" to CXXFLAGS..."
	fi

	echo "${MOD_CXXFLAGS} ${INCLUDES} -I /usr/include/kadu -I /usr/include/kadu/modules" > ${NAME}/.cxxflags

	# Set LDFLAGS
	SPEC_LIBS="`grep 'MODULE_LIBS' ${NAME}/spec | cut -d '=' -f 2 | sed -e 's/"//g'`"
	if [ "${SPEC_LIBS}" ]
	then
		for LIB in ${SPEC_LIBS}
		do
	    		if [ ! "`echo "${LIB}" | grep '/'`" ]
	    		then
				LIBS="${LIBS} -l ${LIB}"
		    	fi
		done

		einfo "Adding \"${LIBS}\" to LDFLAGS..."
	fi

	SPEC_LDFLAGS="`grep 'MODULE_LDFLAGS' ${NAME}/spec | cut -d '=' -f 2 | sed -e 's/"//g'`"
	if [ "${SPEC_LDFLAGS}" ]
	then
		for LIB in ${SPEC_LDFLAGS}
		do
	    		if [ "`echo "${FLAG}" | grep "\.a$"`" ]
		    	then
				FLAGS="${FLAG} `echo ${FLAG} | sed -e "s%.MODULE_DIR%${S}/${NAME}%g"`"
	    		fi
		done
	
		einfo "Adding \"${FLAGS}\" to LDFLAGS..."
	fi

	echo "${MOD_LDFLAGS} ${LIBS} ${FLAGS}" > ${NAME}/.ldflags

	emake \
		|| die "Error: emake failed!"
}

kadu-module_src_install()
{
	# Make install dirs
	make make_module_dirs DESTDIR=${D} \
		|| die "Error: make module_dirs failed!"

	# Install module
	make install DESTDIR=${D} \
		|| die "Error: make install failed!"
}

EXPORT_FUNCTIONS src_unpack src_compile src_install
