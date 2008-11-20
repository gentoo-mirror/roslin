# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games eutils

MY_PV="99-17-1"

DESCRIPTION="A free Transport Tycoon clone"
HOMEPAGE="http://www.simutrans.com/"

# We need binary source for fonts and text
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${MY_PV}.zip
	mirror://sourceforge/${PN}/simulinux-${MY_PV}.zip
	minimal? (
		mirror://sourceforge/${PN}/pak64-${MY_PV}.zip
		mirror://sourceforge/${PN}/pak64-addon-food-${MY_PV}.zip
		http://download.simutrans.com/pak64/simupak64-waste-99-13.zip
	)
	!minimal? ( mirror://sourceforge/pak128_1-4-3_0-${MY_PV}.zip )"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="strip"
IUSE="allegro debug midi minimal sdl"

DEPEND="app-arch/unzip"
RDEPEND="media-libs/libpng
	allegro? ( media-libs/allegro )
	sdl? ( media-libs/libsdl
		media-libs/sdl-mixer )"

LANGS="be ca cn cz de dk en es et fi fr hr hu it ja nl no pl pt ro ru sk sv zh"
for X in ${LANGS}; do
	IUSE="${IUSE} linguas_${X}"
done

S=${WORKDIR}
dir=${GAMES_DATADIR}/${PN}

pkg_setup() {
	if use midi && ! built_with_use media-libs/sdl-mixer timidity ; then
		eerror "Please rebuild media-libs/sdl-mixer with \"timidity\" flag enabled"
		die "Missing \"timidity\" USE flag in media-libs/sdl-mixer"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# sdl?
	if use sdl ; then
		sed -i \
			-e "s|#BACKEND = sdl|BACKEND = sdl|" \
			-e "s|#BACKEND = mixer|BACKEND = mixer|" \
			config.template || die "sed sdl"
	# allegro?
	elif use allegro ; then
		sed -i \
			-e "s|#BACKEND = allegro|BACKEND = allegro|" \
			config.template || die "sed allegro"
	# none? (x11 is broken)
	else
		die "You have to choose allegro or sdl for simutrans"
	fi

	# debug?
	if use debug ; then
		sed -i \
			-e "s|#DEBUG = 3|DEBUG = 3|" \
			config.template || die "sed debug"
	fi

	# set optimizations
	sed -i \
		-e "s|#VERBOSE|VERBOSE|" \
		config.template || die "sed optimisations"
	sed -i \
		-e "s|CFLAGS   += -O|CFLAGS   += ${CFLAGS}|" \
		-e "s|CXXFLAGS += -O|CXXFLAGS += ${CXXFLAGS}|" \
		Makefile || die "sed optimisations"

	# set a proper colour depth
	sed -i \
		-e "s|#COLOUR_DEPTH = 16|COLOUR_DEPTH = 16|" \
		config.template || die "sed colour"
	
	# set ostype
	sed -i \
		-e "s|#OSTYPE = linux|OSTYPE = linux|" \
		config.template || die "sed ostype"

	# make template the default config
	cp config.template config.default

	rm -r ${PN}/*/.svn ${PN}/*/*/.svn
}

src_install() {
	local LANG=
	for LANG in ${LINGUAS}; do
		if has ${LANG} ${LANGS}; then
			einfo "Installing ${LANG} translation ..."
			insinto ${dir}/text
			doins -r ${PN}/text/${LANG}*
			continue
		fi
		ewarn "Sorry, but ${PN} does not support the ${LANG} LINGUA"
	done

	insinto ${dir}
	doins -r ${PN}/font || die "doins font failed"

	if use minimal ; then
		doins -r ${PN}/pak || die "doins pak failed"
	else
		doins -r ${PN}/pak128 || die "doins pak128 failed"
	fi

	if use midi ; then
		doins -r ${PN}/music || die "doins music failed"
	fi

	exeinto ${dir}
	doexe sim

	games_make_wrapper ${PN} ./sim "${dir}"
	make_desktop_entry ${PN} "Simutrans"

	prepgamesdirs
}
