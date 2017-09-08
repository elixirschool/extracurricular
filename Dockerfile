FROM elixir:1.5

MAINTAINER Sean Callan <sean@seancallan.com>

RUN \
  /usr/local/bin/mix local.hex --force && \
  /usr/local/bin/mix local.rebar --force && \
  /usr/local/bin/mix hex.info

RUN \
  wget -qO- https://deb.nodesource.com/setup_7.x | bash - && \
  apt-get install nodejs

WORKDIR /app
COPY . .
RUN mix deps.get
RUN \
  cd apps/web/assets && \
  npm install && \
  npm install node-sass && \
  node_modules/brunch/bin/brunch b -p && \
RUN cd /app/apps/web && mix phx.digest

CMD ["bash"]
