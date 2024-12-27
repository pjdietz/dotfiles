.DEFAULT_GOAL := sketchybar-plugins

SKETCHY_DIR=~/.config/sketchybar/plugins

sketchybar-plugins:
	cd $(SKETCHY_DIR) && go build -o aerospace ./aerospace.go
