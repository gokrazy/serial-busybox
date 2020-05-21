package main

import (
	"io/ioutil"
	"log"
	"os"
	"path/filepath"

	"github.com/gokrazy/gokrazy"
)

func main() {
	busybox := bundled["third_party/busybox-1.31.1/busybox"]
	const wellKnownSerialShell = "/tmp/serial-busybox/ash"
	if err := os.MkdirAll(filepath.Dir(wellKnownSerialShell), 0755); err != nil {
		log.Fatalf("Mkdir: %v", err)
	}
	err := ioutil.WriteFile(wellKnownSerialShell, busybox, 0755)
	if err != nil {
		log.Fatalf("could not write busybox: %v", err)
	}
	gokrazy.DontStartOnBoot()
}
