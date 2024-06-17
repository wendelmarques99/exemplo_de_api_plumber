FROM rocker/r-ver:4.1.0
RUN apt-get update \
  && apt-get install -y --no-install-recommends libmariadbclient-dev
RUN apt-get update && apt-get install -y  git-core libcairo2-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev libharfbuzz-dev libfribidi-dev libcurl4-openssl-dev libgit2-dev libglpk-dev libgmp-dev libicu-dev libssl-dev libxml2-dev make pandoc pandoc-citeproc zlib1g-dev && rm -rf /var/lib/apt/lists/*
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl', Ncpus = 4)" >> /usr/local/lib/R/etc/Rprofile.site
RUN R -e 'install.packages("remotes")'
RUN mkdir /build_zone
ADD . /build_zone
WORKDIR /build_zone
RUN R -e "remotes::install_version('htmlwidgets', version = '1.6.2', repos = 'http://cran.rstudio.com/')"
RUN R -e "remotes::install_version('crosstalk', version = '1.2.0', repos = 'http://cran.rstudio.com/')"
RUN R -e 'remotes::install_local(upgrade="never")'
RUN rm -rf /build_zone
EXPOSE 80
CMD R -e "options('golem.app.prod' = TRUE, 'shiny.port'=80, shiny.host='0.0.0.0', auth0_config_file = system.file('app/_auth0.yml', package = 'PortalDapes'));PortalDapes::run_app_auth0()"
