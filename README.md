# Authy

Sinatra-based auth API, for fun. Uses Falcon as the app server. Dev environment uses Zeitwerk for autoloading and `rerun` for hot reload.

## Requirements

- Ruby 3.x
- Bundler
- PostgreSQL
- Redis (maybe)
- Falcon (included in Gemfile)

## Endpoints

| HTTP Method & Path                      | Description                     | Module        |
| --------------------------------------- | ------------------------------- | ------------- |
| `POST /oauth/token`                     | access tokens (login)           | oauth         |
| `POST /oauth/revoke`                    | kills tokens (logout)           | oauth         |
| `GET /userinfo`                         | user info (OIDC)                | oauth         |
| `GET /.well-known/jwks.json`            | JWKS publ keys jto validate JWT | well_known    |
| `GET /.well-known/openid-configuration` | OIDC manifest (maybe..)         | well_known    |
| `POST /registrations`                   | create a user                   | registrations |
| `POST /passwords`                       | trigger password reset          | passwords     |
| `PUT /passwords`                        | udpate password (verify token)  | passwords     |
| `POST /confirmations`                   | verifies a token (email, etc.)  | confirmations |
| `PUT /users/:id`                        | update user                     | users         |
| `DELETE /users/:id`                     | deactivate a user               | users         |

## Data Flow (First Pass)

1. User enters email/password in frontend (client)
2. Client sends POST /token with:
   - grant_type=password
   - client_id + client_secret
   - username + password
3. Authy server verifies:
   - client (via `oauth_clients`)
   - user (via `users`)
4. If valid, server returns:
   - access_token (JWT w/ jti)
   - refresh_token (UUID? Maybe, or JWT)
5. Client uses access_token in Authorization header
6. API server verifies JWT, checks revocation

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
