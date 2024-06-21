FROM rstudio/plumber
COPY api.R /
EXPOSE 80/tcp
CMD ["/api.R"]
