FROM ubuntu:18.04

RUN ["apt", "update"]
RUN ["apt", "install", "-y", "git"]
RUN ["mkdir", "antora"]
RUN ["apt", "install", "curl", "-y"]

RUN ["apt", "install", "npm", "-y"]

WORKDIR /antora
RUN ["git", "clone", "https://gitlab.com/antora/demo/docs-site.git"]

RUN ["npm", "i", "-g", "http-server"]
RUN ["npm", "i", "-g", "@antora/cli@2.3", "@antora/site-generator-default@2.3"]

WORKDIR /antora/docs-site
RUN echo "antora antora-playbook.yml" >> build_site.sh
RUN ["sh", "build_site.sh"]
RUN echo "http-server build/site &" >> http_server.sh
RUN ["sh", "http_server.sh"]