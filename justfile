uncompress COMPRESSED_IMG:
	unzstd {{invocation_directory()}}/{{COMPRESSED_IMG}}

flash IMG DEVICE:
	sudo dd if={{invocation_directory()}}/{{IMG}} of={{DEVICE}} bs=4096 conv=fsync status=progress
	sync
