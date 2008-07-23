# Config file for /etc/init.d/cdemu-daemon

CDEMUD_DEVICES=1
#ifdef ALSA
CDEMUD_BACKEND=alsa
#else
CDEMUD_BACKEND=null
#endif

