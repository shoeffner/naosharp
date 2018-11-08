.PHONY: run
run:
	docker build . -t naosharp
	docker-compose up
