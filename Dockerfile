FROM docker.elastic.co/elasticsearch/elasticsearch-oss:7.5.1

ARG ACCESS_KEY
ARG SECRET_KEY

RUN bin/elasticsearch-plugin install --batch repository-s3
RUN elasticsearch-keystore create

RUN echo "$ACCESS_KEY"  | bin/elasticsearch-keystore add --stdin s3.client.default.access_key
RUN echo "$SECRET_KEY"  | bin/elasticsearch-keystore add --stdin s3.client.default.secret_key
