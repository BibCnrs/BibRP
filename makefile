default:
	@echo "Usage:"
	@echo "  make run-prod -> to run BibRP for https://bib.cnrs.fr"
	@echo "  make run-dev  -> to run BibRP for https://bib-preprod.cnrs.fr"
	@test -f /usr/bin/xmlstarlet || echo "Needs: sudo apt-get install --yes xmlstarlet"

run-prod: cleanup-docker config
	docker-compose up -d rp

config:
	# patch shibboleth2.xml config file
	# service provider entityID
	cp -f ./shibboleth/shibboleth2.dist.xml ./shibboleth/shibboleth2.xml
	xmlstarlet ed --inplace \
		-N sp="urn:mace:shibboleth:2.0:native:sp:config" \
		-u "/sp:SPConfig/sp:ApplicationDefaults/@entityID" \
		-v $(ENTITY_ID) \
		shibboleth/shibboleth2.xml

run-dev: cleanup-docker config
	. ./dev.env.sh ; docker-compose up -d rp

cleanup-docker:
	test -z "$$(docker ps -a | grep bibrp_rp_1)" || \
	  docker rm --force $$(docker ps -a | grep bibrp_rp_1 | awk '{ print $$1 }')
