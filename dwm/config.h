/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 0;         /* border pixel of windows */
static const unsigned int snap      = 0;         /* snap pixel */
static const int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static const int showbar            = 1;         /* 0 means no bar */
static const int topbar             = 1;         /* 0 means bottom bar */
static const char *fonts[]          = { "Fira Code:size=10" };
static const int smartgaps          = 0;         /* 1 means no outer gap when there is only one window */
static const unsigned int gappih    = 15;        /* horiz inner gap between windows */
static const unsigned int gappiv    = 15;        /* vert inner gap between windows */
static const unsigned int gappoh    = 30;        /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 30;        /* vert outer gap between windows and screen edge */
static const int focusonwheel       = 0;         /* don't focus on mwheel event */
static const int usealtbar          = 1;         /* 1 means use non-dwm status bar */
static const char *altbarclass      = "Polybar"; /* Alternate bar class name */
static const char *alttrayname      = "stalonetray";    /* Polybar tray instance name */
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char *colors[][3]      = {
	/*             fg           bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

typedef struct {
	const char *name;
	const void *cmd;
} Sp;
const char *spcmd1[] = {"alacritty", "-t", "spterm", NULL };
const char *spcmd2[] = {"alacritty", "-t", "spmusic", "-e", "ncmpcpp", NULL };
const char *spcmd3[] = {"alacritty", "-t", "splf", "-e", "lf", NULL };
static Sp scratchpads[] = {
	/* name          cmd  */
	{"spterm",      spcmd1},
	{"spmusic",     spcmd2},
	{"splf",        spcmd3},
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9"};

static const Rule rules[] = {
	/*	WM_CLASS(STRING) = instance, class
	 	WM_NAME(STRING) = title
       class     instance  title           tags mask  isfloating  isterminal  noswallow  monitor */
//	{  NULL,       NULL,   "spterm",   SPTAG(0),     1,           1,        0,          -1},
//	{  NULL,       NULL,   "spmusic",  SPTAG(1),     1,           1,        0,          -1},
//	{  NULL,       NULL,   "splf",     SPTAG(2),     1,           1,        0,          -1},
	{  NULL,       NULL,   "Alacritty",0,            0,           1,        0,          -1},
	{  NULL,       NULL,   "stalonetray",1<<8,            0,           0,        0,          -1},
};

#include "vanitygaps.c"
/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "",      dwindle },
	{ "",      monocle },
	{ "",	    centeredmaster },
	{ "",	    bstack },
	{ "",      NULL },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
