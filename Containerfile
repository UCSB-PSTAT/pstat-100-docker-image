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

RUN conda install -y nodejs \
        altair \
        cmdstan \
        hypothesis \
        nltk \
        mock \
        mplcursors  \
        pytest  \
        r::r-bayesrules \
	r-ggdist \
	r-ggthemes \
        r-gam \
        r-glmnet \
        r-kableextra \
        r-pander \
        r-umap \
        r-tidybayes \
        spacy \
        tweepy \
        vega_datasets

# Install Pytorch via conda with CPU resources (no cuda in GCP) 
RUN conda install pytorch torchvision torchaudio cpuonly -c pytorch

# Install R Packages
RUN R -e "install.packages(c('pander', 'ottr', 'tidybayes'), repos = 'https://cloud.r-project.org/', Ncpus = parallel::detectCores())"

# Install all the deps for rethinking

RUN chown -Rf jovyan /opt/conda/bin/cmdstan && \ 
    R -e "install.packages(c('cmdstanr'), repos = 'https://mc-stan.org/r-packages/', Ncpus = parallel::detectCores())" && \
    R -e "install.packages(c('tidybayes', 'rstanarm', 'coda', 'mvtnorm', 'devtools', 'loo', 'dagitty', 'shape'), repos = 'https://cloud.r-project.org/', Ncpus = parallel::detectCores())" && \
    R -e "devtools::install_github('rmcelreath/rethinking')" 

ENV CMDSTAN /opt/conda/bin/cmdstan

RUN /usr/bin/echo -e 'CMDSTAN=/opt/conda/bin/cmdstan\nCMDSTANR_NO_VER_CHECK=TRUE' > /etc/skel/.Renviron

USER $NB_USER
