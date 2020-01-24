# elastic-s3
Elastic OSS Image With S3 Plugin.

By default, _ElasticSearch_ docker containers don't come with S3 plugin installed. This image fixes this by pulling the plugin and installing in. However, you will need to build it yourself (and possibly host on a private registry) as the credentials need to be embedded into config at start.

```Dockerfile
FROM docker.elastic.co/elasticsearch/elasticsearch-oss:7.5.2

ARG ACCESS_KEY
ARG SECRET_KEY

RUN bin/elasticsearch-plugin install --batch repository-s3
RUN elasticsearch-keystore create

RUN echo "$ACCESS_KEY"  | bin/elasticsearch-keystore add --stdin s3.client.default.access_key
RUN echo "$SECRET_KEY"  | bin/elasticsearch-keystore add --stdin s3.client.default.secret_key
```

<p align="center"><a href="#table-of-contents">
  <img src="/.documentary/section-breaks/0.svg?sanitize=true">
</a></p>

## How To Install

This repo contains the `Dockerfile` with minimal steps required to build an image. The access key and and secret then need to be passed during the build step:

```sh
# export ACCESS_KEY=<ACCESS_KEY>
# export SECRET_KEY=<SECRET_KEY>
git clone https://github.com/art-deco/elastic-s3.git
cd elastic-s3
docker build . -t es-oss:7.5.2 \
       --build-arg ACCESS_KEY=$ACCESS_KEY \
       --build-arg SECRET_KEY=$SECRET_KEY
docker create --name elastic \
       -v elastic-data:/usr/share/elasticsearch/data \
       -p 9200:9200 \
       -e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
       -e "discovery.type=single-node" \
       es-oss:7.5.2
```