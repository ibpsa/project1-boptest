build_and_test:
	./build_docs.sh
	bundle exec jekyll serve

build_for_deploy:
	./build_docs.sh
	cd .. && rm -r docs && mkdir docs
	bundle exec jekyll serve --detach
	cp -r _site/. ../docs
	cd .. && touch docs/.nojekyll
	pkill -f jekyll
