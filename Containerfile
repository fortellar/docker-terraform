# syntax=docker/dockerfile:1
FROM alpine:latest

# Install dependencies
RUN apk add --no-cache \
    curl \
    unzip \
    git \
    bash \
    python3 \
    pipx

# Install Terraform (latest)
RUN LATEST_TF=$(curl -s https://releases.hashicorp.com/terraform/ | grep -Eo 'terraform/[0-9.]+/' | head -1 | cut -d'/' -f2) && \
    curl -Lo terraform.zip https://releases.hashicorp.com/terraform/${LATEST_TF}/terraform_${LATEST_TF}_linux_amd64.zip && \
    unzip terraform.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform.zip

# Install terraform-docs (latest)
RUN LATEST_TFDOCS=$(curl -s https://api.github.com/repos/terraform-docs/terraform-docs/releases/latest | grep tag_name | cut -d '"' -f4 | sed 's/v//') && \
    curl -Lo terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v${LATEST_TFDOCS}/terraform-docs-v${LATEST_TFDOCS}-linux-amd64.tar.gz && \
    tar -xzf terraform-docs.tar.gz && \
    mv terraform-docs /usr/local/bin/ && \
    rm terraform-docs.tar.gz

# Install tflint (latest)
RUN LATEST_TFLINT=$(curl -s https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep tag_name | cut -d '"' -f4 | sed 's/v//') && \
    curl -Lo tflint.zip https://github.com/terraform-linters/tflint/releases/download/v${LATEST_TFLINT}/tflint_linux_amd64.zip && \
    unzip tflint.zip && \
    mv tflint /usr/local/bin/ && \
    rm tflint.zip

# Install pre-commit - PEP 668 compliant
RUN pipx install pre-commit \
    && pipx ensurepath

ENTRYPOINT ["/bin/sh"]
