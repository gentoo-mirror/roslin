# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Original Author: Paul Bredbury <brebs@sent.com>
# Purpose: Simplify random fps games mod installation
# 
# Added by Piotr Szymaniak <lazy_bum@o2.pl>
# Initial support for tyrquake (quake1)

inherit versionator games

EXPORT_FUNCTIONS pkg_nofetch src_unpack src_unpack_tidy src_install \
	src_install_tidy src_install_wrapper src_install_doc

# Safer than "freedist" as default
LICENSE="as-is"

# Defaults
SLOT="0"
KEYWORDS="-* amd64 x86"

RESTRICT="${MOD_RESTRICT} strip"

# Map packs and mods should never overwrite existing files
FEATURES="${FEATURES} collision-protect"

DEPEND=${MOD_DEPEND}
# Most of the SRC_URIs are going to be zipped
if [[ "${MOD_DEPEND_UNZIP}" != "n" ]] ; then
	DEPEND="${DEPEND} app-arch/unzip"
fi

S=${WORKDIR}
dir=${GAMES_PREFIX_OPT}/${GAME}

# Take ${GAME} from ${PN}, e.g. "doom3" from "doom3-inhell"
GAME=${PN%%-*}
[[ "${GAME}" = "unreal" ]] && GAME="ut"
[[ "${GAME}" = "doomsday" ]] && GAME="doom"
[[ "${GAME}" = "zdoom" ]] && GAME="doom"
[[ "${GAME}" = "vavoom" ]] && GAME="doom"
[[ "${GAME}" = "darkplaces" ]] && GAME="quake1"
[[ "${GAME}" = "joequake" ]] && GAME="quake1"
[[ "${GAME}" = "qrack" ]] && GAME="quake1"
[[ "${GAME}" = "tenebrae" ]] && GAME="quake1"
[[ "${GAME}" = "fuhquake" ]] && GAME="quake1"
[[ "${GAME}" = "ezquake" ]] && GAME="quake1"
[[ "${GAME}" = "tyrquake" ]] && GAME="quake1"
[[ "${GAME}" = "kmquake2" ]] && GAME="quake2"
[[ "${GAME}" = "qudos" ]] && GAME="quake2"
#[[ "${GAME}" = "quetoo" ]] && GAME="quake2"

GAME_EXE=${GAME}
MOD_CMDLINE_DIR_SELECT="+set fs_game "
MOD_CMDLINE_MAP_SELECT="+map "

