# Metabase + Pi (web UI)

[Pi](https://pi.dev) coding agent with the [Pi Web](https://github.com/agegr/pi-web) UI.

Setup:

1. Copy the env file:
   ```sh
   cp .env.example .env
   ```
2. Set `PI_DEFAULT_MODEL` (`provider/model`, e.g. `anthropic/claude-opus-5-5`,
   `openai/gpt-5`, `openrouter/<provider>/<model>`, `google/gemini-2.5-pro`),
   paste the API key for that provider, and a Metabase Pro/Enterprise token into
   `MB_PREMIUM_EMBEDDING_TOKEN`.
   Optionally replace `MB_API_KEY` with your own: `echo "mb_$(openssl rand -base64 32)"`.
3. Start the stack:
   ```sh
   docker compose up -d --build
   ```
4. Open http://127.0.0.1:3000 for Metabase (`admin@example.com` /
   `metasample123`), and http://127.0.0.1:30141 for Pi.
5. In Pi Web, select `/workspace` as the working directory.

Switch models in Pi Web's Models panel.

Stop with `docker compose down` (add `-v` to wipe Metabase, the workspace and Pi sessions).
