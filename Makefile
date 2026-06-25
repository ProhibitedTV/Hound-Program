OPENSCAD_OUT ?= ./build/openscad

.PHONY: openscad-test clean

openscad-test:
	bash scripts/openscad_smoke_test.sh $(OPENSCAD_OUT)

clean:
	rm -rf ./build
