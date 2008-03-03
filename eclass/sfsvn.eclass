# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Original Author: David Watzke <david@watzke.cz>
# Purpose: Simplify fetching from SourceForge SVN
#

inherit subversion

SRC_URI=""

ESVN_REPO_URI="${ESVN_AUTH:-https}://${PN}.svn.sourceforge.net/svnroot/${PN}"
ESVN_MODULE="${PN}"

S="${WORKDIR}/${PN}"