# Gametype-specific customizations.
case "${GAME}" in
	doom)
		IUSE=""
		RDEPEND=""
		# Doomsday is probably the best default.
		if [[ "${MOD_USES_DOOMSDAY}" != "n" ]] ; then
			GAME_EXE="doomsday"
			IUSE="${IUSE} doomsday"
			RDEPEND="${RDEPEND} doomsday? ( games-fps/doomsday )"
		fi
		if [[ "${MOD_USES_ZDOOM}" = "y" ]] ; then
			[[ "${GAME_EXE}" = "" ]] && GAME_EXE="zdoom"
			IUSE="${IUSE} zdoom"
			RDEPEND="${RDEPEND} zdoom? ( games-fps/zdoom )"
		fi
		# *** More to add here ***
		;;
	doom3)
		# Convenient X USE flag for headless dedicated servers
		IUSE="${MOD_IUSE} X"
		RDEPEND="X? ( >=games-fps/doom3-1.3.1302-r1 )"
		GAME_TITLE="Doom III"
		MOD_DEFAULT_ICON="${GAME}.png"
		;;
	quake1)
		# Stick with darkplaces as *the* Quake 1 engine for now.
		# Other engines: joequake, tenebrae, ezquake-bin, fuhquake-bin.
		if [[ "${MOD_USES_DARKPLACES_ONLY}" = "y" ]] ; then
			GAME_EXE="darkplaces"
			IUSE="${MOD_IUSE} darkplaces"
			RDEPEND="darkplaces? ( games-fps/darkplaces )"
		else
			IUSE="${MOD_IUSE}"
			RDEPEND=""
			# Darkplaces is the only engine that defaults to on,
			# because it is capable of playing all mods.
			if [[ "${MOD_USES_DARKPLACES}" != "n" ]] ; then
				GAME_EXE="darkplaces"
				IUSE="${IUSE} darkplaces"
				RDEPEND="${RDEPEND} darkplaces? ( games-fps/darkplaces )"
			fi
			if [[ "${MOD_USES_JOEQUAKE}" = "y" ]] ; then
				[[ "${GAME_EXE}" = "" ]] && GAME_EXE="joequake"
				IUSE="${IUSE} joequake"
				RDEPEND="${RDEPEND} joequake? ( games-fps/joequake )"
			fi
			if [[ "${MOD_USES_QRACK}" = "y" ]] ; then
				[[ "${GAME_EXE}" = "" ]] && GAME_EXE="qrack"
				IUSE="${IUSE} qrack"
				RDEPEND="${RDEPEND} qrack? ( games-fps/qrack )"
			fi
			if [[ "${MOD_USES_TENEBRAE}" = "y" ]] ; then
				[[ "${GAME_EXE}" = "" ]] && GAME_EXE="tenebrae"
				IUSE="${IUSE} tenebrae"
				RDEPEND="${RDEPEND} tenebrae? ( games-fps/tenebrae )"
			fi
			if [[ "${MOD_USES_EZQUAKE}" = "y" ]] ; then
				[[ "${GAME_EXE}" = "" ]] && GAME_EXE="ezquake"
				IUSE="${IUSE} ezquake"
				RDEPEND="${RDEPEND} ezquake? ( || ( games-fps/ezquake games-fps/ezquake-bin ) )"
			fi
			if [[ "${MOD_USES_FUHQUAKE}" = "y" ]] ; then
				[[ "${GAME_EXE}" = "" ]] && GAME_EXE="fuhquake"
				IUSE="${IUSE} fuhquake"
				RDEPEND="${RDEPEND} fuhquake? ( || ( games-fps/fuhquake games-fps/fuhquake-bin )"
			fi
			if [[ "${MOD_USES_TYRQUAKE}" = "y" ]] ; then
				[[ "${GAME_EXE}" = "" ]] && GAME_EXE="tyr-glquake"
				IUSE="${IUSE} tyrquake"
				RDEPEND="${RDEPEND} tyrquake? ( games-fps/tyrquake )"
			fi
		fi
		# Ensure that GAME_EXE is set
		[[ "${GAME_EXE}" = "" ]] && GAME_EXE="darkplaces"

		# Maps & mods usually require the CD data
		if [[ "${MOD_DEPEND_DATA}" != "n" ]] ; then
			RDEPEND="${RDEPEND} games-fps/quake1-data"
		fi
		[[ "${GAME_EXE}" != "" ]] && MOD_DEFAULT_ICON="${GAME_EXE}.png"
		MOD_CMDLINE_DIR_SELECT="-game "
		dir=${GAMES_DATADIR}/quake1
		MOD_DODOC=y
		if [[ -z "${MOD_PV}" ]] ; then
			MOD_PV=$(delete_all_version_separators)
		fi
		if [[ -z "${MOD_FILENAME}" ]] ; then
			# Guess filename
			if [[ "${PV}" = "1" ]] ; then
				# Normally unversioned
				MOD_FILENAME=${PN#*-}.zip
			else
				# Add version number with no separators
				MOD_FILENAME=${PN#*-}${MOD_PV}.zip
			fi
		fi
		SRC_ADDICT="http://www.quaddicted.com/filebase"
		SRC_TERMINUS="http://www.quaketerminus.com/mods"
		if ! has restrict ${FEATURES} ; then
			# Default SRC_URI
			SRC_URI="${SRC_ADDICT}/${MOD_FILENAME}"
		fi
		DESCRIPTION="${MOD_TITLE} - Quake 1 map"
		;;
	quake2)
		# kmquake2 includes the "Lazarus" mod, needed for some maps
		GAME_EXE="kmquake2"
		# Convenient X USE flag for headless dedicated servers
		IUSE="${MOD_IUSE} X"
		RDEPEND="X? ( games-fps/${GAME_EXE} )"
		MOD_DEFAULT_ICON="${GAME_EXE}.png"
		dir=${GAMES_DATADIR}/quake2
		;;
	quake3)
		# Also works on ppc
		KEYWORDS="-* amd64 ~ppc x86"
		# Convenient X USE flag for headless dedicated servers
		IUSE="${MOD_IUSE} X"
		RDEPEND="X? ( || ( games-fps/${GAME_EXE} games-fps/${GAME_EXE}-bin ) )"
		GAME_TITLE="Quake III"
		MOD_DEFAULT_ICON="${GAME_EXE}.png"
		;;
	quake4)
		# Convenient X USE flag for headless dedicated servers
		IUSE="${MOD_IUSE} X"
		RDEPEND="X? ( >=games-fps/${GAME_EXE}-bin-1.0.6 )"
		GAME_TITLE="Quake IV"
		MOD_DEFAULT_ICON="${GAME_EXE}.bmp"
		;;
	ut)
		# Unreal Tournament 99
		GAME_EXE="ut"
		# Convenient X USE flag for headless dedicated servers
		IUSE="${MOD_IUSE} X"
		RDEPEND="X? ( games-fps/unreal-tournament )"
		GAME_TITLE="UT99"
		MOD_DEFAULT_ICON=${GAME_EXE}.xpm
		MOD_CMDLINE_DIR_SELECT="-mod="
		# Mixed-case filenames are expected
		MOD_FILES_LOWER_CASE=n
		MOD_DIRS_LOWER_CASE=n
		;;
	ut2004)
		# Convenient X USE flag for headless dedicated servers
		IUSE="${MOD_IUSE} X"
		RDEPEND="X? ( >=games-fps/${GAME_EXE}-3369-r1 )"
		GAME_TITLE="UT2004"
		MOD_DEFAULT_ICON=${GAME_EXE}.xpm
		MOD_CMDLINE_DIR_SELECT="-mod="
		# Mixed-case filenames are expected
		MOD_FILES_LOWER_CASE=n
		MOD_DIRS_LOWER_CASE=n
		;;
	ut2007)
		# Preparing for the future
		# Convenient X USE flag for headless dedicated servers
		IUSE="${MOD_IUSE} X"
		RDEPEND="X? ( games-fps/${GAME_EXE} )"
		GAME_TITLE="UT2007"
		MOD_DEFAULT_ICON=${GAME_EXE}.xpm
		MOD_CMDLINE_DIR_SELECT="-mod="
		# Mixed-case filenames are expected
		MOD_FILES_LOWER_CASE=n
		MOD_DIRS_LOWER_CASE=n
		;;
	*)
		eerror "Unknown gametype '${GAME}' for games-mod eclass."
		die "Unknown gametype"
		;;
