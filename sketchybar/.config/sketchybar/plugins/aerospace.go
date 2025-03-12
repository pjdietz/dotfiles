package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"slices"
	"strconv"
	"strings"
)

const (
	aerospace  = "aerospace"
	sketchybar = "sketchybar"

	icon_app      = "󰣆"
	icon_calendar = ""
	icon_database = ""
	icon_discord  = ""
	icon_firefox  = ""
	icon_finder   = "󰀶"
	icon_k8s      = "󱃾"
	icon_teams    = "󰊻"
	icon_terminal = "󰞷"
	icon_todo     = ""
	icon_vpn      = "󰒄"
	icon_z        = "󰰸"
)

var icons = map[string]string{
	"Alacritty":         icon_terminal,
	"Aptakube":          icon_k8s,
	"Azure VPN Client":  icon_vpn,
	"DataGrip":          icon_database,
	"Discord":           icon_discord,
	"Finder":            icon_finder,
	"Firefox":           icon_firefox,
	"Ghostty":           icon_terminal,
	"Microsoft Outlook": icon_calendar,
	"Microsoft Teams":   icon_teams,
	"Todoist":           icon_todo,
	"zoom.us":           icon_z,
}

func main() {
	args := os.Args[1:]
	if len(args) < 1 {
		log.Fatalln("Expected init or update")
	}

	switch args[0] {
	case "status":
		status()
	case "init":
		initialize()
	case "update":
		update()
	default:
		log.Fatalln("Expected init or update")
	}

	os.Exit(0)
}

func status() {
	state := newAerospaceState()
	fmt.Printf("%+v", state)
}

func initialize() {
	state := newAerospaceState()
	binary, _ := os.Executable()

	// Add a bracket for monitor.
	for i, m := range state.monitors {

		// Position the monitors on either side of the notch.
		position := "q"
		if i > 0 {
			position = "e"
		}

		args := []string{}
		bracket := fmt.Sprintf("monitor.%d", m)
		regex := fmt.Sprintf("/space\\.%d\\..*/", m)

		// Add a bracket.
		args = append(args, "--add", "bracket", bracket, regex, "--set", bracket)
		_ = exec.Command(sketchybar, args...).Run()
		args = []string{}

		// Add an item for each workspace.
		// Reverse workspaces: Items in q and e draw from right to left.
		slices.Reverse(state.workspaces)
		for j, w := range state.workspaces {
			item := fmt.Sprintf("space.%d.%s", m, w)
			workstate := state.WorkspaceState(m, w)

			args = append(args, "--add", "item", item, position,
				"--set", item,
				"icon="+w,
				"drawing=true",
				"background.height=30",
				"background.corner_radius=8",
				"icon.font=Hack Nerd Font Mono:Bold:14.0",
				"icon.padding_left=10",
				"icon.padding_right=10",
				"label.font=Hack Nerd Font Mono:Bold:22.0",
				"label.padding_left=0",
				"label.padding_right=10",
				"click_script=aerospace workspace "+w+"",
				"script="+binary+" update")

			args = append(args, workstate.Args()...)

			// Only the first item needs to subscribe.
			if i == 0 && j == 0 {
				args = append(args, "--subscribe", item, "aerospace_workspace_change")
			}
		}

		_ = exec.Command(sketchybar, args...).Run()
	}

}

func update() {
	state := newAerospaceState()
	args := []string{}
	for _, m := range state.monitors {
		for _, w := range state.workspaces {
			item := fmt.Sprintf("space.%d.%s", m, w)
			workstate := state.WorkspaceState(m, w)
			args = append(args, "--set", item)
			args = append(args, workstate.Args()...)
		}
	}
	_ = exec.Command(sketchybar, args...).Run()
}

// -----------------------------------------------------------------------------

type WorkspaceState struct {
	focused bool
	visible bool
	apps    string
}

func (w WorkspaceState) Args() []string {

	// Hide any workspace that is empty and not visible.
	if !w.visible && w.apps == "" {
		return []string{"drawing=false"}
	}

	a := []string{
		"drawing=true",
		"label=" + w.apps,
		"label.drawing=true",
	}

	if w.focused {
		a = append(a, "background.color=0x44ffffff")
		a = append(a, "icon.color=0xffffffff")
		a = append(a, "label.color=0xffffffff")
	} else if w.visible {
		a = append(a, "background.color=0x22ffffff")
		a = append(a, "icon.color=0xffffffff")
		a = append(a, "label.color=0xffffffff")
	} else {
		a = append(a, "background.color=0x00000000")
		a = append(a, "icon.color=0xffcccccc")
		a = append(a, "label.color=0xffcccccc")
	}

	return a
}

