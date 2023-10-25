FROM alpine:latest as git-image
# RUN apk update
# RUN apk add git

# RUN apk add libcurl4-openssl-dev
# FROM bitnami/git:latest as git-image
FROM quay.io/operator-framework/ansible-operator:v1.13.1

USER root

RUN yum install -y \
      java \
      wget \
      git   \
      make

USER ansible
# COPY --from=git-image /usr/bin/git /usr/bin/git
# COPY --from=git-image /usr/bin/git-receive-pack /usr/bin/git-receive-pack
# COPY --from=git-image /usr/bin/git-shell /usr/bin/git-shell
# COPY --from=git-image /usr/bin/git-upload-archive /usr/bin/git-upload-archive
# COPY --from=git-image /usr/bin/git-upload-pack /usr/bin/git-upload-pack
COPY requirements.yml ${HOME}/requirements.yml
RUN ansible-galaxy collection install -r ${HOME}/requirements.yml \
 && chmod -R ug+rwx ${HOME}/.ansible

COPY watches.yaml ${HOME}/watches.yaml
COPY roles/ ${HOME}/roles/
COPY playbooks/ ${HOME}/playbooks/