# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

DESCRIPTION="A Qt4 client for the popular Polish Gadu-Gadu IM network"
HOMEPAGE="http://kadu.net"
KEYWORDS=""
LICENSE="GPL-2"

IUSE="alsa debug emoticons +gadu +jabber kde phonon sounds spell"

SLOT="0"

DEPEND=">=net-im/kadu-core-${PV}[debug?]
	>=net-im/kadu-autoaway-${PV}[debug?]
	>=net-im/kadu-auto_hide-${PV}[debug?]
	>=net-im/kadu-config_wizard-${PV}[debug?]
	>=net-im/kadu-sms-${PV}[debug?]
	>=net-im/kadu-hints-${PV}[debug?]
	>=net-im/kadu-history-${PV}[debug?]
	>=net-im/kadu-history_migration-${PV}[debug?]
	>=net-im/kadu-sql_history-${PV}[debug?]
	>=net-im/kadu-qt4_docking-${PV}[debug?]
	alsa? ( >=net-im/kadu-alsa_sound-${PV}[debug?] )
	phonon? ( >=net-im/kadu-phonon_sound-${PV}[debug?] )
	emoticons? ( >=net-im/kadu-emoticons-0.6.5 )
	sounds? ( >=net-im/kadu-sounds-0.6.5 )
	gadu? ( >=net-im/kadu-gadu_protocol-${PV}[debug?] )
	jabber? ( >=net-im/kadu-jabber_protocol-${PV}[debug?] )
	kde? ( >=net-im/kadu-kde_notify-${PV}[debug?] )
	spell? ( >=net-im/kadu-spellchecker-${PV}[debug?] )
	!<net-im/kadu-account_management-0.6.6_beta
	!<net-im/kadu-advanced_userlist-0.6.6_beta
	!<net-im/kadu-agent-0.6.6_beta
	!<net-im/kadu-amarok1_mediaplayer-0.6.6_beta
	!<net-im/kadu-anonymous_check-0.6.6_beta
	!<net-im/kadu-ao_sound-0.6.6_beta
	!<net-im/kadu-audacious_mediaplayer-0.6.6_beta
	!<net-im/kadu-bmpx_mediaplayer-0.6.6_beta
	!<net-im/kadu-dcc-0.6.6_beta
	!<net-im/kadu-default_sms-0.6.6_beta
	!<net-im/kadu-dragon_mediaplayer-0.6.6_beta
	!<net-im/kadu-dsp_sound-0.6.6_beta
	!<net-im/kadu-encryption-0.6.6_beta
	!<net-im/kadu-encryption_old-0.6.6_beta
	!<net-im/kadu-filtering-0.6.6_beta
	!<net-im/kadu-gg_avatars-0.6.6_beta
	!<net-im/kadu-mpris_mediaplayer-0.6.6_beta
	!<net-im/kadu-notify-0.6.6_beta
	!<net-im/kadu-osd_hints-0.6.6_beta
	!<net-im/kadu-powerkadu-0.6.6_beta
	!<net-im/kadu-profiles-0.6.6_beta
	!<net-im/kadu-qt4_sound-0.6.6_beta
	!<net-im/kadu-split_messages-0.6.6_beta
	!<net-im/kadu-vlc_mediaplayer-0.6.6_beta
	!<net-im/kadu-voice-0.6.6_beta
	!<net-im/kadu-weather-0.6.6_beta
	!<net-im/kadu-window_notify-0.6.6_beta
	!net-im/kadu-globalhotkeys
	!net-im/kadu-led_notify
	!net-im/kadu-mail
	!net-im/kadu-mime_tex
	!net-im/kadu-mx610_notify
	!net-im/kadu-nextinfo
	!net-im/kadu-pajacyk
	!net-im/kadu-panelkadu
	!net-im/kadu-plus_pl_sms
	!net-im/kadu-senthistory
	!>=net-im/kadu-tabs-1.2.7
	!net-im/kadu-water_notify
"
RDEPEND="${DEPEND}"
