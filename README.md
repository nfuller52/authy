# Authy

Sinatra-based auth API, for fun. Uses Falcon as the app server. Dev environment uses Zeitwerk for autoloading and `rerun` for hot reload.

## Requirements

- Ruby 3.x
- Bundler
- PostgreSQL
- Redis (eventually)
- Falcon (included in Gemfile)

## Getting Started

Install deps:

```bash
bundle install
```

Run the dev server:

```bash
bin/dev
```

## Use direnv, googles it

```bash
cp .env.local.sample .env.local
```

```bash
direnv allow
```

## Dev command helpers

```bash
bundle exec rubocop
bundle exec brakeman
bundle exec bundler-audit check --update
bundle exec reek
bundle exec fasterer
```

## Patterns

Request lifecycle...

rack -> middleware -> routes -> formatters -> module service -> module serializer -> renderers

- **Middleware** can modify or wrap the rack env before Sinatra sees it
- **Formatters** handle input normalization (camelCase to snake_case, "true" to true, etc)
- **Services** live in modules and do the actual work
- **Serializers** handle type casting for inputs and field selection for outputs
- **Renderers** run last and apply output transformations (snake_case to camelCase etc)
