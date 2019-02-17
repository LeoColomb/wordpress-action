#!/bin/sh

set -e

TAG=${GITHUB_REF##*/}
WORDPRESS_PLUGIN=${WORDPRESS_PLUGIN:-${GITHUB_REPOSITORY##*/}}
WORDPRESS_TYPE=${WORDPRESS_TYPE:-plugin}s

# Extract Git repository as an archive file
git archive --format=tar --prefix="archive-${TAG}/" "${TAG}" | (cd /tmp/ && tar xf -)
cd "/tmp/archive-${TAG}/"

# Install dependencies
if [ -f "composer.json" ] then
  composer install --no-dev --optimize-autoloader
fi

# Setup SVN repository
svn co "https://${WORDPRESS_TYPE}.svn.wordpress.org/${WORDPRESS_PLUGIN}/" /tmp/wordpress-svn

# Remove extra artifacts
rsync -Rrd --delete ./ /tmp/wordpress-svn/trunk/
cd /tmp/wordpress-svn/
svn status | grep '^!' | awk '{print $2}' | xargs -I x svn rm --force x@

# Add new files
svn add --force * --auto-props --parents --depth infinity

# Create the tag
mkdir "/tmp/wordpress-svn/tags/${TAG}""
svn add "/tmp/wordpress-svn/tags/${TAG}""
svn cp --parents trunk/* "tags/${TAG}"

# Push the commit
svn ci --no-auth-cache --username "${WORDPRESS_USERNAME}" --password "${WORDPRESS_PASSWORD}" -m "v${TAG}"
