# Husky challenge

https://husky-challenge-api.herokuapp.com

*It's a free dyno, it can sleep. Redis is free too, so we have just 30MB.

## Requirements

https://github.com/husky-misc/code-challenge-p2

## Run app
```
docker-compose build
docker-compose up
```

## Run specs
```
bundle exec rspec
```

## Deploy

1. Build image `docker build -t lekaverta-husky-challenge .`
2. Deploy image
3. Sets ambient variables:
- REDIS_URL (Address from Redis)
