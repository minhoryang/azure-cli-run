FROM mcr.microsoft.com/azure-cli:2.3.1

COPY pipe /
RUN chmod a+x /*.sh

ENTRYPOINT ["/pipe.sh"]
