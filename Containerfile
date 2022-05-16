FROM ucsb/jupyter-base:latest

LABEL maintainer="LSIT Systems <lsitops@lsit.ucsb.edu>"

USER root

RUN pip install datascience \
    ipympl \
    jsonschema==3.2.0 \
    otter-grader \
    nb2pdf \
    PTable \
    pytest-custom-report \
    scikit-learn \
    vdiff \
    zipfile38  

RUN \
    # Jupyter Extensions
    pip install jupyter_contrib_nbextensions && \
    jupyter contrib nbextension install --sys-prefix && \
    jupyter nbextension enable toc2/main --sys-prefix && \
    jupyter nbextension enable toggle_all_line_numbers/main --sys-prefix && \
    jupyter nbextension enable table_beautifier/main --sys-prefix && \
    jupyter nbextension install jupyter_nbextensions_configurator --py --sys-prefix && \
    jupyter nbextensions_configurator disable --sys-prefix && \
    jupyter serverextension enable jupyter_nbextensions_configurator --sys-prefix && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-matplotlib@0.7.2 --clean 

RUN mamba install -c conda-forge nodejs \
        altair \
        hypothesis \
        nltk \
        mock \
        mplcursors  \
        pytest  \
        spacy \
        tweepy \
        vega_datasets

USER $NB_USER
