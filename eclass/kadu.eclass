# COMMON EBUILD VARIABLES
RESTRICT="nomirror"
SLOT="0"

MIN_REQ="0.6.0.2"

K_PV=${PV}
K_PV=${K_PV#*_pre}
K_PV=${K_PV/_/-}

kadu_src_repair_includes()
{
	# Check whether we work on kadu-core or module
	if [ ${2} = "mod" ]
	then
		PATTERN="^.*\(\.cpp$\|\.h$\)"
	elif [ ${2} = "core" ]
	then
		PATTERN="^.*\.h$"
	else
		die "Error: improper source type given!"
	fi

	# Fix files in given directory
	for FILE in `find "${1}" | grep "${PATTERN}"`
	do
		# Fix ".." includes
		if [ "`grep "^#include.*\.\./" ${FILE}`" ]
		then
			einfo "Processing file ${FILE}..."
			sed ${FILE} -i -e 's%^#include.* \"\.\./.*/%#include \"%g'
		fi

		# Fix "modules" includes
		if [ "`grep "^#include.*modules/" ${FILE}`" ]
		then
	    		einfo "Processing file ${FILE}..."
	    		sed ${FILE} -i -e 's%^#include.* \"modules/.*/%#include \"%g'
		fi

		# Fix "<..>" includes
		if [ "`grep "^#include.*\.\./" ${FILE}`" ]
		then
			einfo "Processing file ${FILE}..."
			sed ${FILE} -i -e 's%^#include.* <\.\./.*/%#include <%g'
		fi

		# Fix "<modules>" includes
		if [ "`grep "^#include.*modules/" ${FILE}`" ]
		then
	    	einfo "Processing file ${FILE}..."
	    	sed ${FILE} -i -e 's%^#include.* <modules/.*/%#include <%g'
		fi
	done
}

kadu_install_fix_perms()
{
	# Fix permissions
	for DIR in `find -type d`
	do
		chmod 755 ${DIR}
	done
	for FILE in `find -type f`
	do
		chmod 644 ${FILE}
	done
}

kadu_install_fix_dir_struct()
{
	# Fix directory structure
	local IFS=$'\n'
	BROKEN_DIRS="`find -type d | grep " "`"

	if [ "${BROKEN_DIRS}" ]
	then
		for DIR in "${BROKEN_DIRS}"
		do
	    	einfo "Processing \"${DIR}\" directory..."
	    	mv -f ${DIR} "`echo ${DIR} | sed -e 's/ /_/g'`"
		done
	fi
}
