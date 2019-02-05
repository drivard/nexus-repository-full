all: init setversion build

init:
	rm -rf ./nexus-repository-apt ./nexus-repository-helm
	git clone --single-branch -b UpdateToThreeDotFifteen https://github.com/sonatype-nexus-community/nexus-repository-apt.git
	git clone https://github.com/sonatype-nexus-community/nexus-repository-helm.git
	git clone https://github.com/sonatype-nexus-community/nexus-repository-composer.git

setversion:
	sed -i.bak 's/NEXUS_VERSION=3.15.0/NEXUS_VERSION=3.15.2/g' ./nexus-repository-apt/Dockerfile
	sed -i.bak 's/NEXUS_VERSION=3.14.0/NEXUS_VERSION=3.15.2/g' ./nexus-repository-helm/Dockerfile
	sed -i.bak 's/NEXUS_BUILD=04/NEXUS_BUILD=01/g' ./nexus-repository-helm/Dockerfile
	sed -i.bak 's/NEXUS_VERSION=3.13.0/NEXUS_VERSION=3.15.2/g' ./nexus-repository-composer/Dockerfile

build:
	docker-compose up -d --build