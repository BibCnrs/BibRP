
# If the first argument is one of the supported commands...
SUPPORTED_COMMANDS := restore-db save-db
SUPPORTS_MAKE_ARGS := $(findstring $(firstword $(MAKECMDGOALS)), $(SUPPORTED_COMMANDS))
ifneq "$(SUPPORTS_MAKE_ARGS)" ""
  # use the rest as arguments for the command
  COMMAND_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(COMMAND_ARGS):;@:)
endif

run-local:
	[ -f ./default.env.sh ] && . ./default.env.sh ; [ -f ./local.env.sh ] && . ./local.env.sh ; docker-compose up

run-prod:
	[ -f ./default.env.sh ] && . ./default.env.sh ;	[ -f ./prod.env.sh ] && . ./prod.env.sh ; docker-compose up
