FROM node:22-bookworm-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl git jq ripgrep \
 && rm -rf /var/lib/apt/lists/*

# pi-web bundles the pi coding agent.
RUN npm install -g @agegr/pi-web @metabase/cli \
 && npm cache clean --force

COPY init.sh /usr/local/bin/init.sh

RUN mkdir -p /workspace /home/node/.pi/agent/sessions \
 && chown -R node:node /workspace /home/node/.pi
USER node
WORKDIR /workspace

RUN npx -y skills add metabase/agent-skills --skill metabase-cli --agent pi --global --copy --yes

ENV MB_URL=http://metabase:3000 \
    MB_CLI_DISABLE_KEYRING=1 \
    PORT=30141 \
    PI_WEB_HOSTNAME=0.0.0.0 \
    PI_WEB_NO_OPEN=1 \
    PI_WEB_SKIP_VERSION_CHECK=1 \
    PI_SKIP_VERSION_CHECK=1 \
    PI_TELEMETRY=0

EXPOSE 30141
ENTRYPOINT ["/usr/local/bin/init.sh"]
CMD ["pi-web"]
