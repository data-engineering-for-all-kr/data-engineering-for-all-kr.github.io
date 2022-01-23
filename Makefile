init:
	npm install

format:
	npx prettier --write ./src
	npx prettier --write ./content
	npx prettier --write README.md

develop:
	npm run develop
