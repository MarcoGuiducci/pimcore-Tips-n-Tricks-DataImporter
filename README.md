# Pimcore Tips-N-Tricks: Project setup
This folder conatains a ready to go docker compose file. Just navigate to this folder and type:

```
docker-compose up -d
# open a second shell
docker-compose exec php bash restore.sh
```

This script automatically restore vendor packages, install assets and perform a cache warmup.
This also provide an already configured database with some data.

Credential for pimcore admin are `pimcore/pimcore`.