esac


RDEPEND="${RDEPEND} ${MOD_RDEPEND}"

games-mod_pkg_nofetch() {
	if [[ -z "${DOWNLOAD_URL}" ]] ; then
		DOWNLOAD_URL=${HOMEPAGE}
	fi

	einfo "Please download the following files:"
	einfo "${A}"
	einfo "from ${DOWNLOAD_URL}"
	einfo "and move them to ${DISTDIR}"
}

games-mod_src_unpack() {
	unpack ${A}

	games-mod_src_unpack_tidy
}

games-mod_src_unpack_tidy() {
	find . '(' -name '*.bat' -o -name '*.dll' -o -name '*.exe' ')' -delete
	find . '(' -name '*.BAT' -o -name '*.DLL' -o -name '*.EXE' ')' -delete

	if [[ "${MOD_FILES_LOWER_CASE}" != "n" ]] ; then
		# Rename all files to lower-case
		local d f fname lcfname
		for f in $(find . -mindepth 1 -depth -type f) ; do
			fname=$(basename "${f}")
			lcfname=$(echo "${fname}" | tr [:upper:] [:lower:])
			if [[ "${lcfname}" != "${fname}" ]] ; then
				# Rename the file to lower-case
				d=$(dirname "${f}")
				if [[ -e "${d}/${lcfname}" ]] ; then
					eerror "File case conflict between ${f} and ${lcfname}"
				else
					einfo "Renaming file ${f} to lower-case"
					mv "${f}" "${d}/${lcfname}" \
						|| eerror "mv ${f} ${d}/${lcfname} failed"
				fi
			fi
		done
	fi

	if [[ "${MOD_DIRS_LOWER_CASE}" != "n" ]] ; then
		# Rename all *directories* to lower-case
		local d f fname lcfname
		for f in $(find . -mindepth 1 -depth -type d) ; do
			fname=${f##*/}
			lcfname=$(echo "${fname}" | tr [:upper:] [:lower:])
			if [[ "${lcfname}" != "${fname}" ]] ; then
				# Rename the directory to lower-case
				d=${f%/*}
				if [[ -e "${d}/${lcfname}" ]] ; then
					eerror "Directory case conflict between ${f} and ${lcfname}"
				else
					einfo "Renaming directory ${f} to lower-case"
					mv "${f}" "${d}/${lcfname}" \
						|| eerror "mv ${f} ${d}/${lcfname} failed"
				fi
			fi
		done
	fi

	games-mod_calc_mod_dir

	# Create subdirectory if it does not already exist
	if [[ -n "${MOD_DIR}" ]] ; then
		if [[ ! -d "${MOD_DIR}" ]] ; then
			mkdir "${MOD_DIR}"
		fi
		find . -mindepth 1 -maxdepth 1 -type f -exec mv '{}' "${MOD_DIR}" \;
	fi

	find . -mindepth 2 '(' -name '*.txt' -o -name '*.html' ')' -exec mv '{}' . \;

	case "${GAME}" in
		quake1)
			if [[ -n "${MOD_DIR}" ]] ; then
				if [[ -n $(find . -name '*.bsp') ]] ; then
					# Move .bsp files to correct directory. Used by quake1-dazsp2.
					mkdir -p "${MOD_DIR}"/maps
					local f fname
					for f in $(find . -name '*.bsp') ; do
						fname=$(basename "${f}")
						if [[ ! -e "${MOD_DIR}/maps/${fname}" ]] ; then
							mv "${f}" "${MOD_DIR}"/maps \
								|| eerror "mv ${f} ${MOD_DIR}/maps failed"
						fi
					done
				fi
			fi
			;;
	esac
}

games-mod_src_install() {
	games-mod_calc_mod_dir

	if [[ -n "${MOD_DIR}" ]] ; then
		insinto "${dir}"
		doins -r "${MOD_DIR}" || die "doins -r ${MOD_DIR} failed"
	fi

	games-mod_src_install_tidy

	prepgamesdirs
}

games-mod_src_install_tidy() {
	games-mod_src_install_wrapper
	games-mod_src_install_doc
}

games-mod_calc_mod_dir() {
	if [[ -z "${MOD_DIR}" ]] ; then
		# See if there is a single directory
		if [[ "$(find . -mindepth 1 -maxdepth 1 -type d | wc -l)" = "1" ]] ; then
			MOD_DIR=$(find . -mindepth 1 -maxdepth 1 -type d)
			# Remove "./" from start
			MOD_DIR=${MOD_DIR:2}
		else
			# Default to last part of $PN
			MOD_DIR=${PN#*-}
		fi
	fi
}

games-mod_src_install_wrapper() {
	# src_unpack might not have been called, so ensure that vars are set
	games-mod_calc_mod_dir

	MOD_ICON_EXT=${MOD_DEFAULT_ICON##*.}
	if [[ -z "${MOD_ICON}" ]] \
		|| [[ "${MOD_ICON}" = "${MOD_DEFAULT_ICON}" ]] ; then
		# Use already-installed default game icon
		MOD_ICON_USED=${MOD_DEFAULT_ICON}
	else
		# Install custom icon.
		# This Bash voodoo determines the file extension, e.g. "xpm".
		MOD_ICON_EXT=${MOD_ICON##*.}
		MOD_ICON_USED=${PN}.${MOD_ICON_EXT}
		newicon "${MOD_ICON}" "${MOD_ICON_USED}" \
			|| die "newicon ${MOD_ICON} failed"
	fi

	local engine game_exe mod_cmdline mod_cmdline_wrapper mod_title mod_desktop_title game_title
	for engine in doomsday zdoom darkplaces joequake qrack tenebrae \
		ezquake fuhquake tyrquake kmquake2 qudos quake3 quake3-bin X ; do
		if has ${engine} ${IUSE} && use ${engine} ; then
			if [[ "${MOD_CREATE_CMDLINE}" != "n" ]] ; then
				# The setting of game_exe may be more complex in future
				game_exe=${engine}

				# Create command-line wrapper for mod
				if [[ -n "${MOD_CMDLINE}" ]] ; then
					mod_cmdline=${MOD_CMDLINE}
				else
					mod_cmdline=${game_exe}
					if [[ -n "${MOD_CMDLINE_OPTIONS}" ]] ; then
						mod_cmdline="${mod_cmdline} ${MOD_CMDLINE_OPTIONS}"
					else
						if [[ -n "${MOD_CMDLINE_START}" ]] ; then
							mod_cmdline="${mod_cmdline} ${MOD_CMDLINE_START}"
						fi
						# MOD_DIR may have been set in src_unpack
						if [[ -n "${MOD_DIR}" ]] ; then
							mod_cmdline="${mod_cmdline} ${MOD_CMDLINE_DIR_SELECT}${MOD_DIR}"
						fi
						if [[ -n "${MOD_MAP}" ]] ; then
							mod_cmdline="${mod_cmdline} ${MOD_CMDLINE_MAP_SELECT}${MOD_MAP}"
						fi
						if [[ -n "${MOD_CMDLINE_END}" ]] ; then
							mod_cmdline="${mod_cmdline} ${MOD_CMDLINE_END}"
						fi
					fi
				fi
				MOD_CMDLINE_WRAPPER=${game_exe}-${PN#*-}

				games_make_wrapper "${MOD_CMDLINE_WRAPPER}" "${mod_cmdline}" \
					|| die "games_make_wrapper ${MOD_CMDLINE_WRAPPER} ${mod_cmdline} failed"
			fi

			if [[ "${MOD_CREATE_DESKTOP}" != "n" ]] ; then
				if [[ -n "${MOD_TITLE}" ]] ; then
					mod_title=${MOD_TITLE}
				else
					mod_title=$(echo ${MOD_DIR:0:1} | tr [:lower:] [:upper:])${MOD_DIR:1}
				fi
				if [[ -n "${MOD_DESKTOP_TITLE}" ]] ; then
					mod_desktop_title=${MOD_DESKTOP_TITLE}
				else
					if [[ -n "${GAME_TITLE}" ]] ; then
						game_title=${GAME_TITLE}
					else
						case "${engine}" in
							doomsday)
								game_title="Doomsday" ;;
							zdoom)
								game_title="ZDoom" ;;
							vavoom)
								game_title="Vavoom" ;;
							darkplaces)
								game_title="Dark Places" ;;
							joequake)
								game_title="JoeQuake" ;;
							qrack)
								game_title="Qrack" ;;
							ezquake)
								game_title="ezQuake" ;;
							fuhquake)
								game_title="FuhQuake" ;;
							tyrquake)
								game_title="TyrQuake" ;;
							kmquake2)
								game_title="KM Quake 2" ;;
							qudos)
								game_title="QuDos" ;;
							*)
								game_title=$(echo ${engine:0:1} | tr [:lower:] [:upper:])${engine:1} ;;
						esac
					fi
					mod_desktop_title="${game_title} - ${mod_title}"
				fi
				if [[ -n "${MOD_CMDLINE_WRAPPER}" ]] ; then
					mod_cmdline_wrapper=${MOD_CMDLINE_WRAPPER}
				else
					mod_cmdline_wrapper=${game_exe}-${PN#*-}
				fi

				make_desktop_entry "${mod_cmdline_wrapper}" \
					"${mod_desktop_title}" "${MOD_ICON_USED}" \
					|| die "make_desktop_entry ${mod_cmdline_wrapper} ${mod_desktop_title} ${MOD_ICON_USED} failed"
			fi
		fi
	done
}

games-mod_src_install_doc() {
	# Install documents
	if [[ "${MOD_DODOC}" = "y" ]] ; then
		find . -maxdepth 1 -name '*.txt' -exec dodoc '{}' \;
		find . -maxdepth 1 '(' -name '*.htm' -o -name '*.html' ')' -exec dohtml '{}' \;
	else
		# *** For ut2004, want to insert into Help subdir ***
		insinto "${dir}/${MOD_DIR}"
		find . -maxdepth 1 -name '*.txt' -exec doins '{}' \;
		find . -maxdepth 1 '(' -name '*.htm' -o -name '*.html' ')' -exec doins '{}' \;
	fi
}
