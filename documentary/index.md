# elastic-s3
Elastic OSS Image With S3 Plugin.

By default, _ElasticSearch_ docker containers don't come with S3 plugin installed. This image fixes this by pulling the plugin and installing in. However, you will need to build it yourself (and possibly host on a private registry) as the credentials need to be embedded into config at start.

%EXAMPLE: Dockerfile, Dockerfile%

%~%

## How To Install

This repo contains the `Dockerfile` with minimal steps required to build an image. The access key and and secret then need to be passed during the build step:

```console
user~:$ \
git clone https://github.com/art-deco/elastic-s3.git \
cd elastic-s3 \
docker build . -t es-oss:7.5.2 --build-arg ACCESS_KEY=<ACCESS_KEY> --build-arg SECRET_KEY=<SECRET_KEY> \
docker create --name elastic -v elastic-data:/usr/share/elasticsearch/data -p 9200:9200 -e "ES_JAVA_OPTS=-Xms512m -Xmx512m" -e "discovery.type=single-node" es-oss:7.5.2
```