FROM debian
MAINTAINER Sebastien Viardot <Sebastien.Viardot@grenoble-inp.fr>

#Install pandoc and latex package
RUN apt-get update -y \
   && apt-get install -y \
    texlive-latex-base \
    texlive-xetex  \
    texlive-science texlive-science-doc \
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
RUN apt-get install -y git python-pip python3-pip plantuml python3
RUN pip install pandocfilters \
    && pip install pandoc-plantuml-filter \
    && pip3 install sphinx recommonmark \
    && pip3 install mkdocs plantuml-markdown
#Install libre office pour les conversion odp vers pdf
RUN apt-get install -y wget \
    && cd /tmp \
    && wget https://ftp.igh.cnrs.fr/pub/tdf/libreoffice/stable/6.4.5/deb/x86_64/LibreOffice_6.4.5_Linux_x86-64_deb.tar.gz \
    && tar xvzf LibreOffice_6.4.5_Linux_x86-64_deb.tar.gz \
    && cd LibreOffice_6.4.5.2_Linux_x86-64_deb/DEBS && dpkg -i *.deb
RUN git clone https://gitlab.com/chamilotools/chamilotools.git \
    && pip install -r chamilotools/requirements.txt\
    && ln -s /usr/local/chamilotools/chamilotools /usr/local/bin/chamilotools
RUN apt-get install -y hugo
RUN apt-get update && apt-get install -y default-jdk
RUN apt install -y texlive-pstricks rsync
RUN pip3 install pymdown-extensions
#RUN apt install -y openjdk-8-jdk
RUN wget https://javadl.oracle.com/webapps/download/GetFile/1.8.0_261-b12/a4634525489241b9a9e1aa73d9e118e6/linux-i586/jdk-8u261-linux-x64.tar.gz -O jdk-8u261-linux-x64.tar.gz -O /tmp/jdk1.8.tar.gz
RUN mkdir -p /opt/jdk && tar xzf /tmp/jdk1.8.tar.gz -C/opt/jdk
RUN apt install -y librsvg2-bin
RUN pip install pandoc-latex-environment
USER nobody
WORKDIR /source
ENV TEXINPUTS :./ThemeBeamer
