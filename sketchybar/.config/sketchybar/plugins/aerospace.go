package main

import (
	"fmt"
	"log"
	"log/slog"
	"os"
	"os/exec"
	"strconv"
	"strings"
)

func main() {
	args := os.Args[1:]
	if len(args) < 1 {
		log.Fatalln("Expected init or update")
	}

	switch args[0] {
	case "init":
		initialize()
	case "update":
		update()
	default:
		log.Fatalln("Expected init or update")
	}

	os.Exit(0)
}

func initialize() {
	fmt.Println("init")
	monitors, _ := getMonitors()
	workspaces, _ := getWorkspaces()

	fmt.Printf("Montiors: %v\n", monitors)
	fmt.Printf("Workspaces: %v\n", workspaces)

	for i, m := range monitors {
		args := []string{}
		bracket := fmt.Sprintf("monitor.%d", m)
		regex := fmt.Sprintf("/space\\.%d\\..*/", m)
		spacer := fmt.Sprintf("spacer.%s", bracket)

		if i > 0 {
			args = append(args, "--add", "item", spacer, "center",
				"--set", spacer,
				"width=20")
		}

		args = append(args, "--add", "bracket", bracket, regex,
			"--set", bracket)

		for _, w := range workspaces {
			item := fmt.Sprintf("space.%d.%s", m, w)

			args = append(args, "--add", "item", item, "center",
				"--set", item,
				"icon="+w,
				"label.drawing=false",
				"background.height=24",
				"background.border_width=1",
				"background.border_color=0xff999999")
		}

		slog.Info(fmt.Sprintf("%v", args))
		err := exec.Command("sketchybar", args...).Run()
		if err != nil {
			slog.Error(err.Error())
		}
	}

}

func update() {
	fmt.Println("update")
}

func getMonitors() ([]int, error) {
	cmd := exec.Command("aerospace", "list-monitors", "--format", "%{monitor-id}")
	obytes, err := cmd.Output()
	if err != nil {
		return []int{}, err
	}
	lines := strings.Split(string(obytes), "\n")
	monitors := []int{}
	for _, line := range lines {
		monitor, err := strconv.Atoi(line)
		if err == nil {
			monitors = append(monitors, monitor)
		}
	}
	return monitors, nil
}

func getWorkspaces() ([]string, error) {
	cmd := exec.Command("aerospace", "list-workspaces", "--all", "--format", "%{workspace}")
	obytes, err := cmd.Output()
	if err != nil {
		return []string{}, err
	}
	lines := strings.Split(string(obytes), "\n")
	workspaces := []string{}
	for _, line := range lines {
		if line != "" {
			workspaces = append(workspaces, line)
		}
	}
	return workspaces, nil
}

func getWindows() ([]string, error) {
	cmd := exec.Command("aerospace", "list-workspaces", "--all", "--format", "%{workspace}")
	obytes, err := cmd.Output()
	if err != nil {
		return []string{}, err
	}
	lines := strings.Split(string(obytes), "\n")
	workspaces := []string{}
	for _, line := range lines {
		if line != "" {
			workspaces = append(workspaces, line)
		}
	}
	return workspaces, nil
}
