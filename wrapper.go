package main

import (
	"log"
	"os"
	"path/filepath"

	"github.com/gokrazy/gokrazy"
)

func main() {
	const wellKnownSerialShell = "/tmp/serial-busybox/ash"
	if err := os.MkdirAll(filepath.Dir(wellKnownSerialShell), 0755); err != nil {
		log.Fatalf("Mkdir: %v", err)
	}
	if err := os.Symlink("/usr/local/bin/busybox", wellKnownSerialShell); err != nil {
		log.Fatal(err)
	}
	gokrazy.DontStartOnBoot()
}
