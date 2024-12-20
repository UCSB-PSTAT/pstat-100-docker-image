FROM ucsb/rstudio-base:latest

LABEL maintainer="LSIT Systems <lsitops@lsit.ucsb.edu>"

USER root

RUN apt-get update && \
    apt-get install -y texlive-full lmodern texlive-latex-extra texlive-fonts-recommended cm-super nano && \
    apt-get clean

RUN pip install datascience \
    ipympl \
    jsonschema \
    otter-grader \
    nb2pdf \
    PTable \
    pytest-custom-report \
    scipy \
    scikit-learn \
    vdiff \
    zipfile38 \
    pydot \
    plotly \
    graphviz \
    seaborn \
    statsmodels \
    xgboost \
    Scrapy \
    tensorflow \
    keras \
    bokeh

# Jupyter Extensions
RUN conda install -c conda-forge jupyter_contrib_nbextensions && \
    jupyter nbextension enable toc2/main --sys-prefix && \
    jupyter nbextension enable toggle_all_line_numbers/main --sys-prefix && \
    jupyter nbextension enable table_beautifier/main --sys-prefix

RUN conda install -c conda-forge nodejs \
        altair \
        hypothesis \
        nltk \
        mock \
        mplcursors  \
        pytest  \
        spacy \
        tweepy \
        vega_datasets

# Install Pytorch via conda with CPU resources (no cuda in GCP) 
RUN conda install pytorch torchvision torchaudio cpuonly -c pytorch

# Install R Packages
RUN R -e "install.packages(c('ggthemes', 'gridExtra', 'kableExtra', 'pander', 'ottr', 'reshape2', 'tidybayes'), repos = 'https://cloud.r-project.org/', Ncpus = parallel::detectCores())"

USER $NB_USER
