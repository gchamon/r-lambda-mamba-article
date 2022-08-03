FROM public.ecr.aws/lambda/python:3.9

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

# the lambda handler
COPY lambda.py ${LAMBDA_TASK_ROOT}

CMD ["lambda.handler"]

