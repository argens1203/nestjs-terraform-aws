This repo is a development-only combo to quickly deploy an EC2 instance which runs a NestJS server.

Production Concerns:
- RSA keys should not be generated (and stored) in .terraform
- output.default_user_name is hard-coded (and depends on ami)
