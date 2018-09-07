#!/bin/bash

git submodule init
git submodule foreach git pull origin master
