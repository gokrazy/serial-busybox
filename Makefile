all: _gokrazy/extrafiles_amd64.tar _gokrazy/extrafiles_arm64.tar _gokrazy/extrafiles_arm.tar _gokrazy/extrafiles_386.tar

third_party/busybox-1.34.1/busybox.amd64: Dockerfile busybox.config
	docker build --rm -t serial .
	docker run --rm -v $$(pwd)/third_party/busybox-1.34.1:/tmp/bins serial cp -r /bins/ /tmp/

_gokrazy/extrafiles_amd64.tar: third_party/busybox-1.34.1/busybox.amd64
	mkdir -p _gokrazy
	tar cf $@ $^ "--transform=s,\(.*\),usr/local/bin/busybox,g"

_gokrazy/extrafiles_arm64.tar: third_party/busybox-1.34.1/busybox.arm64
	mkdir -p _gokrazy
	tar cf $@ $^ "--transform=s,\(.*\),usr/local/bin/busybox,g"

_gokrazy/extrafiles_arm.tar: third_party/busybox-1.34.1/busybox.arm
	mkdir -p _gokrazy
	tar cf $@ $^ "--transform=s,\(.*\),usr/local/bin/busybox,g"

_gokrazy/extrafiles_386.tar: third_party/busybox-1.34.1/busybox.386
	mkdir -p _gokrazy
	tar cf $@ $^ "--transform=s,\(.*\),usr/local/bin/busybox,g"

clean:
	rm -f third_party/busybox-1.34.1/busybox.*
