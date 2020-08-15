## help - Display help about make targets for this Makefile
help:
	@cat Makefile | grep '^## ' --color=never | cut -c4- | sed -e "`printf 's/ - /\t- /;'`" | column -s "`printf '\t'`" -t

## install - install dependency packages
install:
	yarn install

## run - run the React Native app server
run: install
	yarn run build && yarn run start

## clean - clean previous builds
clean:
	rm -rf out/*

## build - build the app for release
build: clean install
	yarn build
	cp CNAME out/

## deploy - build and deploy the app
deploy: clean build
	rm -rf docs/
	mv out docs
	git add docs
	git commit -m "Deploy `git rev-parse --verify HEAD`"
	git push origin master
