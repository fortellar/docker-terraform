# Fortellar Terraform Docker

This repo contains the elements for the base Fortellar base Docker container used for deploying Terraform and validating it.

Currently it supports the following

1. Terraform - Soon to be OpenTofu once 1.10.0 is GA
1. Terraform-Docs
1. TFLint
1. PreCommit

## Release
All tagged releases will create a docker image, and stable releases according to [symver](https://semver.org/) will co-release to `latest`

Container Image: ghcr.io/Fortellar/docker-terraform
