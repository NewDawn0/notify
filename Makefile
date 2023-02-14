TARGET = notify
.PHONY: clean
default: fetch build clean
fetch:
	@echo "\x1b[32;1mFetching...\x1b[0m"
	swift package update

build:
	@echo "\x1b[32;1mBuilding...\x1b[0m"
	swift build --configuration release
	mv .build/release/$(TARGET) ./$(TARGET)

clean:
	@echo "\x1b[32;1mCleaning...\x1b[0m"
	rm -rf .build Package.resolved notify

