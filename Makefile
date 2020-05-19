NAME = lucacracco/phpqa

## help	:	Print commands help.
.PHONY: help
ifneq (,$(wildcard docker.mk))
help : docker.mk
	@sed -n 's/^##//p' $<
else
help : Makefile
	@sed -n 's/^##//p' $<
endif

# If the first argument is "run"...
ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

## build	:	Build image.
.PHONY: build
build:
	docker build -t $(NAME) ./

## push	:	Push image.
.PHONY: push
push:
	docker push $(NAME)

## debug	:	Debug image.
.PHONY: debug
debug:
	docker run --rm -it $(NAME) /bin/bash

## run	:	Run image.
.PHONY: run
run:
	docker run --rm $(NAME) $(RUN_ARGS)

release: build push