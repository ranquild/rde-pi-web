#!/usr/bin/env bash
# Logs the mb CLI in to Metabase with the API key created from config.yml, and
# sets pi's default model.
set -euo pipefail

: "${MB_URL:?}" "${MB_API_KEY:?}" "${PI_DEFAULT_MODEL:?}"

# Pipe the key so mb never falls back to an interactive prompt.
printf '%s' "$MB_API_KEY" | mb auth login --url "$MB_URL" >/dev/null
echo "mb CLI logged in to $MB_URL."

# Compose passes every provider key; drop the empty ones so pi only offers the
# providers you configured.
for var in ANTHROPIC_API_KEY OPENAI_API_KEY OPENROUTER_API_KEY GEMINI_API_KEY; do
  [ -n "${!var:-}" ] || unset "$var"
done

# PI_DEFAULT_MODEL is provider/model; keep any other settings made in the UI.
settings=~/.pi/agent/settings.json
[ -f "$settings" ] || echo '{}' > "$settings"
jq --arg provider "${PI_DEFAULT_MODEL%%/*}" --arg model "${PI_DEFAULT_MODEL#*/}" \
  '.defaultProvider = $provider | .defaultModel = $model' "$settings" > "$settings.tmp"
mv "$settings.tmp" "$settings"

exec "$@"
