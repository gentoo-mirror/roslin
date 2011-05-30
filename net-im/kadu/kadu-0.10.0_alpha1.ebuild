# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="A multi-protocol IM client written in Qt4"
HOMEPAGE="http://kadu.net"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"

IUSE="alsa debug +gadu +jabber +phonon spell ssl"

SLOT="0"

RDEPEND=">=net-im/kadu-core-${PV}[debug?]
	>=net-im/kadu-autoaway-${PV}[debug?]
	>=net-im/kadu-auto_hide-${PV}[debug?]
	>=net-im/kadu-config_wizard-${PV}[debug?]
	>=net-im/kadu-sms-${PV}[debug?]
	>=net-im/kadu-hints-${PV}[debug?]
	>=net-im/kadu-history-${PV}[debug?]
	>=net-im/kadu-history_migration-${PV}[debug?]
	>=net-im/kadu-profiles_import-${PV}[debug?]
	>=net-im/kadu-sql_history-${PV}[debug?]
	>=net-im/kadu-qt4_docking-${PV}[debug?]
	phonon? ( >=net-im/kadu-phonon_sound-${PV}[debug?] )
	gadu? ( >=net-im/kadu-gadu_protocol-${PV}[debug?] )
	jabber? ( >=net-im/kadu-jabber_protocol-${PV}[debug?] )
	spell? ( >=net-im/kadu-spellchecker-${PV}[debug?] )
	ssl? ( >=net-im/kadu-encryption_ng_simlite-${PV}[debug?] )
	!net-im/kadu-advanced_userlist
	!net-im/kadu-account_management
	!net-im/kadu-agent
	!net-im/kadu-amarok1_mediaplayer
	!net-im/kadu-ao_sound
	!net-im/kadu-dbus
	!net-im/kadu-dcc
	!net-im/kadu-default_sms
	!net-im/kadu-dsp_sound
	!net-im/kadu-encryption
	!net-im/kadu-encryption_old
	!net-im/kadu-filtering
	!net-im/kadu-gg_avatars
	!net-im/kadu-led_notify
	!net-im/kadu-mail
	!net-im/kadu-mx610_notify
	!net-im/kadu-notify
	!net-im/kadu-osd_hints
	!net-im/kadu-pajacyk
	!net-im/kadu-plus_pl_sms
	!net-im/kadu-powerkadu
	!net-im/kadu-profiles
	!net-im/kadu-qt4_sound
	!net-im/kadu-split_messages
	!net-im/kadu-voice
	!net-im/kadu-water_notify
	!net-im/kadu-weather
	!net-im/kadu-window_notify
	!net-im/kadu-alsa_sound
	!net-im/kadu-amarok2_mediaplayer
	!net-im/kadu-anonymous_check
	!net-im/kadu-audacious_mediaplayer
	!net-im/kadu-bmpx_mediaplayer
	!net-im/kadu-dragon_mediaplayer
	!net-im/kadu-globalhotkeys
	!net-im/kadu-kde_notify
	!net-im/kadu-lednotify
	!net-im/kadu-mime_tex
	!net-im/kadu-nextinfo
	!net-im/kadu-panelkadu
	!net-im/kadu-parser_extender
	!net-im/kadu-senthistory
	!net-im/kadu-server_monitor
	!net-im/kadu-splitmessages
	!net-im/kadu-split_messages
	!net-im/kadu-vlc_mediaplayer
	!net-im/kadu-icons
	!net-im/kadu-emoticons
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"