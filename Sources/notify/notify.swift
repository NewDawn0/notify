/*  _________              _   _  __
 * |         | _ __   ___ | |_(_)/ _|_   _
 * |_, ______|| '_ \ / _ \| __| | |_| | | |
 *   |/       | | | | (_) | |_| |  _| |_| |
 *            |_| |_|\___/ \__|_|_|  \__, |
 * https://github.com/NewDawn0/notify |___/
 *
 * A CLI tool written in Swift to bring notify-send to macOS
 *
 * Author: NewDawn0
 * Contributors: --
 * License: MIT
 * Language: Rust
 * Version: 1.0.1
 *
 * LICENSE:
 * Copyright (c) 2023 NewDawn0
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
*/


/* Imports */
import Foundation
import ColorizeSwift

/* Defaults */
struct Defaults {
    let iconPath = "~/Desktop/icon.png"
    let title = "Notify"
}
/* Argument struct */
public struct Argument {
    var name: String
    var desc: String
    var short: Character
    var value: String
    init(name: String, desc: String) {
        self.name = name
        self.desc = desc
        self.short = self.name.first!
        self.value = ""
    }
}
/* Application information */
struct AppInfo {
    var appname = "Notify"
    var appversion = "1.0.0"
    var author = "NewDawn0"
    var copyright = "NewDawn0 2023"
    var description = "A notification tool"
}

@main
public class Notify {
    public static func main() {
        /* Variables */
        var helpArg = Argument(name: "help", desc: "Prints the help menu")
        var iconArg = Argument(name: "icon", desc: "Sets the icon for nofification")
        var titleArg = Argument(name: "title", desc: "Sets the title for the notification")
        
        /* Check commandline arguments as a closure as to not create variables useles to the rest of the programm */
        var checkCli = {
            let args = CommandLine.arguments
            if args.count == 1 {
                print("Err".red().bold() + " :: Provide an arg\n  -> \(Utils().helpShort)")
            }
            for (index, arg) in args.enumerated() {
                // Check Help arg
                if arg == "--\(helpArg.name)" || arg == "-\(helpArg.short)" {
                    Utils.genHelp(args: [helpArg, iconArg, titleArg])
                // Check icon arg
                } else if arg == "--\(iconArg.name)" || arg == "-\(iconArg.short)" {
                    if index + 1 < args.count {
                        iconArg.value = args[index+1]
                    } else {
                        Utils.eprintln(errItem: "\(args[index])", corr: "\(args[index]) <Icon path>")
                    }
                // Check title arg
                } else if arg == "--\(titleArg.name)" || arg == "-\(titleArg.short)" {
                    if index + 1 < args.count {
                        iconArg.value = args[index+1]
                    } else {
                        Utils.eprintln(errItem: "\(args[index])", corr: "\(args[index]) <Title>")
                    }
                }
            }
        }
        /* Check command line arguments */
        checkCli()
    }
}

/* Some useful utilites grouped together */
public class Utils {
    /* The try help message */
    public private(set) var helpShort = "Try '" + "notify".blue().bold() + " --help".cyan() + "' for more information"
    /* Prints a formatted error */
    public static func eprintln(errItem: String, corr: String) {
        print("Err".red().bold() + " :: Invalid item '" + errItem.red() + "' -> " + corr.green())
        print("  -> \(Utils().helpShort)")
        exit(1)
    }
    /* Generate the help menu when called using -h or --help */
    public static func genHelp(args: Array<Argument>) {
        let info = AppInfo()
        print(info.appname.blue().bold() + " - \(info.description)".blue())
        print("----------------------------".blue())
        print("Author: ".blue() + "\(info.author)")
        print("Version: ".blue() + "\(info.appversion)")
        print("Copyright: ".blue() + "©\(info.copyright)\n")
        print("Options:".blue())
        for arg in args {
            print("    -\(arg.short)".cyan() + "\t\t\(arg.desc)")
            print("    --\(arg.name)".cyan() + "\t\(arg.desc)\n")
        }
    }
}