type AerospaceState struct {
	monitors   []int
	workspaces []string
	focused    string
	visible    []string
	apps       map[int]map[string]string
}

func (a AerospaceState) WorkspaceState(monitor int, workspace string) WorkspaceState {
	w := WorkspaceState{}

	appsByWorkspace, ok := a.apps[monitor]
	if !ok {
		return w
	}
	apps, ok := appsByWorkspace[workspace]
	if !ok {
		return w
	}

	w.focused = workspace == a.focused
	w.visible = slices.Contains(a.visible, workspace)
	w.apps = apps

	return w
}

func newAerospaceState() AerospaceState {
	return AerospaceState{
		monitors:   getMonitors(),
		workspaces: getWorkspaces(),
		focused:    getFocusedWorkspace(),
		visible:    getVisibleWorkspaces(),
		apps:       getApps(),
	}
}

func getMonitors() []int {
	cmd := exec.Command("aerospace", "list-monitors", "--format", "%{monitor-id}")
	o, err := cmd.Output()
	if err != nil {
		log.Fatal(err)
	}
	lines := strings.Split(strings.TrimSpace(string(o)), "\n")
	monitors := []int{}
	for _, line := range lines {
		monitor, _ := strconv.Atoi(line)
		monitors = append(monitors, monitor)
	}
	return monitors
}

func getWorkspaces() []string {
	cmd := exec.Command("aerospace", "list-workspaces", "--all", "--format", "%{workspace}")
	o, err := cmd.Output()
	if err != nil {
		log.Fatal(err)
	}
	lines := strings.Split(strings.TrimSpace(string(o)), "\n")
	workspaces := []string{}
	for _, line := range lines {
		if line != "" {
			workspaces = append(workspaces, line)
		}
	}
	return workspaces
}

func getFocusedWorkspace() string {
	cmd := exec.Command(aerospace, "list-workspaces", "--focused")
	o, err := cmd.Output()
	if err != nil {
		log.Fatal(err)
	}
	return strings.TrimSpace(string(o))
}

func getVisibleWorkspaces() []string {
	cmd := exec.Command(aerospace, "list-workspaces", "--monitor", "all", "--visible")
	o, err := cmd.Output()
	if err != nil {
		log.Fatal(err)
	}
	workspaces := []string{}
	lines := strings.Split(strings.TrimSpace(string(o)), "\n")
	for _, line := range lines {
		if line != "" {
			workspaces = append(workspaces, line)
		}
	}
	return workspaces
}

// Return a map of monitor IDs to map of workspace names to app icons.
func getApps() map[int]map[string]string {
	cmd := exec.Command("aerospace", "list-windows", "--monitor", "all",
		"--format", "%{monitor-id}:%{workspace}:%{app-name}")
	o, err := cmd.Output()
	if err != nil {
		log.Fatalf("Error reading apps. %s", err)
	}

	// Sorting the lines orders by monitor, workspace, app.
	lines := strings.Split(strings.TrimSpace(string(o)), "\n")
	slices.Sort(lines)

	workspacesByMontor := make(map[int]map[string]string)

	for _, l := range lines {
		tokens := strings.SplitN(l, ":", 3)
		monitor, _ := strconv.Atoi(tokens[0])
		workspace := tokens[1]
		app := tokens[2]

		appsByWorkspace, ok := workspacesByMontor[monitor]
		if !ok {
			appsByWorkspace = make(map[string]string)
			workspacesByMontor[monitor] = appsByWorkspace
		}

		apps := appsByWorkspace[workspace]
		icon := appIcon(app)
		if !strings.Contains(apps, icon) {
			apps += icon + " "
		}
		appsByWorkspace[workspace] = apps
	}

	return workspacesByMontor
}

func appIcon(app string) string {
	icon, ok := icons[app]
	if !ok {
		return icon_app
	}
	return icon
}
