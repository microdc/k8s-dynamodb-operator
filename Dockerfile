FROM equalexpertsmicrodc/ubuntu-testing-container
RUN apt-get install -y yamllint
RUN mkdir /app
WORKDIR /app
COPY ./ /app/
RUN ./test.sh

FROM python:3.6
RUN mkdir /app
RUN apt-get update && apt-get install git gettext-base
RUN curl -L https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -o /usr/local/bin/jq
RUN chmod +x /usr/local/bin/jq
RUN pip install --upgrade --no-cache-dir awscli \
                                         git+https://github.com/side8/k8s-operator@8ae6aec
RUN curl https://storage.googleapis.com/kubernetes-release/release/v1.8.6/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl
COPY startup.sh apply delete common.sh crd.yaml /app/
WORKDIR /app
ENTRYPOINT ["./startup.sh"]
