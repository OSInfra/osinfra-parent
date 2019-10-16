package:
	mvn clean package -DskipTests -U

install:
	mvn clean install -DskipTests -U

tag:
	$(eval commit := $(shell git rev-parse --short=8 HEAD))
	$(eval tag := $(shell mvn help:evaluate -Dexpression=project.version | grep -v "^\[" | grep -v "Download" | awk '{print $$0"-$(commit)"}'))
	git tag -a $(tag) -m "Branch: `git branch | grep \* | awk '{print $$2}'`"
	git push origin refs/tags/$(tag)

release:
	rm -f release.properties pom.xml.releaseBackup
	rm -f */release.properties */pom.xml.releaseBackup
	mvn release:prepare -B
	rm -f release.properties pom.xml.releaseBackup
	rm -f */release.properties */pom.xml.releaseBackup
