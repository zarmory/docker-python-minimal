
PY_VERSIONS = 3.6.8 3.7.2
ALPINE_VER = 3.8

PUSH_REPO = haizaar/python-minimal
PUSH_REVISION = 1
TAG = $(PUSH_REPO):$*-alpine$(ALPINE_VER)-$(PUSH_REVISION)

# Note - don't call these rules just "python" or "push
# it will break automatic rules - they will match
build: $(foreach ver,$(PY_VERSIONS),python$(ver))
upload: $(foreach ver,$(PY_VERSIONS),push$(ver))

python%:
	@set -ex && \
	PYTHONFULL=python:$*-alpine$(ALPINE_VER) && \
	docker build --build-arg PYTHONFULL=$$PYTHONFULL \
				 --build-arg ALPINE_VER=$(ALPINE_VER) \
				 -t $(TAG) \
				 .

push%: python%
	@set -ex && \
	docker push $(TAG)
