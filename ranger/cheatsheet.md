━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  RANGER SHORTCUTS                                    press q to close
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  NAVIGATION
  ──────────────────────────────────────────────────────────────────────────
  h / ←          go up a directory
  l / → / Enter  open file or enter directory
  j / k          move down / up
  gg / G         go to top / bottom
  H / L          go back / forward in history
  gh             go to ~  (home)
  gc             go to ~/code
  gd             go to ~/Desktop
  gD             go to ~/Downloads

  FILE OPERATIONS
  ──────────────────────────────────────────────────────────────────────────
  yy             copy (yank) selected file(s)
  dd             cut (move) selected file(s)
  pp             paste here
  po             paste, overwriting existing files
  D              delete (asks for confirmation)

  RENAME
  ──────────────────────────────────────────────────────────────────────────
  cw             rename (cursor before extension)  ← most common
  a              rename append (cursor at very end)
  A              rename (cursor at end of full name)
  I              rename (cursor at beginning)

  CREATE
  ──────────────────────────────────────────────────────────────────────────
  mf <name>      create a new file  (touch)
  md <name>      create a new directory and enter it

  SELECT / MARK
  ──────────────────────────────────────────────────────────────────────────
  Space          toggle mark on current file
  v              mark/unmark all files in directory
  V              visual select mode (move to select range)
  uv             unmark all

  OPEN / EDIT
  ──────────────────────────────────────────────────────────────────────────
  E  or  e       open in $EDITOR (nvim)
  r              open with custom program
  i              preview file in pager (read-only)

  YANK (COPY TO CLIPBOARD)
  ──────────────────────────────────────────────────────────────────────────
  yp             copy full path to clipboard
  yn             copy filename to clipboard
  yd             copy directory path to clipboard

  SEARCH / FILTER
  ──────────────────────────────────────────────────────────────────────────
  /              search by name (press n/N to jump between matches)
  f              filter-as-you-type (live narrows the file list)
  zh             toggle hidden files (.dotfiles)

  SORT
  ──────────────────────────────────────────────────────────────────────────
  on             sort by name (default)
  os             sort by size
  om             sort by modified time
  or             reverse sort order

  TABS
  ──────────────────────────────────────────────────────────────────────────
  Ctrl-n         new tab
  Ctrl-w         close tab
  Tab / S-Tab    switch to next / previous tab
  gt / gT        next / previous tab

  MISC
  ──────────────────────────────────────────────────────────────────────────
  R              refresh / reload current directory
  du             show disk usage of current directory
  S              open a shell in current directory
  q              quit
  Q              quit all tabs
  ?              ranger help (all commands & keys)
  ?h             this cheatsheet

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
