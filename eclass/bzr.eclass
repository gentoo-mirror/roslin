# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
#
# Original Author:	  Marien Zwart <marienz@gentoo.org>
# Maintainer:		   Ed Catmur <ed@catmur.co.uk>
#
# Modified  Jonathan Miller <millerj@mail.monkeydisaster.net>
#   added write permissions before initial checkout
#
# Originally derived from the tla eclass, but much simpler.
#
# Just set BZR_BRANCH to the url of the branch and the src_unpack this
# eclass provides will put an export of the branch in ${WORKDIR}/${P}.
# You shouldn't change these settings yourself! The ebuild/eclass inheriting# this eclass will take care of that.

# --- begin ebuild-configurable settings

# Where the tla modules are stored/accessed
: ${BZR_TOP_DIR:=${PORTAGE_ACTUAL_DISTDIR-${DISTDIR}}/bzr-src}

# branch url
: ${BZR_BRANCH:=}

# The location in which to cache the version, relative to BZR_TOP_DIR.
: ${BZR_CACHE_DIR:=${PN}}

# Revision to get, if not latest (see http://bazaar-vcs.org/BzrRevisionSpec)
: ${BZR_REVISION:=}

# --- end ebuild-configurable settings ---

# add bzr to deps
DEPEND="dev-util/bzr"

bzr_src_unpack() {
		# create the top dir if needed
		if [[ ! -d "${BZR_TOP_DIR}" ]]; then
				# this will only suffice if we only need the final directory
				addwrite "$(dirname ${BZR_TOP_DIR})"
				mkdir -p "${BZR_TOP_DIR}" || die "unable to create
${BZR_TOP_DIR}"
		fi

		local codir="${BZR_TOP_DIR}/${BZR_CACHE_DIR}"

		addwrite "${codir}"

		# check if this is an initial checkout
		if [[ -d "${codir}" || "${BZR_REVISION}" ]]; then
				cd "${codir}"
				bzr up || die "bzr update failed"
		else
				addwrite "${BZR_TOP_DIR}"
				bzr co "${BZR_BRANCH}" "${codir}" \
						|| die "bzr get failed Branch: ${BZR_BRANCH}"
		fi

		cd "${codir}"

		einfo "exporting..."
		bzr export ${BZR_REVISION:+-r ${BZR_REVISION}} "${WORKDIR}/${P}" ||
die "bzr export failed"

		einfo "Revision $(bzr revno) is now in ${WORKDIR}/${P}"

		cd "${WORKDIR}"
}

EXPORT_FUNCTIONS src_unpack

