function memdisk() {
	diskutil erasevolume HFS+ "RamDisk" `hdiutil attach -nomount ram://$(($1*2048))`
}