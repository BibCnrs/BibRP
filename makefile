
# If the first argument is one of the supported commands...
SUPPORTED_COMMANDS := restore-db save-db
SUPPORTS_MAKE_ARGS := $(findstring $(firstword $(MAKECMDGOALS)), $(SUPPORTED_COMMANDS))
ifneq "$(SUPPORTS_MAKE_ARGS)" ""
  # use the rest as arguments for the command
  COMMAND_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(COMMAND_ARGS):;@:)
endif

config-prod:
	cp -f shibboleth/shibboleth2.dist.xml shibboleth/shibboleth2.xml

run-prod: config-prod
	. ./prod.env.sh ; docker-compose up

config-dev:
	# patch shibboleth2.xml config to match dev needs
	xmlstarlet ed \
		-N sp="urn:mace:shibboleth:2.0:native:sp:config" \
		-u "/sp:SPConfig/sp:ApplicationDefaults/@entityID" \
		-v https://bibcnrs-preprod.cnrs.fr/sp \
		shibboleth/shibboleth2.dist.xml > shibboleth/shibboleth2.xml

run-dev: config-dev
	. ./dev.env.sh ; docker-compose up
