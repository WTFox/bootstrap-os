#!/bin/bash

docker build -t dev-env . && docker run -it --rm dev-env bash
