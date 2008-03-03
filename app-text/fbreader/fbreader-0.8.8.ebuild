# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="FBReader (E-book reader for Linux PDAs and desktop)"
HOMEPAGE="http://www.fbreader.org/"
SRC_URI="http://www.fbreader.org/${PN}-sources-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="qt3 qt4 gtk cjk debug"
DEPEND="app-arch/bzip2
	cjk? ( >=app-i18n/enca-1.9 )
	!cjk? ( >=app-i18n/enca-1.7 ) 
	qt3? ( =x11-libs/qt-3* )
	qt4? ( =x11-libs/qt-4* )
	gtk? ( =x11-libs/gtk+-2* )"
RDEPEND="${DEPEND}"	


src_compile () {
	cd ${S}

	sed -i "s:INSTALLDIR=/usr/local:INSTALLDIR=/usr:" makefiles/arch/desktop.mk || die "updating desktop.mk failed"

	echo "TARGET_ARCH = desktop" > makefiles/target.mk
	if use qt3; then
		echo "UI_TYPE = qt" >> makefiles/target.mk
	sed -i "s:UILIBS = -lqt-mt:UILIBS = -L${QTDIR}/lib -lqt-mt:" makefiles/arch/desktop.mk
	sed -i "s:MOC = moc-qt3:MOC = ${QTDIR}/bin/moc:" makefiles/arch/desktop.mk || die "updating desktop.mk failed"
	sed -i "s:QTINCLUDE = -I /usr/include/qt3:QTINCLUDE = -I ${QTDIR}/include:" makefiles/arch/desktop.mk || die "updating desktop.mk failed"
	elif use qt4; then
		echo "UI_TYPE = qt4" >> makefiles/target.mk
		sed -i "s:MOC = moc-qt4:MOC = /usr/bin/moc:" makefiles/arch/desktop.mk || die "updating desktop.mk failed"
		sed -i "s:UILIBS = -lQtGui:UILIBS = /usr/lib/qt4/libQtGui.so:" makefiles/arch/desktop.mk || die "updating desktop.mk failed" 
		
	elif use gtk; then
		echo "UI_TYPE = gtk" >> makefiles/target.mk
		
	else ewarn "Please make a use variable selection for GUI toolkit.  Choices are qt3, qt4, and gtk" 
		 die "Unknown GUI toolkit."	
	fi
	if use debug; then
		echo "TARGET_STATUS = debug" >> makefiles/target.mk
	else
		echo "TARGET_STATUS = release" >> makefiles/target.mk
	fi

	emake || die "emake failed"
}

src_install()
{
	emake DESTDIR=${D} install || die "install failed"
	doicon ${D}/usr/share/FBReader/icons/FBReader.png
	make_desktop_entry "FBReader" "FBReader" FBReader.png
}
