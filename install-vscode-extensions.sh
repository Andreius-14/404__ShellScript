#!/bin/bash

# execute command
# -------------------
# curl -s https://raw.githubusercontent.com/karaage0703/vscode-dotfiles/master/install-vscode-extensions.sh | /bin/bash

# Visual Studio Code :: Package list
pkglist=(
batisteo.vscode-django
bmewburn.vscode-intelephense-client
bradlc.vscode-tailwindcss
burkeholland.simple-react-snippets
chris-noring.node-snippets
christian-kohler.npm-intellisense
christian-kohler.path-intellisense
chrmarti.regex
dbaeumer.vscode-eslint
devsense.composer-php-vscode
digitalbrainstem.javascript-ejs-support
donjayamanne.githistory
dsznajder.es7-react-js-snippets
eamodio.gitlens
ecmel.vscode-html-css
esbenp.prettier-vscode
formulahendry.auto-close-tag
formulahendry.auto-rename-tag
formulahendry.code-runner
github.copilot
github.copilot-chat
jasonnutter.search-node-modules
jorgeserrano.vscode-csharp-snippets
kevinrose.vsc-python-indent
leizongmin.node-module-intellisense
mgmcdermott.vscode-language-babel
mhutchie.git-graph
ms-ceintl.vscode-language-pack-es
ms-dotnettools.csdevkit
ms-dotnettools.csharp
ms-dotnettools.vscode-dotnet-runtime
ms-dotnettools.vscodeintellicode-csharp
ms-python.debugpy
ms-python.python
ms-python.vscode-pylance
ms-toolsai.jupyter-keymap
ms-toolsai.jupyter-renderers
ms-toolsai.vscode-jupyter-cell-tags
ms-toolsai.vscode-jupyter-slideshow
njpwerner.autodocstring
pkief.material-icon-theme
pranaygp.vscode-css-peek
quicktype.quicktype
rangav.vscode-thunder-client
ritwickdey.liveserver
sachinb94.css-tree
sdras.night-owl
syler.sass-indented
tal7aouy.theme
visualstudioexptteam.intellicode-api-usage-examples
visualstudioexptteam.vscodeintellicode
vscode-icons-team.vscode-icons
vscodevim.vim
wallabyjs.console-ninja
wallabyjs.quokka-vscode
wesbos.theme-cobalt2
whizkydee.material-palenight-theme
xabikos.javascriptsnippets
xdebug.php-debug
xdebug.php-pack
zhuangtongfa.material-theme
zignd.html-css-class-completion
zobo.php-intellisense

)

for i in ${pkglist[@]}; do
  code --install-extension $i
done
