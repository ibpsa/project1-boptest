build_and_test:
	./build_docs.sh
	bundle exec jekyll serve

build_for_deploy:
	./build_docs.sh
	cd .. && rm -r docs && mkdir docs
	cp -r . ../docs
