FROM debian

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
    pandoc \
    fontconfig \
    lmodern \
    inkscape pdf2svg make
WORKDIR /usr/local
#Install plantuml and chamilotools
RUN apt-get install -y git python-pip plantuml\
    && git clone https://gitlab.com/chamilotools/chamilotools.git \
    && pip install -r chamilotools/requirements.txt \
    && pip install pandocfilters \
    && pip install pandoc-plantuml-filter \
    && pip install sphinx recommonmark \
    && pip install mkdocs \
    && ln -s /usr/local/chamilotools/chamilotools /usr/local/bin/chamilotools
USER nobody
WORKDIR /source
ENV TEXINPUTS :./ThemeBeamer
