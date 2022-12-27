FROM ucsb/jupyter-base:latest

LABEL maintainer="LSIT Systems <lsitops@lsit.ucsb.edu>"

USER root

RUN pip install datascience \
    ipympl \
    jsonschema \
    otter-grader \
    nb2pdf \
    PTable \
    pytest-custom-report \
    scikit-learn \
    vdiff \
    zipfile38  

RUN \
    # Jupyter Extensions
    conda install -c conda-forge jupyter_contrib_nbextensions && \
    jupyter nbextension enable toc2/main --sys-prefix && \
    jupyter nbextension enable toggle_all_line_numbers/main --sys-prefix && \
    jupyter nbextension enable table_beautifier/main --sys-prefix && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-matplotlib --clean 

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
