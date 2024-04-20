package main

import (
	"flag"
	"fmt"
	"github.com/gen2brain/beeep"
	"github.com/martinlindhe/inputbox"
	"os"
)

func main() {
	// Flags
	alertFlag := flag.Bool("a", false, "Show alert")
	beepFlag := flag.Bool("b", false, "Beep")
	dialogFlag := flag.Bool("d", false, "Show dialog")
	notifyFlag := flag.Bool("n", false, "Show notification")
	flag.Parse()

	args := flag.Args()
	var err error

	if *notifyFlag {
		err = notify(fillArgs(args, "-n <Title> <Body (optional)> <Icon (optional)>", 1, 3))
	} else if *alertFlag {
		err = alert(fillArgs(args, "-a <Title> <Body (optional)> <Icon (optional)>", 1, 3))
	} else if *beepFlag {
		if len(flag.Args()) > 0 {
			perror(TooManyArgs, "-b")
		}
		err = beep()
	} else if *dialogFlag {
		got := dialog(fillArgs(args, "-d <Title> <Body (optional)> <default value (optional)>", 1, 3))
		if got != nil {
			fmt.Println(*got)
			return
		}
	} else {
		err = notify(fillArgs(args, "<Title> <Body (optional)> <Icon (optional)>", 1, 3))
	}
	if err != nil {
		fmt.Fprintln(os.Stderr, fmt.Sprintf("Error: %v", err))
		os.Exit(1)
	}
}

// Arg parser
const (
	TooManyArgs   string = "Too many arguments"
	ReqArgMissing        = "Required argument missing"
)

func perror(err string, msg string) {
	fmt.Fprintln(os.Stderr, fmt.Sprintf("Error: %s", err))
	fmt.Fprintln(os.Stderr, fmt.Sprintf("\nUsage:\n $ notify %s", msg))
	os.Exit(1)
}

func fillArgs(flag []string, msg string, min int, max int) (string, string, string) {
	if len(flag) > max {
		perror(TooManyArgs, msg)
	} else if len(flag) < min {
		perror(ReqArgMissing, msg)
	}
	res := make([]string, 3)
	for i, s := range flag {
		res[i] = s
	}
  res[1] = "."
	return res[0], res[1], res[2]
}

// Handler funcs
func beep() error {
	return beeep.Beep(beeep.DefaultFreq, beeep.DefaultDuration)
}

func notify(title string, body string, assets string) error {
	return beeep.Notify(title, body, assets)
}

func alert(title string, body string, assets string) error {
	return beeep.Alert(title, body, assets)
}

func dialog(title string, body string, defaultVal string) *string {
	got, ok := inputbox.InputBox(title, body, defaultVal)
	if ok {
		return &got
	}
	return nil
}
