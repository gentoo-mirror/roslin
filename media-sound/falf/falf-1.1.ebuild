inherit kde eutils qt3

DESCRIPTION="FALF Player is brand-new, written from scratch music player for K Desktop Environment"
HOMEPAGE="http://kde-apps.org/content/show.php/FALF+Player?content=43961"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL"

RESTRICT="nomirror"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

LANGS="cs es it nl pl ru zh_CN uk"
for X in ${LANGS}; do
        IUSE="${IUSE} linguas_${X}"
done


DEPEND="media-libs/taglib"

need-kde 3.3

src_compile(){
        # Generate translations
        #cd "${S}"/src/translations
        local LANG=
        for LANG in ${LINGUAS}; do
                if has ${LANG} ${LANGS}; then
                        einfo "Generating ${LANG} translation ..."
                        #lrelease ${PN}_${LANG}.ts || die "Failed to generate ${LANG} translation!"
			msgfmt "po/${LANG}/falf.po" -o "po/${LANG}/falf.mo"
			#insinto ${KDEDIR}/share/locale/${LANG}/LC_MESSAGES/
			#doins po/${LANG}/falf.mo
                        continue
                fi
                ewarn "Sorry, but ${PN} does not support the ${LANG} LINGUA"
        done



    eqmake3 ${PN}.pro
    emake

}

src_install() {
        #emake DESTDIR="${D}" install || die "emake install failed"
        #prepalldocs
        local LANG=
        for LANG in ${LINGUAS}; do
                if has ${LANG} ${LANGS}; then
                        einfo "Installing ${LANG} translation ..."
                        #lrelease ${PN}_${LANG}.ts || die "Failed to generate ${LANG} translation!"
                        #msgfmt "po/${LANG}/falf.po" -o "po/${LANG}/falf.mo"
                        insinto ${KDEDIR}/share/locale/${LANG}/LC_MESSAGES/
                        doins po/${LANG}/falf.mo
                        continue
                fi
                ewarn "Sorry, but ${PN} does not support the ${LANG} LINGUA"
        done

	insinto ${KDEDIR}/share/icons/default.kde
	doins -r icons/*
	
	insinto ${KDEDIR}/share/applnk/Multimedia
	doins applnk/falf.desktop
	
	insinto ${KDEDIR}/share/apps/konqueror/servicemenus
	doins applnk/falf_mnu.desktop
	
        insinto ${KDEDIR}/share/apps/dolphin/servicemenus
        doins applnk/falf_mnu.desktop

	
	exeinto ${KDEDIR}/bin/
	doexe bin/falf
}
