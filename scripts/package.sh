#!/usr/bin/env bash
##################################################
# This shell script is executed by nx-release.js #
##################################################

NX_VERSION=$1
ANGULAR_CLI_VERSION=$2
TYPESCRIPT_VERSION=$3
PRETTIER_VERSION=$4

if [[ $NX_VERSION == "--local" ]]; then
    NX_VERSION="*"
fi

rm -rf build
npx nx run-many --target=build --all --parallel || { echo 'Build failed' ; exit 1; }

cd build/packages

if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i "" "s|exports.nxVersion = '\*';|exports.nxVersion = '$NX_VERSION';|g" {react,next,gatsby,web,jest,node,linter,express,nest,cypress,storybook,angular,workspace,nx-plugin,react-native,detox}/src/utils/versions.js
    sed -i "" "s|\*|$NX_VERSION|g" {react,next,gatsby,web,jest,node,express,nest,cypress,storybook,angular,workspace,cli,linter,tao,devkit,eslint-plugin-nx,create-nx-workspace,create-nx-plugin,nx-plugin,react-native,detox}/package.json
    sed -i "" "s|NX_VERSION|$NX_VERSION|g" create-nx-workspace/bin/create-nx-workspace.js
    sed -i "" "s|ANGULAR_CLI_VERSION|$ANGULAR_CLI_VERSION|g" create-nx-workspace/bin/create-nx-workspace.js
    sed -i "" "s|TYPESCRIPT_VERSION|$TYPESCRIPT_VERSION|g" create-nx-workspace/bin/create-nx-workspace.js
    sed -i "" "s|PRETTIER_VERSION|$PRETTIER_VERSION|g" create-nx-workspace/bin/create-nx-workspace.js
    sed -i "" "s|NX_VERSION|$NX_VERSION|g" create-nx-plugin/bin/create-nx-plugin.js
    sed -i "" "s|ANGULAR_CLI_VERSION|$ANGULAR_CLI_VERSION|g" create-nx-plugin/bin/create-nx-plugin.js
    sed -i "" "s|TYPESCRIPT_VERSION|$TYPESCRIPT_VERSION|g" create-nx-plugin/bin/create-nx-plugin.js
    sed -i "" "s|PRETTIER_VERSION|$PRETTIER_VERSION|g" create-nx-plugin/bin/create-nx-plugin.js
else
    sed -i "s|exports.nxVersion = '\*';|exports.nxVersion = '$NX_VERSION';|g" {react,next,gatsby,web,jest,node,linter,express,nest,cypress,storybook,angular,workspace,nx-plugin,react-native,detox}/src/utils/versions.js
    sed -i "s|\*|$NX_VERSION|g" {react,next,gatsby,web,jest,node,express,nest,cypress,storybook,angular,workspace,cli,linter,tao,devkit,eslint-plugin-nx,create-nx-workspace,create-nx-plugin,nx-plugin,react-native,detox}/package.json
    sed -i "s|NX_VERSION|$NX_VERSION|g" create-nx-workspace/bin/create-nx-workspace.js
    sed -i "s|ANGULAR_CLI_VERSION|$ANGULAR_CLI_VERSION|g" create-nx-workspace/bin/create-nx-workspace.js
    sed -i "s|TYPESCRIPT_VERSION|$TYPESCRIPT_VERSION|g" create-nx-workspace/bin/create-nx-workspace.js
    sed -i "s|PRETTIER_VERSION|$PRETTIER_VERSION|g" create-nx-workspace/bin/create-nx-workspace.js
    sed -i "s|NX_VERSION|$NX_VERSION|g" create-nx-plugin/bin/create-nx-plugin.js
    sed -i "s|ANGULAR_CLI_VERSION|$ANGULAR_CLI_VERSION|g" create-nx-plugin/bin/create-nx-plugin.js
    sed -i "s|TYPESCRIPT_VERSION|$TYPESCRIPT_VERSION|g" create-nx-plugin/bin/create-nx-plugin.js
    sed -i "s|PRETTIER_VERSION|$PRETTIER_VERSION|g" create-nx-plugin/bin/create-nx-plugin.js
fi

if [[ $NX_VERSION == "*" ]]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -E -i "" "s|\"@nrwl\/([^\"]+)\": \"\\*\"|\"@nrwl\/\1\": \"file:$PWD\/\1\"|" {jest,web,react,next,gatsby,node,express,nest,cypress,storybook,angular,workspace,linter,cli,tao,devkit,eslint-plugin-nx,create-nx-workspace,create-nx-plugin,nx-plugin,react-native,detox}/package.json
    else
    echo $PWD
        sed -E -i "s|\"@nrwl\/([^\"]+)\": \"\\*\"|\"@nrwl\/\1\": \"file:$PWD\/\1\"|" {jest,web,react,next,gatsby,node,express,nest,cypress,storybook,angular,workspace,linter,cli,tao,devkit,eslint-plugin-nx,create-nx-workspace,create-nx-plugin,nx-plugin,react-native,detox}/package.json
    fi
fi