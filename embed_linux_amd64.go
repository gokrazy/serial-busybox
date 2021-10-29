package main

import _ "embed"

//go:embed third_party/busybox-1.34.1/busybox.amd64
var busybox []byte
