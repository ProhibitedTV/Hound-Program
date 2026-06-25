OPENSCAD_OUT ?= ./build/openscad

.PHONY: openscad-test clean

openscad-test:
	@echo "OpenSCAD CI is defined inline in .github/workflows/openscad-ci.yml"
	@echo "See docs/OPENSCAD_TESTING.md for local export commands."

clean:
	rm -rf ./build
