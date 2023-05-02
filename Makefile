.PHONY: all prepare run

all: prepare

prepare:
	qemu-img create -f qcow2 tmp.qcow2 64G && ./install.sh && mv tmp.qcow2 disk.qcow2

run:
	./run.sh
