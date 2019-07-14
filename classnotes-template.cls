%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% +-----------------------------------------------+ %
% |                                               | %
% |                  R3nt0n.class                 | %
% |                                               | %
% +-----------------------------------------------+ %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ProvidesClass{borjaDocs}[2018/03/12 R3nt0n document class]
\NeedsTeXFormat{LaTeX2e}

% -------------------------------------------------
% --------- Heredar opciones de reporte -----------
% -------------------------------------------------
\DeclareOption*{%
	\PassOptionsToClass{\CurrentOption}{report}
}
\ProcessOptions\relax
\LoadClass{report}


% -------------------------------------------------
% ------------- Paquetes necesarios ---------------
% -------------------------------------------------
\RequirePackage[utf8]{inputenc}	          % Codificacion UTF8
\RequirePackage[spanish]{babel}            % Convenciones del idioma español
\RequirePackage[T1]{fontenc}               % Uso de fuentes T1 (vectoriales)
\RequirePackage{lmodern}		             % Carga tipografía lmodern (Latin Modern)
\RequirePackage[scale=1]{ccicons}          % Iconos de CreativeCommons
\RequirePackage{minted}			             % Resaltar código fuente
\RequirePackage{geometry}                  % Manipular tamaño de hoja y márgenes
\RequirePackage{fancyhdr}                  % Cabeceras y pies de página
\RequirePackage{titlesec}                  % Cambiar estructura de títulos
\RequirePackage[tocflat]{tocstyle}         % Formateo de índices
\RequirePackage[hidelinks]{hyperref}       % Formateo de enlaces
\RequirePackage{caption}                   % Formateo de captions
\RequirePackage{subcaption}                % Formateo de subcaptions
\RequirePackage{graphicx}                  % Insertar figuras
\RequirePackage{float}                     % Las figuras permanecen dónde se han insertado
\RequirePackage[none]{hyphenat}            % Evita que corte palabras, justificando texto


% -------------------------------------------------
% ---------- Cabeceras y pies de página -----------
% -------------------------------------------------
\makeatletter
   \let\titleHeader\@title
   \let\authorHeader\@author
\makeatother

\fancypagestyle{normal}{
   \fancyheadoffset{0pt}
   
	\lhead{\footnotesize \textit{\titleHeader}}
	\chead{}
	\rhead{\footnotesize \textit{\authorHeader}}
	\renewcommand{\headrulewidth}{0.4pt}
	
	\lfoot{\footnotesize \textit{Page \thepage}}
	\cfoot{}
	\rfoot{\footnotesize \textit{Creative Commons 4.0}  \ccbyncsa}
	\renewcommand{\footrulewidth}{0.4pt}
}

% Estilo para páginas dónde arranca un capítulo (mantiene footer pero vacía el header)
\fancypagestyle{plain}{
	\lhead{}
	\chead{}
	\rhead{}
	\renewcommand{\headrulewidth}{0pt}
}

\pagestyle{normal}       % Aplica el estilo normal de header/footer


% -------------------------------------------------
% ----------- Tamaño de hoja y márgenes -----------
% -------------------------------------------------
\geometry{
	a4paper,           % Tamaño de hoja
	left=30mm,         % Margen izquierdo
	right=30mm,        % Margen derecho
	top=30mm,          % Margen superior
	bottom=25mm,       % Margen inferior
	footskip=10mm,     % Margen entre baseline del texto y baseline del footer
   footnotesep=1.3cm  % Margen entre texto y línea de footnotes
}
%\textheight 24.0cm     % Altura que ocupará el contenido
%\textwidth 15.25cm     % Anchura que ocupará el contenido


% -------------------------------------------------
% ------------ Configuración de párrafos ----------
% -------------------------------------------------
\renewcommand{\baselinestretch}{1}  % Separación entre líneas
\parskip 2.5ex                         % Separación entre párrafos
\parindent=0pt                         % Sangría primera línea

% -------------------------------------------------
% ----------- Configuración de tipografía ---------
% -------------------------------------------------
\renewcommand{\familydefault}{lmr}  % Cambiar tipografía por defecto


% -------------------------------------------------
% -------------- Formato de ÍNDICE ----------------
% -------------------------------------------------
\usetocstyle{standard}

% Redefinition of ToC command
\makeatletter
\renewcommand\tableofcontents{%
	\null\hfill\textbf{\Large\contentsname { Table}}\hfill\null\par     % Título de índice
	\@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}%
	\@starttoc{toc}%
}
\makeatother


% -------------------------------------------------
% ------------ Formato de CAPÍTULOS ---------------
% -------------------------------------------------
\titleformat{\chapter}[display]     % Display es lo que permite salto de línea
	{\mdseries \Large}              % Formato por defecto
	{Capítulo \Large\thechapter }   % Formato del número de capítulo
	{0pt}                           % Separación por encima de línea
	{\titlerule                     % Línea de separación
	 \vspace{0pt}%                  % Separación por debajo de línea
	 \bfseries\huge \filcenter}     % Formato texto de capítulo


% -------------------------------------------------
% ------------ Formato de SECCIONES ---------------
% -------------------------------------------------
\titlespacing{\section}{0pt}{3ex}{0.2ex} % {margin-left}{space-before}{space-after}
\titleformat{\section}
	{\bfseries \Large}       
	{\thesection. }                 % Formato del número de sección
	{8pt}                           % Separación
	{\bfseries \Large}                        % Formato texto de sección


% -------------------------------------------------
% ------------- Formato de ENLACES ----------------
% -------------------------------------------------
\hypersetup{
	breaklinks=true,
	colorlinks=true,
	linkcolor=black,
	filecolor=magenta,      
	urlcolor=blue,
}


% -------------------------------------------------
% -------- Formato de LISTAS DESORDENADAS ---------
% -------------------------------------------------
%\RequirePackage{mathabx}
%\renewcommand{\labelitemi}{$\bullet$}
%\renewcommand{\labelitemii}{$\circ$}
%\renewcommand{\labelitemiii}{$\sqbullet$}
%\renewcommand{\labelitemiv}{$\square$}


% -------------------------------------------------
% ---- Formato de CAPTIONS (texto de figuras) -----
% -------------------------------------------------
\captionsetup[figure]{
   width=0.9\linewidth, % width of caption is 90% of current textwidth
   %labelfont=bf,        % the label, e.g. figure 12, is bold
   font=scriptsize,          % the whole caption text (label + content) is small
   format=hang,         % no caption text under the label
}
\captionsetup[subfigure]{
   format=plain,   % but allowed in subfigure to save space
}


% -------------------------------------------------
% ----------- COMANDOS PERSONALIZADOS -------------
% -------------------------------------------------

% -------------------------------------------------
% Comando para insertar una figura:
%
% \figura{nombre-fichero}{argumentos}{título}{etiqueta}
%
% argumentos: width=Xcm,height=Ycm,angle=Z
% "La figura~\ref{etiqueta} muestra..." permite referenciar la figura desde el texto.

\newcommand{\figura}[4]{
   \begin{figure}[H]
      \begin{center}
         \vspace{2.5ex} % Espacio antes de la figura
         \includegraphics[#2]{#1}
         \vspace{-4ex} % Espacio después de la figura
         \caption{#3}
         \label{#4}
      \end{center}
   \end{figure}  
}
% -------------------------------------------------