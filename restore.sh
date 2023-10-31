composer install
bin/console assets:install --symlink public
bin/console pimcore:deployment:classes-rebuild -c
bin/console cache:clear
bin/console cache:warmup