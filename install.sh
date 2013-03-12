#!bin/bash

cp .vimrc ~/.vimrc
echo "\n"
vim -E -c BundleInstall -c q

