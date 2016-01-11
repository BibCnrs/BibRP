default:
	@echo "Usage:"
	@echo "  make run-prod -> to run BibRP for https://bib.cnrs.fr"
	@echo "  make run-dev  -> to run BibRP for https://bib-preprod.cnrs.fr"
	@test -f /usr/bin/xmlstarlet || echo "Needs: sudo apt-get install --yes xmlstarlet"

config-prod:
	cp -f shibboleth/shibboleth2.dist.xml shibboleth/shibboleth2.xml

run-prod: cleanup-docker config-prod
	. ./prod.env.sh ; docker-compose up rp

config-dev:
	# patch shibboleth2.xml config file
	# service provider entityID
	cp -f ./shibboleth/shibboleth2.dist.xml ./shibboleth/shibboleth2.xml
	xmlstarlet ed --inplace \
		-u "/_:SPConfig/_:ApplicationDefaults/@entityID" \
		-v https://bib-preprod.cnrs.fr/sp \
		shibboleth/shibboleth2.xml
	# discovery service URL (wayf)
	xmlstarlet ed --inplace \
		-u "/_:SPConfig/_:ApplicationDefaults/Sessions/SSO/@discoveryURL" \
		-v https://discovery.renater.fr/test \
		shibboleth/shibboleth2.xml

run-dev: cleanup-docker config-dev
	. ./dev.env.sh ; docker-compose up

cleanup-docker:
	test -z "$$(docker ps -a | grep docker-shibboleth-sp)" || \
	  docker rm --force $$(docker ps -a | grep docker-shibboleth-sp | awk '{ print $$1 }')
