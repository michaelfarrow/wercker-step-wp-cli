#!/bin/sh

WP_CLI_CACHE_DIR="$WERCKER_CACHE_DIR/weyforth/wpcli"
WP_CLI_CACHE_BIN="$WP_CLI_CACHE_DIR/wp"

mkdir -p "$WP_CLI_CACHE_DIR"

[ ! -f "$WP_CLI_CACHE_BIN" ] && \
  curl -o "$WP_CLI_CACHE_BIN" https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

cp "$WP_CLI_CACHE_BIN" /usr/local/bin/wp
chmod +x /usr/local/bin/wp

WP_CLI_USER=${WERCKER_WP_CLI_USER:-$WERCKER_WP_CLI_ENV_USER}
WP_CLI_DIR=${WERCKER_WP_CLI_DIR:-$WERCKER_WP_CLI_ENV_DIR}

WP_CLI_USER=${WP_CLI_USER:-root}
WP_CLI_DIR=${WP_CLI_DIR:-$WERCKER_ROOT}

[ "$WP_CLI_USER" != "root" ] && chsh -s /bin/sh "$WP_CLI_USER"

su -c "wp --allow-root --path=\"$WP_CLI_DIR\" $WERCKER_WP_CLI_CMD" - "$WP_CLI_USER"
