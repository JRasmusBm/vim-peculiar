# Vim Peculiar

> Not just _normal_ commands.

The idea behind the plugin is to provide shortcuts when working with the
`:norm[al]` command. It has been **so** useful to me that I for the first time
decided to wrap it up as a plugin for others to use.

## Motivation

I really _love_ the expressiveness of running normal commands, either over
a range of files or matching a search. The original intent of this plugin was to
provide a way to run such commands against a text object.

## Usage

The plug-in exposes 4 command line utilities,

- `<Plug> PeculiarN`: Takes a text object and a normal command and runs the
  command against each line of the text object (think `l1,l2 norm`)
- `<Plug> PeculiarG`: Takes a text object, a search and a normal command and
  runs the command against each line of the text object **matching** the search
  (think `l1,l2 g/<search>/norm`)
- `<Plug> PeculiarV`: Takes a text object, a search and a normal command and
  runs the command against each line of the text object **not matching** the search
  (think `l1,l2 v/<search>/norm`)
- `<Plug> PeculiarR`: Takes a text object and runs the previous peculiar command
  against it (think repeat previous)

Example setup:

```vim
nmap <localleader>v <Plug>PeculiarV
nmap <localleader>g <Plug>PeculiarG
nmap <localleader>n <Plug>PeculiarN
nmap <localleader>r <Plug>PeculiarR
```

Each command run updates the command line history and the search commands update
the search history for easy editing if you make mistakes.

## Attributions

- The first version of this plugin was heavily inspired by
  [vim-commentary](https://github.com/tpope/vim-commentary) by
  [Tim Pope](https://github.com/tpope).
