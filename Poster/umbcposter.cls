% Note: This file is formatted to be viewed with tabstops set to 4 spaces.
% vi: ts=4 sw=4

%% umbcposter.cls
%% Copyright 2010 Rouben Rostamian  -- http://www.math.umbc.edu/~rouben/
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% The Current Maintainer of this work is Rouben Rostamian
% 
% The list of files that constitute the umbcposter package
% is given in the file `manifest.txt' which is a part of
% umbcposter distribution.

% 
% Revision history:
% 2010/02/20: Preliminary release
% 2010/03/21: First official release

%--- Section 1: Load packages, parse documentclass options --------------------%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{umbcposter}[2010/03/21 UMBC Poster class -- version 1.0]
\typeout{umbcposter by Rouben Rostamian --
		http://www.math.umbc.edu/\protect~rouben/}

\LoadClass{article}[2004/02/16]
\pagestyle{empty}

\newcommand{\umbcP@theme}{plain}
\newdimen{\umbcP@mag}
\umbcP@mag=1.0pt
\PassOptionsToPackage{paper=a4paper}{geometry}	% default paper

% class options
\RequirePackage{pgfopts}
\pgfkeys{
	/umbcposter/docopts/.cd, 
	%
	landscape/.default=true,
	landscape/.code=\PassOptionsToPackage{landscape=#1}{geometry},
	%
	portrait/.default=true,
	portrait/.code=\PassOptionsToPackage{portrait=#1}{geometry},
	%
	paper/.value required,
	paper/.code=\PassOptionsToPackage{paper=#1}{geometry},
	%
	papersize/.value required,    % papersize={width,height}
	papersize/.code=\PassOptionsToPackage{papersize={#1}}{geometry},
	%
	fontmag/.default=1.0,
	fontmag/.code={\umbcP@mag=#1pt},
	%
	preview/.default={},
	preview/.code=\newcommand{\umbcP@preview}{#1},
	%
	margin/.value required,
	margin/.code={
		\newlength{\umbcP@margin}
		\setlength{\umbcP@margin}{#1}
		\PassOptionsToPackage{margin=#1}{geometry}},
	%
	theme/.value required,
	theme/.code=\renewcommand{\umbcP@theme}{#1},
	%
	dvipsnames/.value forbidden,
	dvipsnames/.code=\PassOptionsToPackage{dvipsnames}{xcolor},
	%
	svgnames/.value forbidden,
	svgnames/.code=\PassOptionsToPackage{svgnames}{xcolor},
}

% process documentclass options
\ProcessPgfOptions{/umbcposter/docopts}

% Scale fontsizes according to the requested fontmag.  This works best with
% PostScript fonts.  We include the type1cm package here to force PostScript
% version of the computer modern fonts. 
%
% The base font sizes are taken from LaTeX's standard size10.clo file.
\RequirePackage{type1cm} 

\renewcommand{\tiny}{\fontsize{5\umbcP@mag}{6\umbcP@mag}\selectfont}
\renewcommand{\scriptsize}{\fontsize{7\umbcP@mag}{8\umbcP@mag}\selectfont}
\renewcommand{\footnotesize}{%
	\fontsize{8\umbcP@mag}{9.5\umbcP@mag}\selectfont
	\abovedisplayskip 6\umbcP@mag \@plus2\umbcP@mag \@minus4\umbcP@mag
	\abovedisplayshortskip \z@ \@plus\umbcP@mag
	\belowdisplayshortskip 3\umbcP@mag \@plus\umbcP@mag \@minus2\umbcP@mag
	\def\@listi{\leftmargini 2.0em \leftmargin\leftmargini
		\topsep 3\umbcP@mag \@plus\umbcP@mag \@minus\umbcP@mag
		\parsep 2\umbcP@mag \@plus\umbcP@mag \@minus\umbcP@mag
		\itemsep \parsep}%
	\belowdisplayskip \abovedisplayskip
}
\renewcommand{\small}{%
	\fontsize{9\umbcP@mag}{11\umbcP@mag}\selectfont
	\abovedisplayskip 8.5\umbcP@mag \@plus3\umbcP@mag \@minus4\umbcP@mag
	\abovedisplayshortskip \z@ \@plus2\umbcP@mag
	\belowdisplayshortskip 4\umbcP@mag \@plus2\umbcP@mag \@minus2\umbcP@mag
	\def\@listi{\leftmargini 2.0em \leftmargin\leftmargini
		\topsep 4\umbcP@mag \@plus2\umbcP@mag \@minus2\umbcP@mag
		\parsep 2\umbcP@mag \@plus\umbcP@mag \@minus\umbcP@mag
		\itemsep \parsep}%
	\belowdisplayskip \abovedisplayskip
}
\renewcommand{\normalsize}{%
	\fontsize{10\umbcP@mag}{12\umbcP@mag}\selectfont
	\abovedisplayskip 10\umbcP@mag \@plus2\umbcP@mag \@minus5\umbcP@mag
	\abovedisplayshortskip \z@ \@plus3\umbcP@mag
	\belowdisplayshortskip 6\umbcP@mag \@plus3\umbcP@mag \@minus3\umbcP@mag
	\belowdisplayskip \abovedisplayskip
	\let\@listi\@listI
}
\renewcommand{\large}{\fontsize{12\umbcP@mag}{14\umbcP@mag}\selectfont}
\renewcommand{\Large}{\fontsize{14\umbcP@mag}{18\umbcP@mag}\selectfont}
\renewcommand{\LARGE}{\fontsize{17\umbcP@mag}{22\umbcP@mag}\selectfont}
\renewcommand{\huge}{\fontsize{20\umbcP@mag}{25\umbcP@mag}\selectfont}
\renewcommand{\Huge}{\fontsize{25\umbcP@mag}{30\umbcP@mag}\selectfont}

% We select the normal font for the rest of the preamble.
% This is important to set the fontsize-dependent units, such
% as em and ex right.  LaTeX resets the fontsize to pre-scaled size
% after the document begins.  Therefore we apply the same font-changing
% command once again inside \posterinit.
\normalsize

\RequirePackage[
	%showframe,
	%includeheadfoot,noheadfoot
	]{geometry}[2002/07/08]
\RequirePackage{ifthen}[2001/05/26]
\RequirePackage{calc}[1998/07/07]
\RequirePackage{tikz}[2008/02/13]
\usetikzlibrary{positioning,fit,shadows}

% Compute the smaller of width and height, for scaling.
\newlength{\umbcP@minwidth}
\ifthenelse{\lengthtest{\paperwidth<\paperheight}}
	{\setlength{\umbcP@minwidth}{\paperwidth}}
	{\setlength{\umbcP@minwidth}{\paperheight}}

% Set default margin width, if not specified by user.
% The 0.018 factor gives a 15mm margin on an A0 paper: 0.018*841 = 15.138
\ifthenelse{\isundefined{\umbcP@margin}}{
	\newlength{\umbcP@margin}
	\setlength{\umbcP@margin}{0.018\umbcP@minwidth}
}{}

% We work with two different scales of the document.
% 
% Scale #1: The \umbcP@physical* dimensions correspond to those of the
% final printed poster.
\newlength{\umbcP@physicalWidth}
\newlength{\umbcP@physicalHeight}
\setlength{\umbcP@physicalWidth}{\paperwidth}
\setlength{\umbcP@physicalHeight}{\paperheight}

% Scale #2: The \umbcP@screen* dimensions correspond to a preview version of
% the poster which is easier to work with on the computer screen.  These are
% obtained by scaling the poster such that its min(width,height) becomes
% 210mm which is the narrow width of an a4 paper.  In this scale, the
% poster's size is comparable to an a4 paper.
%
% All the drawing is done at this scale.  The usual font sizes which are
% designed for papers of roughly this size, do a good job here.
% At the end, a call to \pgfpagesuselayout resizes the poster, and
% the fonts along with it, to the Scale #1 level.

\newcommand{\umbcP@scale}{210mm/\umbcP@minwidth}

\newlength{\umbcP@scaledWidth}
\newlength{\umbcP@scaledHeight}
\newlength{\marginwidth}
\pgfmathsetlength{\umbcP@scaledWidth}{\umbcP@scale*\umbcP@physicalWidth}
\pgfmathsetlength{\umbcP@scaledHeight}{\umbcP@scale*\umbcP@physicalHeight}
\pgfmathsetlength{\marginwidth}{\umbcP@scale*\umbcP@margin}

\geometry{%
        paperwidth      = \umbcP@scaledWidth,
        paperheight     = \umbcP@scaledHeight,
		margin			= \marginwidth,
}

\RequirePackage{pgfpages}[2004/11/05]
\ifthenelse{\isundefined{\umbcP@preview}}
	{
		\pgfpagesuselayout{resize to}[
			physical paper width  = \umbcP@physicalWidth,
			physical paper height = \umbcP@physicalHeight]
	}{
		\pgfpagesuselayout{resize to}[
			physical paper width  = \umbcP@scaledWidth,
			physical paper height = \umbcP@scaledHeight]
	}

% Define the default design parameters here.  These may be further
% redefined in a umbcposter-\umbcP@theme.clo file.  And yet further
% modified by user config specifications.
\newlength{\umbcP@colGap}		\setlength{\umbcP@colGap}{1em}
\newlength{\umbcP@rowGap}		\setlength{\umbcP@rowGap}{1em}
\newlength{\umbcP@boxRadius}	\setlength{\umbcP@boxRadius}{4ex}
\newlength{\umbcP@boxTHeight}	\setlength{\umbcP@boxTHeight}{4ex}
% \headheight is already defined in article.cls.  Here we redefine it.
\setlength{\headheight}{0.10\textheight}

\input{umbcposter-\umbcP@theme.clo}


%--- Section 2a: Parse \posterinit's general arguments  -----------------------%

% background style
\newcommand{\umbcP@paintbg}{\relax}
\pgfkeys{/umbcposter/background style/.default={
	inner color=red, outer color=yellow}}
\pgfkeys{/umbcposter/background style/.code=
	\renewcommand{\umbcP@paintbg}{
		\path [#1] (current page.south west)
			rectangle (current page.north east); }}

% background command
\newcommand{\umbcP@bgCommand}{\relax}
\pgfkeys{/umbcposter/background command/.value required}
\pgfkeys{/umbcposter/background command/.code=
	\renewcommand{\umbcP@bgCommand}{#1}}

% number of columns
\ifthenelse{\lengthtest{\paperwidth<\paperheight}}
	{\newcommand{\umbcP@nCols}{3}}
	{\newcommand{\umbcP@nCols}{4}}
\pgfkeys{/umbcposter/columns/.value required}
\pgfkeys{/umbcposter/columns/.code={\renewcommand{\umbcP@nCols}{#1}}}

% column gap
\pgfkeys{/umbcposter/column gap/.value required}
\pgfkeys{/umbcposter/column gap/.code=\setlength{\umbcP@colGap}{#1}}

% row gap
\pgfkeys{/umbcposter/row gap/.value required}
\pgfkeys{/umbcposter/row gap/.code=\setlength{\umbcP@rowGap}{#1}}

% the grid
\newcommand{\umbcP@drawGrid}{\relax}
\pgfkeys{/umbcposter/grid/.default={draw=green!80!black, very thin}}
\pgfkeys{/umbcposter/grid/.code=\renewcommand{\umbcP@drawGrid}{
		\path [#1] (umbcp body.south west) rectangle (umbcp head.north east);
		\path [#1] (umbcp body.north west) -- (umbcp body.north east);
		% 
		\pgfmathadd{\umbcP@nCols}{-1}
		\foreach \i in {1,...,\pgfmathresult}
			\path [#1]
				(umbcp body.south west)
					++(\i\umbcP@colWidth,0) -- +(0,\umbcP@bHeight)
				(umbcp body.south west)
					++(\i\umbcP@colWidth - \umbcP@colGap,0)
					-- +(0,\umbcP@bHeight);
	}
}

% column separators
\newcommand{\umbcP@colSeptors}{\relax}
\pgfkeys{/umbcposter/column separators/.default={draw=blue, line width=1pt}}
\pgfkeys{/umbcposter/column separators/.code=\renewcommand{\umbcP@colSeptors}{
		\pgfmathadd{\umbcP@nCols}{1}
		\foreach \i in {0,...,\pgfmathresult}
			\path [#1] (umbcp body.south west)
				++(\i\umbcP@colWidth - 0.5\umbcP@colGap, 0)
				-- +(0,\umbcP@bHeight - 0.5\umbcP@boxTHeight);
	}
}

% poster head height
\pgfkeys{/umbcposter/head height/.value required}
\pgfkeys{/umbcposter/head height/.code=\setlength{\headheight}{#1}}

% simple default logo
\newcommand{\umbcP@defaultLogo}[1]{%
	\setlength{\fboxsep}{1.2em}%
	\fcolorbox{red}{white}{\Large\sl#1}}

% left logo
\newcommand{\umbcP@leftLogo}{}
\pgfkeys{/umbcposter/left logo/.default={%
	\umbcP@defaultLogo{left logo}
	\umbcP@defaultLogo{left logo}}}
\pgfkeys{/umbcposter/left logo/.code=\renewcommand{\umbcP@leftLogo}{#1}}

% right logo
\newcommand{\umbcP@rightLogo}{}
\pgfkeys{/umbcposter/right logo/.default={\umbcP@defaultLogo{right logo}}}
\pgfkeys{/umbcposter/right logo/.code=\renewcommand{\umbcP@rightLogo}{#1}}

% title alignment
\newcommand{\umbcP@titleAlign}{center}
\pgfkeys{/umbcposter/title align/.default={\umbcP@titleAlign}}
\pgfkeys{/umbcposter/title align/.code={\renewcommand{\umbcP@titleAlign}{#1}}}

% title
\newcommand{\umbcP@title}{\relax}
\pgfkeys{/umbcposter/title/.default={
	\setlength{\fboxsep}{1.2em}%
	\fcolorbox{red}{white}{\Large\sl Title, author, etc.}}}
\pgfkeys{/umbcposter/title/.code=\renewcommand{\umbcP@title}{#1}}

%--- Section 2b: Parse \posterinit's box config arguments  --------------------%

% upper left rounding
\tikzset{umbcp ul rounding/.style=sharp corners}
\pgfkeys{/umbcposter/box/upper left rounded/.code=
		\tikzset{umbcp ul rounding/.style={rounded corners=\umbcP@boxRadius}}}
\pgfkeys{/umbcposter/box/upper left sharp/.code=
		\tikzset{umbcp ul rounding/.style=sharp corners}}

% upper right rounding
\tikzset{umbcp ur rounding/.style=sharp corners}
\pgfkeys{/umbcposter/box/upper right rounded/.code=
		\tikzset{umbcp ur rounding/.style={rounded corners=\umbcP@boxRadius}}}
\pgfkeys{/umbcposter/box/upper right sharp/.code=
		\tikzset{umbcp ur rounding/.style=sharp corners}}

% lower left rounding
\tikzset{umbcp ll rounding/.style=sharp corners}
\pgfkeys{/umbcposter/box/lower left rounded/.code=
		\tikzset{umbcp ll rounding/.style={rounded corners=\umbcP@boxRadius}}}
\pgfkeys{/umbcposter/box/lower left sharp/.code=
		\tikzset{umbcp ll rounding/.style=sharp corners}}

% lower right rounding
\tikzset{umbcp lr rounding/.style=sharp corners}
\pgfkeys{/umbcposter/box/lower right rounded/.code=
		\tikzset{umbcp lr rounding/.style={rounded corners=\umbcP@boxRadius}}}
\pgfkeys{/umbcposter/box/lower right sharp/.code=
		\tikzset{umbcp lr rounding/.style=sharp corners}}

% all rounded
\pgfkeys{/umbcposter/box/all rounded/.style={
		/umbcposter/box/upper left rounded,
		/umbcposter/box/upper right rounded,
		/umbcposter/box/lower left rounded,
		/umbcposter/box/lower right rounded}}

% all sharp
\pgfkeys{/umbcposter/box/all sharp/.style={
		/umbcposter/box/upper left sharp,
		/umbcposter/box/upper right sharp,
		/umbcposter/box/lower left sharp,
		/umbcposter/box/lower right sharp}}

% box rounding radius
\pgfkeys{/umbcposter/box/rounding radius/.value required}
\pgfkeys{/umbcposter/box/rounding radius/.code=\setlength{\umbcP@boxRadius}{#1}}

% box header height
\pgfkeys{/umbcposter/box/header height/.value required}
\pgfkeys{/umbcposter/box/header height/.code=\setlength{\umbcP@boxTHeight}{#1}}

% box header font
\newcommand{\umbcP@boxheaderFont}{\large\sc}
\pgfkeys{/umbcposter/box/header font/.code=
	\renewcommand{\umbcP@boxheaderFont}{#1}}
\pgfkeys{/umbcposter/box/header font/.value required}

% box header font color
\newcommand{\umbcP@boxheaderFontColor}{black}
\pgfkeys{/umbcposter/box/header font color/.code=
	\renewcommand{\umbcP@boxheaderFontColor}{#1}}
\pgfkeys{/umbcposter/box/header font color/.value required}

% box umbcp box header align
\tikzset{umbcp box header align/.style={align=center}}
\tikzset{/umbcposter/box/header align/.default=center}
\pgfkeys{/umbcposter/box/header align/.code=
	\tikzset{umbcp box header align/.style={align=#1}}}

% box header style
\tikzset{umbcp box header style/.style={}}
\pgfkeys{/umbcposter/box/header style/.default={
	top color=blue!30, bottom color=blue!50, middle color=white}}
\pgfkeys{/umbcposter/box/header style/.code=
	\tikzset{umbcp box header style/.style={#1}}}

% box header separator
\tikzset{umbcp box separator style/.style={}}
\pgfkeys{/umbcposter/box/header separator/.default=box border style}
\pgfkeys{/umbcposter/box/header separator/.code=
	\tikzset{umbcp box separator style/.style={#1}}}

% box border style
\tikzset{umbcp box border style/.style={}}
\pgfkeys{/umbcposter/box/border style/.default={
	draw=blue, line width=1pt}}
\pgfkeys{/umbcposter/box/border style/.code=
	\tikzset{umbcp box border style/.style={#1}}}

% box body style, part 1
% 
% The default value of "/umbcposter/box/body style" is "{}",
% in which case the body is not "filled".  An unfilled body does
% not cast a shadow, therefore a "drop shadow" request should be
% ingnored if the style is "{}".  For this purpose, we need a way
% to query the value of the "body style" and check it against "{}".
% The following method was suggested by Christian Feuersaenger
% in the pgf mailing list.  We define an "empty style" and capture
% its value in \umbcP@theemptystyle.  Later, we will query the value of
% of "body style" and compare it against \umbcP@theEmptyStyle.

\tikzset{umbcp empty style/.style={}}
\pgfkeysgetvalue{/tikz/umbcp empty style/.@cmd}\umbcP@theEmptyStyle

% box body style, part 2
\tikzset{umbcp box body style/.style={}}
\pgfkeys{/umbcposter/box/body style/.default={
	left color=red, right color=yellow}}
\pgfkeys{/umbcposter/box/body style/.code=
	\tikzset{umbcp box body style/.style={#1}}}

% box shadow
% TikZ applies the following defaults to "drop shadow":
%      shadow scale=1, shadow xshift=.5ex, shadow yshift=-.5ex,
%      opacity=.5, fill=black!50, every shadow
% User specified "drop shadow" options do not reset it; they are appended
% to it.  The xshift and yshift, defined below, override the defaults.
\tikzset{umbcp drop shadow/.style={}}
\pgfkeys{/umbcposter/box/drop shadow/.default=
	{shadow xshift=0.7ex, shadow yshift=-0.7ex}}
\pgfkeys{/umbcposter/box/drop shadow/.code={
	\tikzset{umbcp drop shadow/.style={drop shadow={#1}}}}}

% box positioning
\pgfkeys{/umbcposter/col/.code=\renewcommand{\umbcP@col}{#1}}
\pgfkeys{/umbcposter/span/.code=\renewcommand{\umbcP@span}{#1}}
\pgfkeys{/umbcposter/name/.code=\renewcommand{\umbcP@boxname}{#1}}

\pgfkeys{/umbcposter/below of/.code=\def\umbcP@belowof{#1}}
\pgfkeys{/umbcposter/above of/.code=\def\umbcP@aboveof{#1}}

% "at top" and "at bottom" are aliases
% for "below of=top" and "above of=bottom"
\pgfkeys{/umbcposter/at top/.code=\def\umbcP@belowof{top}}
\pgfkeys{/umbcposter/at bottom/.code=\def\umbcP@aboveof{bottom}}

%--- Section 3: The \posterinit -----------------------------------------------%

% arg #1: poster configuration parameters
\newcommand{\posterinit}[1]{

	% declare registers to be used in each \boxit
	\newlength{\umbcP@bHeight}		% body height = textheight - headerheight
	\newlength{\umbcP@colWidth}		% column width
	\newlength{\umbcP@boxWidth}		% the "natural" box width

	\newsavebox{\umbcP@saveBox}		% contents of a box
	\newlength{\umbcP@boxHeight}	% the (variable) box height
	\newlength{\umbcP@boxDepth}		% and the depth

	% select default font according to \umbcP@mag
	\normalsize

	% parse command args
	\pgfkeys{/umbcposter/.cd,#1}

	% calculate the derived lengths
	\setlength{\umbcP@bHeight}{\textheight - \headheight}
	\setlength{\umbcP@boxWidth}{(\textwidth
		- \umbcP@nCols\umbcP@colGap + \umbcP@colGap)/\umbcP@nCols}
	\setlength{\umbcP@colWidth}{(\textwidth + \umbcP@colGap)/\umbcP@nCols}

	\begin{tikzpicture}[remember picture,overlay]

		% The rectangular node "umbc body" spans the poster's body
		\path (current page.south west)
			++(\marginwidth,\marginwidth) coordinate (umbcp tempa)
			+(\textwidth,\umbcP@bHeight) coordinate (umbcp tempb)
			node[inner sep=0pt, outer sep=0pt,
				fit=(umbcp tempa) (umbcp tempb)] (umbcp body) {};

		% The rectangular node "umbc head" spans the poster's head
		\path (current page.north west)
			++(\marginwidth,-\marginwidth) coordinate (umbcp tempa)
			+(\textwidth,-\headheight) coordinate (umbcp tempb)
			node[inner sep=0pt, outer sep=0pt,
				fit=(umbcp tempa) (umbcp tempb)] (umbcp head) {};

		\umbcP@paintbg
		\umbcP@bgCommand
		\umbcP@drawGrid
		\umbcP@colSeptors
		\umbcP@makePosterHeader

	\end{tikzpicture}
}

%--- Section 4: The \boxit ----------------------------------------------------%

% The macro \umbcP@getBoxPosition does several things:
% 1. Establises tikz coordinates (umbcp box nw) and (umbcp box se)
% that mark a box's northwest and southeast corners.
% 2. Establises the tikz coordinate (umbcp box hd)
% that marks the northwest corner box's body.
% 3. Fits a rectangular node to points(umbcp box nw) and (umbcp box se).
% The node will be used by other boxes to position themselves relative
% to this box.
\newcommand{\umbcP@getBoxPosition}{

	% one of "above of" or "below of" must be specified
	\ifthenelse{ \( \isundefined{\umbcP@aboveof}
				\AND \isundefined{\umbcP@belowof} \) }{
		\error{one of "above of" or "below of" should be specified}
	}{}

	% box's top and bottom edges lie on horizontal lines
	% through (umbcp tm) and (umbcp bm)

	\ifthenelse{\NOT \(	\isundefined{\umbcP@belowof}
				\OR \isundefined{\umbcP@aboveof} \) }{

		% both \umbcP@belowof and \umbcP@aboveof are specified
		% box stretches to fill the gap between the two

		\ifthenelse{\equal{\umbcP@belowof}{top}}{
			\path (umbcp body.north west) coordinate (umbcp tm);
		}{
			\path (\umbcP@belowof.south) +(0,-\umbcP@rowGap)
				coordinate (umbcp tm);
		}

		\ifthenelse{\equal{\umbcP@aboveof}{bottom}}{
			\path (umbcp body.south west) coordinate (umbcp bm);
		}{
			\path (\umbcP@aboveof.north) +(0,\umbcP@rowGap)
				coordinate (umbcp bm);
		}
	}{ \ifthenelse{\NOT\isundefined{\umbcP@belowof}}{

			% only "below of" is specified
			% box takes on its natural height

			\ifthenelse{\equal{\umbcP@belowof}{top}}{
				\path (umbcp body.north west) coordinate (umbcp tm);
			}{
				\path (\umbcP@belowof.south) +(0,-\umbcP@rowGap)
					coordinate (umbcp tm);
			}
			\path (umbcp tm) +(0,-\umbcP@boxHeight) coordinate (umbcp bm);
		}{

			% only "above of" is specified
			% box takes on its natural height

			\ifthenelse{\equal{\umbcP@aboveof}{bottom}}{
				\path (umbcp body.south west) coordinate (umbcp bm);
			}{
				\path (\umbcP@aboveof.north) +(0,\umbcP@rowGap)
					coordinate (umbcp bm);
			}
			\path (umbcp bm) +(0,\umbcP@boxHeight) coordinate (umbcp tm);
		}
	}

	% box's left edge lies on the vertical line through (umbcp lm)
	\path (umbcp body.north west)
		+(\umbcP@col\umbcP@colWidth,0) coordinate (umbcp lm);

	% (umbcp box nw) is the box's northwest, (umbcp box se) is the southeast
	% (umbcp box hd) is the northwest corner of box body
	\path (umbcp tm -| umbcp lm) coordinate (umbcp box nw);
	\path (umbcp bm -| umbcp lm) +(\umbcP@boxWidth,0) coordinate (umbcp box se);
	\path (umbcp box nw) +(0,-\umbcP@boxTHeight) coordinate (umbcp box hd);

	% fit a rectangular node to the points (umbcp box nw)
	% and (umbcp box se) and name the node \umbcP@boxname
	\node[inner sep=0pt, outer sep=0pt, fit=(umbcp box nw) (umbcp box se)]
		(\umbcP@boxname) {};
}

% arg #1: (optional) style modifications specific to this box
% arg #2: geometry specs
% arg #3: box title
% arg #4: box contents
\newcommand{\boxit}[4][]{{	% extra braces to ensure local scope

	\newcommand{\umbcP@col}{0}
	\newcommand{\umbcP@span}{1}
	\newcommand{\umbcP@boxname}{}
	\pgfkeys{/umbcposter/.cd, #1}	% style modifications specific to this box
	\pgfkeys{/umbcposter/.cd, #2}	% geometry specs

	% redefinition of \bodWidth is confined to the local scope
	\setlength{\umbcP@boxWidth}{\umbcP@span\umbcP@colWidth - \umbcP@colGap}

	% put contents in a minibox and save
	\sbox{\umbcP@saveBox}{%
		\begin{minipage}{\umbcP@boxWidth-2em}%
			\vspace*{\umbcP@boxTHeight}%
			\vspace*{1em}%
			#4%
			\vspace*{1em}%
		\end{minipage}%
	}

	% measure height
	\settoheight{\umbcP@boxHeight}{\usebox{\umbcP@saveBox}}
	\settodepth{\umbcP@boxDepth}{\usebox{\umbcP@saveBox}}
	\addtolength{\umbcP@boxHeight}{\umbcP@boxDepth}

	\begin{tikzpicture}[remember picture,overlay]

		\umbcP@getBoxPosition

		% paint box header and body
		\umbcP@renderBox

		% box body text
		\path (umbcp box nw) +(1em,0)
			node[inner sep=0pt, outer sep=0pt, below right] 
				{\usebox{\umbcP@saveBox}};

		% box header text
		\path (umbcp box hd) +(0.5\umbcP@boxWidth, 0.5\umbcP@boxTHeight)
				node[text width = \umbcP@boxWidth - 2em, umbcp box header align]
					{\color{\umbcP@boxheaderFontColor}\umbcP@boxheaderFont#3};

		% box border
		\path [umbcp box border style]
			(umbcp box nw)
			[umbcp ur rounding] -- (umbcp box nw -| umbcp box se)
			[umbcp lr rounding] -- (umbcp box se)
			[umbcp ll rounding] -- (umbcp box nw |- umbcp box se)
			[umbcp ul rounding] -- cycle;

		% header separator
		\path [umbcp box separator style] (umbcp box hd)
				-- +(\umbcP@boxWidth,0);

	\end{tikzpicture}
}}

\endinput

