# prints a vt100 formatting escape code
e() {
  printf "\033[$@m"
}

# prints a background color escape
b() {
  e "10$1;1"
}

# prints a foreground color escape + bold
f() {
  e "3$1;1"
}

# reset format
r="$(e 0)"
# underline
u="$(e 4)"


cat <<EOF
┌─────────────────────────────────────────────────────────────────────────────┐
│ Composition Notebook                                                        │
└─────────────────────────────────────────────────────────────────────────────┘

┌────────────────┬────────────────┐      ┌───                              ───┐
│  highlighters  │      pens      │      │ wooosh@vacuum           void linux │
├────────────────┼────────────────┤
│ $(b 1)     red      $r │$(f 1)      red       $r│        hardware $u                         $r
├────────────────┼────────────────┤        * laptop ................. lg gram
│ $(b 2)    green     $r │$(f 2)     green      $r│        * ram ...................... 16 gb
├────────────────┼────────────────┤        * display .......... 1920x1080 15" 
│ $(b 3)    yellow    $r │$(f 3)     yellow     $r│            
├────────────────┼────────────────┤        software $u                         $r
│ $(b 4)     blue     $r │$(f 4)      blue      $r│        * window manager ............ fvwm
├────────────────┼────────────────┤        * panel ............. fvwm widgets
│ $(b 5)     pink     $r │$(f 5)      pink     $r │        * editor ..................... vim
├────────────────┼────────────────┤        * browser ................ firefox
│ $(b 6)     cyan     $r │$(f 6)      cyan     $r │      │ * music ..................... cmus │ 
└────────────────┴────────────────┘      └───                              ───┘
EOF
# colors for ascii art
g="$(f 2)"  # green for stems
rd="$(f 1)" # red for @@@ petals
b="$(f 4)"  # blue for (_) petals
p="$(f 5)"  # pink for www/vvv petals
y="$(f 3)"  # yellow for center of flowers

echo $(e '1;2') # bold + newline
echo   '                      '$b'_(_)_                          '$p'wWWWw   '$b'_'
echo   '          '$rd'@@@@       '$b'(_)@(_)   '$p'vVVVv     '$b'_     '$rd'@@@@  '$p'(___) '$b'_(_)_    (_)'
echo   '         '$rd'@@'$y'()'$rd'@@ '$p'wWWWw  '$b'(_)'$g'\    '$p'(___)   '$b'_(_)_  '$rd'@@'$y'()'$rd'@@   '$g'Y  '$b'(_)'$y'@'$b'(_) (_)'$y'@'$b'(_)'
echo   '          '$rd'@@@@  '$p'(___)     '$g'`|/    Y    '$b'(_)'$y'@'$b'(_)  '$rd'@@@@   '$g'\|/   '$b'(_)'$g'\    '$b'(_)'
echo $g'           /      Y       \|    \|/    /(_)    \|      |/      |  /   '$p'wWw'
echo $g'        \ |     \ |/       | / \ | /  \|/       |/    \|      \|//   '$p'(___)'
echo $g'    jgs \\|//   \\|///  \\\|//\\\|/// \|///  \\\|//  \\|//  \\\|//   \\|//'
echo $g'^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'$r
# TODO: planter area with nice brown lines. maybe use brown lines elsewhere for text??

# set accent colors in 256 color
xtermcontrol '--color17=#252724'
xtermcontrol '--color18=#c6da83'

a1="$(printf '\033[48;5;17;1m')$(f 0)"
a2="$(printf '\033[48;5;18;1m')"

cat <<EOF
│    accents     │   off-colors   │                                            │
├────────────────┼────────────────┤     uses azukifont from azukifont.com      │
│ $a1    dark     $r  │ $(f 7)    brown     $r │                                            │
├────────────────┼────────────────┤ notebook lines are using a tiled urxvt bg  │
│ $a2    green    $r  │ $(b 0)    gray      $r │                                            │
├────────────────┴────────────────┤        fetch & rice made by wooosh         │
│                                 │                                            │
│     $(e 1)inspired by addy & tam$r      │     dotfiles @ github.com/wooosh/dots      │
│                                 │                                            │
└─────────────────────────────────┴────────────────────────────────────────────┘
EOF

