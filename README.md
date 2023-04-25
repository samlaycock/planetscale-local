# Planetscale Local

This repostiroy contains a contrived implementation of
[Planetscale's DatabaseJS](https://github.com/planetscale/database-js) HTTP API.
It is intended for local development and testing **only**, should **should not**
be used in production or production-like environments.

## Usage

To use Planetscale Local, include it in your `docker-compose.yml` file:

```yaml
#...

services:
  #...
  # Planetscale local
  planetscale:
    image: cloudmix/planetscale-local:latest
    container_name: planetscale_local
    hostname: planetscale-local
    ports:
      - 3000:8080
    environment:
      - MYSQL_URL=mysql://planetscale:planetscale@mysql:3306/planetscale
      - PORT=8080
  # MYSQL
  mysql:
    image: mysql:8.0.32
    container_name: mysql
    hostname: mysql
    environment:
      - MYSQL_ROOT_PASSWORD=planetscale
      - MYSQL_DATABASE=planetscale
      - MYSQL_USER=planetscale
      - MYSQL_PASSWORD=planetscale
#...
```

The container expects a `MYSQL_URL` environment variable to be set. This can be
any MYSQL connection URL. You can also optionally set the `PORT` environment
variable to set the port the server will listen on. The default is `8080`.
