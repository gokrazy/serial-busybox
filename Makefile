third_party/busybox-1.34.1/busybox.amd64: Dockerfile busybox.config
	docker build --rm -t serial .
	docker run --rm -v $$(pwd)/third_party/busybox-1.34.1:/tmp/bins serial cp -r /bins/ /tmp/

clean:
	rm -f third_party/busybox-1.34.1/busybox.*
