#!/usr/bin/env bash
set -x
SCRIPT_DIRECTORY=$(cd "$(dirname "$0")" && pwd)
COPYBARA_JAR=$SCRIPT_DIRECTORY/bin/copybara_deploy.jar
RESULT_REPOSITORY_URL="file://$SCRIPT_DIRECTORY/result"

# make sure to start from scratch every time
rm -rf "$SCRIPT_DIRECTORY/result"
rm -rf "$SCRIPT_DIRECTORY/working-copy"

# initialize the local destination repository and checkout a working copy
mkdir result && pushd result && git init --bare . && popd || exit
git clone "$RESULT_REPOSITORY_URL" working-copy

# take all the commits made before the guilded-rose branch was created
# - remove the unrelated code
# - squash all the commits into a single one
java -jar "$COPYBARA_JAR" migrate copy.bara.sky \
--validate-starlark STRICT \
--init-history \
--git-destination-url "$RESULT_REPOSITORY_URL" \
--force-message "Initial project setup" \
--force \
initial-import

# the dependencies in package.json are updated now generate a new yarn.lock
pushd working-copy && git pull && yarn && git add yarn.lock && git commit --amend --no-edit && git push --force && popd || exit

# apply all the commits made during the kata commit by commit
java -jar "$COPYBARA_JAR" migrate copy.bara.sky \
--validate-starlark STRICT \
--git-destination-url "$RESULT_REPOSITORY_URL" \
guilded-rose

git -C working-copy pull
