# note

A simple note taking utility for temporary notes

<!-- vim-markdown-toc GFM -->

* [Installation](#installation)
    * [Building from source using Go](#building-from-source-using-go)
    * [Using Nix](#using-nix)
        * [Imperatively](#imperatively)
        * [Declaratively](#declaratively)
* [Usage](#usage)

<!-- vim-markdown-toc -->

## Installation

### Building from source using Go

```bash
git clone https://github.com/NewDawn0/notify.git
cd notify
go build
sudo mv ./notify /usr/local/bin/
```

### Using Nix

#### Imperatively

```bash
git clone https://github.com/NewDawn0/notify
nix profile install .
```

#### Declaratively

1. Add it as an input to your system flake as follows
   ```nix
   {
     inputs = {
       # Your other inputs ...
       notify = {
         url = "github:NewDawn0/notify";
         inputs.nixpkgs.follows = "nixpkgs";
         # Optional: If you use nix-systems
         inputs.nix-systems.follows = "nix-systems"
       };
     };
   }
   ```
2. Add this to your overlays to expose notify to your pkgs

   ```nix
   overlays = [ inputs.notify.overlays.default ];
   ```

3. Then you can either install it in your `environment.systemPackages` using
   ```nix
   environment.systemPackages = with pkgs; [ notify ];
   ```
   or install it to your `home.packages`
   ```nix
   home.packages = with pkgs; [ notify ];
   ```

## Usage

```bash
# Show notification
notify <Title> <Body (optional)> <Icon (optional)>
notify -n <Title> <Body (optional)> <Icon (optional)>

# Show alert
notify -a <Title> <Body (optional)> <Icon (optional)>

# Show dialogue
# If the dialogue is accepted it will print the user answer to the terminal
notify -d <Title> <Body (optional)> <default value (optional)>

# Produce beep sound
notify -b
```
