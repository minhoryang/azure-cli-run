FROM mcr.microsoft.com/azure-cli:2.53.0

RUN wget --no-verbose -P / https://bitbucket.org/bitbucketpipelines/bitbucket-pipes-toolkit-bash/raw/0.6.0/common.sh

COPY pipe /
RUN chmod a+x /*.sh
COPY LICENSE.txt README.md pipe.yml /

ENTRYPOINT ["/pipe.sh"]

