FROM mcr.microsoft.com/azure-cli:2.3.1

RUN wget -P / https://bitbucket.org/bitbucketpipelines/bitbucket-pipes-toolkit-bash/raw/0.4.0/common.sh

COPY pipe /
RUN chmod a+x /*.sh
COPY LICENSE.txt README.md pipe.yml /

ENTRYPOINT ["/pipe.sh"]
