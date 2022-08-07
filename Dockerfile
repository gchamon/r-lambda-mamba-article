FROM public.ecr.aws/lambda/python:3.9

# install R
ENV R_VERSION=4.2.1

RUN yum -y install \
      wget \
      git \
      tar \
      bzip2 \
  && yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
  && wget https://cdn.rstudio.com/r/centos-7/pkgs/R-${R_VERSION}-1-1.x86_64.rpm \
  && yum -y install R-${R_VERSION}-1-1.x86_64.rpm \
  && rm R-${R_VERSION}-1-1.x86_64.rpm \
  && yum clean all \
  && rm -rf /var/cache/yum

ENV PATH="${PATH}:/opt/R/${R_VERSION}/bin/"

# install micromamba
ENV MICROMAMBA_VERSION=0.25.0
ENV MICROMAMBA_INSTALL_FOLDER=/opt/micromamba
ENV PATH="$MICROMAMBA_INSTALL_FOLDER/bin:${PATH}"

RUN mkdir --parents $MICROMAMBA_INSTALL_FOLDER \
    && curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/$MICROMAMBA_VERSION | \
        tar -xvj --directory $MICROMAMBA_INSTALL_FOLDER bin/micromamba \
    && micromamba shell init -s bash -p $MICROMAMBA_INSTALL_FOLDER/env \
    && echo micromamba activate >> ~/.bashrc \
    && cp ~/.bashrc $MICROMAMBA_INSTALL_FOLDER

# install R dependencies with micromamba
COPY dependencies.R ${LAMBDA_TASK_ROOT}
RUN source $MICROMAMBA_INSTALL_FOLDER/.bashrc \
    && micromamba install --channel anaconda --channel conda-forge --channel r \
        r-argparse \
    && micromamba clean --all \
    && Rscript "${LAMBDA_TASK_ROOT}/dependencies.R"

# add the lambda handler code
COPY . ${LAMBDA_TASK_ROOT}

CMD ["lambda_handler.handler"]

