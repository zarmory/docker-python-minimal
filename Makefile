
PY_VERSIONS = 3.6.9 3.7.4
ALPINE_VERSIONS = 3.9 3.10

PUSH_REPO = haizaar/python-minimal
PUSH_REVISION = 1

# Note - don't call these rules just "python" or "push
# it will break automatic rules - they will match
build: $(foreach pver,$(PY_VERSIONS),\
			$(foreach aver,$(ALPINE_VERSIONS),python-$(pver)-$(aver)))
upload: $(foreach pver,$(PY_VERSIONS),\
			$(foreach aver,$(ALPINE_VERSIONS),push-$(pver)-$(aver)))

# A space between commas is significant - means " "
# Also for watch for trailing spaces
PYVER = $(word 1,$(subst -, , $*))
ALPVER = $(word 2,$(subst -, , $*))

TAG = $(PUSH_REPO):$(PYVER)-alpine$(ALPVER)-$(PUSH_REVISION)

python-%:
	@set -ex && \
	PYTHONFULL=python:$(PYVER)-alpine$(ALPVER) && \
	docker build --build-arg PYTHONFULL=$$PYTHONFULL \
				 --build-arg ALPINE_VER=$(ALPVER) \
				 -t $(TAG) \
				 .

push-%: python-%
	@set -ex && \
	docker push $(TAG)
