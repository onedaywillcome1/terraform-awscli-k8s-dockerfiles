FROM alpine:3.9

LABEL maintainer="ahmet.atalay@vngrs.com"

################################################################################
# Install tools
RUN apk --update add              \
      bash=4.4.19-r1              \
      grep=3.1-r2                 \
      ca-certificates=20190108-r0 \
      curl=7.64.0-r2              \
      git=2.20.1-r0               \
      jq=1.6-r0                   \
      make=4.2.1-r2               \
      openssh=7.9_p1-r5           \
      py2-pip=18.1-r0             \
      py-setuptools=40.6.3-r0     \
      python3=3.6.8-r2            \
      python=2.7.16-r1            \
      unzip=6.0-r4                \
      wget=1.20.3-r0              \
      zip=3.0-r7                  \
      && \
    pip --no-cache-dir install --upgrade pip==19.0.2 awscli==1.16.200 && \
    rm -rf /var/cache/apk/*  && \
    update-ca-certificates


################################################################################
# Install Terraform
ENV TERRAFORM_VERSION=0.12.7
RUN curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip


################################################################################
# Install Terragrunt
ENV TERRAGRUNT_VERSION=v0.19.21
RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 && \
    chmod 755 terragrunt_linux_amd64 && \
    mv terragrunt_linux_amd64 /usr/local/bin/terragrunt


################################################################################
#Install Kubectl
ENV KUBECTL_VERSION=v1.15.1
RUN curl -L -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
  chmod +x /usr/bin/kubectl && \
  kubectl version --client


################################################################################
# Install Aws-iam-authenticator
RUN curl -L -o /usr/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/aws-iam-authenticator && \
    chmod +x /usr/bin/aws-iam-authenticator


