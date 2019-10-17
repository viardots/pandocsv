FROM debian:stretch

MAINTAINER Sebastien Viardot <Sebastien.Viardot@grenoble-inp.fr>

#Install pandoc and latex package
RUN apt-get update -y \
   && apt-get install -y \
    texlive-latex-base \
    texlive-xetex latex-xcolor \
    texlive-math-extra \
    texlive-latex-extra \
    texlive-fonts-extra \
    texlive-bibtex-extra \
    texlive-latex-recommended \
    texlive-lang-french \
    latexmk \
    latex-mk \
    latex-make \
    pandoc  \
    fontconfig \
    lmodern \
    inkscape pdf2svg make
WORKDIR /usr/local
#Install plantuml and chamilotools
RUN apt-get install -y git python-pip plantuml python3
RUN pip install pandocfilters \
    && pip install pandoc-plantuml-filter \
    && pip install sphinx recommonmark \
    && pip install mkdocs
#Install libre office pour les conversion odp vers pdf
RUN apt-get install -y wget \
    && cd /tmp \
    && wget http://mirror.in2p3.fr/ftp/tdf/libreoffice/stable/6.3.1/deb/x86_64/LibreOffice_6.3.1_Linux_x86-64_deb.tar.gz \
    && tar xvzf LibreOffice_6.3.1_Linux_x86-64_deb.tar.gz \
    && cd LibreOffice_6.3.1.2_Linux_x86-64_deb/DEBS && dpkg -i *.deb
RUN git clone https://gitlab.com/chamilotools/chamilotools.git \
    && pip install -r chamilotools/requirements.txt\
    && ln -s /usr/local/chamilotools/chamilotools /usr/local/bin/chamilotools
RUN apt-get install -y hugo
USER nobody
WORKDIR /source
ENV TEXINPUTS :./ThemeBeamer