#define STACKKEYS(MOD,ACTION) \
	{ MOD,	XK_Tab,	ACTION##stack,	{.i = INC(+1) } }, \
	{ MOD|ShiftMask,	XK_Tab,	ACTION##stack,	{.i = INC(-1) } }, \
	{ MOD,  XK_v,   ACTION##stack,  {.i = 0 } }, \

#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *termcmd[]  = { "alacritty", NULL };

#include <X11/XF86keysym.h>
static Key keys[] = {
	/* modifier                 key                   function        argument */
	STACKKEYS(MODKEY,                                 focus)
	STACKKEYS(MODKEY|ShiftMask,                       push)

	TAGKEYS(			        XK_1,		          0)
	TAGKEYS(			        XK_2,		          1)
	TAGKEYS(			        XK_3,		          2)
	TAGKEYS(			        XK_4,		          3)
	TAGKEYS(			        XK_5,		          4)
	TAGKEYS(			        XK_6,		          5)
	TAGKEYS(			        XK_7,		          6)
	TAGKEYS(			        XK_8,		          7)
	TAGKEYS(			        XK_9,		          8)

	/* modifier                 key                   function          argument */
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
	{ MODKEY,			        XK_0,		          view,		        {.ui = ~0 } },
	{ MODKEY|ShiftMask,         XK_0,		          tag,		        {.ui = ~0 } },
	{ MODKEY,			        XK_semicolon,         view,		        {0} },
	{ MODKEY,		            XK_q,		          killclient,	    {0} },
	{ MODKEY,			        XK_t,		          setlayout,	    {.v = &layouts[0]} }, /* tile */
	{ MODKEY,		            XK_m,		          setlayout,	    {.v = &layouts[1]} }, /* monocle */
	{ MODKEY|ShiftMask,			XK_c,		          setlayout,	    {.v = &layouts[2]} }, /* centeredmaster */
	{ MODKEY,			        XK_b,		          setlayout,	    {.v = &layouts[3]} }, /* bstack */
	{ MODKEY|ShiftMask,		    XK_f,		          setlayout,	    {.v = &layouts[4]} }, /* floating */
	{ MODKEY,			        XK_comma,		      incnmaster,       {.i = +1 } },
	{ MODKEY|ShiftMask,		    XK_comma,		      incnmaster,       {.i = -1 } },
	{ MODKEY|ShiftMask,         XK_q,                 quit,             {1} },
 	{ MODKEY,			        XK_a,		          togglegaps,	    {0} },
 	{ MODKEY,        		    XK_r,    	          togglescratch,    {.ui = 2} },
	{ MODKEY|ShiftMask,		    XK_a,		          defaultgaps,	    {0} },
    { MODKEY,			        XK_f,		          togglefullscr,    {0} },
	{ MODKEY,			        XK_h,		          setmfact,	        {.f = -0.05} },
	{ MODKEY,			        XK_l,		          setmfact,      	{.f = +0.05} },
	{ MODKEY,                   XK_Return,	          spawn,		    {.v = termcmd } },
	{ MODKEY,			        XK_w,		          spawn,            SHCMD("rofi -show drun -show-icons")},
	{ MODKEY|ShiftMask,			XK_w,		          spawn,            SHCMD("rofi -show run")},
 	{ MODKEY|ShiftMask,		    XK_x,	              togglescratch,    {.ui = 0} },
	{ MODKEY,		            XK_e,		          incrgaps,	        {.i = +8 } },
//	{ MODKEY,                   XK_p,                 togglebar,              {0} },
	{ MODKEY,			        XK_comma,	          focusmon,	        {.i = -1 } },
	{ MODKEY|ShiftMask,		    XK_comma,	          tagmon,		    {.i = -1 } },
	{ MODKEY,			        XK_period,	          focusmon,	        {.i = +1 } },
	{ MODKEY|ShiftMask,		    XK_period,	          tagmon,		    {.i = +1 } },
	{ MODKEY,			        XK_space,	          zoom,		        {0} },
	{ MODKEY|ShiftMask,		    XK_space,	          togglefloating,	{0} },
//	{ MODKEY,                   XK_u,                 spawn,             SHCMD("vol-up") },
//	{ MODKEY,                   XK_i,                 spawn,             SHCMD("vol-down") },
//	{ MODKEY,                   XK_o,                 spawn,		     SHCMD("xbacklight -inc 5") },
//	{ MODKEY,                   XK_p,                 spawn,		     SHCMD("xbacklight -dec 5") },
//	{ MODKEY,                   XK_s,                 spawn,		     SHCMD("bang") },
	{ MODKEY,                   XK_Print,                 spawn,		     SHCMD("flameshot gui") },

	/* modifier                 key                          function          argument */
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
//	{ 0,                        XF86XK_Mail,		         focusmon,		    {.i = +1 } },
//	{ 0|ShiftMask,              XF86XK_Mail,		         tagmon, 		    {.i = +1 } },
// 	{ 0,			            XF86XK_Calculator,	         togglescratch,	    {.ui = 1} }, /* spawn ncmpcpp terminal */
	{ 0,                        XF86XK_AudioPrev,		     spawn,		        SHCMD("playerctl previous") },
	{ 0,                        XF86XK_AudioNext,		     spawn,		        SHCMD("playerctl next") },
//	{ 0,                        XF86XK_AudioPause,		     spawn,		        SHCMD("mpc pause") },
	{ 0,                        XF86XK_AudioPlay,		     spawn,		        SHCMD("playerctl play-pause") },
//	{ 0,                        XF86XK_AudioStop,		     spawn,		        SHCMD("mpc stop") },
//	{ 0,                        XF86XK_AudioRewind,	         spawn,		        SHCMD("mpc seek -10") },
//	{ 0,                        XF86XK_AudioForward,	     spawn,		        SHCMD("mpc seek +10") },
    { 0 ,                       XF86XK_AudioLowerVolume,     spawn,		        SHCMD("amixer sset Master 5%-")},
    { 0 ,                       XF86XK_AudioRaiseVolume,     spawn,		        SHCMD("amixer sset Master 5%+")},
    { 0 ,                       XF86XK_MonBrightnessUp,      spawn,		        SHCMD("xbacklight -inc 5")},
    { 0 ,                       XF86XK_MonBrightnessDown,    spawn,		        SHCMD("xbacklight -dec 5")},
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

static const char *ipcsockpath = "/tmp/dwm.sock";
static IPCCommand ipccommands[] = {
  IPCCOMMAND(  view,                1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  toggleview,          1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  tag,                 1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  toggletag,           1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  tagmon,              1,      {ARG_TYPE_UINT}   ),
  IPCCOMMAND(  focusmon,            1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  focusstack,          1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  zoom,                1,      {ARG_TYPE_NONE}   ),
  IPCCOMMAND(  spawn,               1,      {ARG_TYPE_PTR}    ),
  IPCCOMMAND(  incnmaster,          1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  killclient,          1,      {ARG_TYPE_SINT}   ),
  IPCCOMMAND(  togglefloating,      1,      {ARG_TYPE_NONE}   ),
  IPCCOMMAND(  setmfact,            1,      {ARG_TYPE_FLOAT}  ),
  IPCCOMMAND(  setlayoutsafe,       1,      {ARG_TYPE_PTR}    ),
  IPCCOMMAND(  quit,                1,      {ARG_TYPE_NONE}   )
};
