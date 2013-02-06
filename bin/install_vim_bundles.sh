mkdir -p ~/.vim/bundle
cd ~/.vim/bundle

get_bundle() {
  (
  if [ -d "$2" ]; then
    echo "Updating $1's $2"
    cd "$2"
    git pull --rebase
  else
    git clone "git://github.com/$1/$2.git"
  fi
  )
}

# I don't know what 90% of these are, so I shouldn't be installing them.
#get_bundle adamlowe vim-slurper
#get_bundle duff vim-bufonly
#get_bundle godlygeek tabular
#get_bundle kchmck vim-coffee-script
#get_bundle leshill vim-json
#get_bundle mileszs ack.vim
#get_bundle pangloss vim-javascript
#get_bundle therubymug vim-pyte
#get_bundle tpope vim-abolish
#get_bundle tpope vim-bundler
#get_bundle tpope vim-commentary
#get_bundle tpope vim-cucumber
#get_bundle tpope vim-endwise
get_bundle tpope vim-eunuch
get_bundle tpope vim-fugitive
#get_bundle tpope vim-git
get_bundle tpope vim-haml
#get_bundle tpope vim-markdown
#get_bundle tpope vim-pathogen
#get_bundle tpope vim-rake
#get_bundle tpope vim-ragtag
get_bundle tpope vim-rails
#get_bundle tpope vim-repeat
#get_bundle tpope vim-speeddating
#get_bundle tpope vim-surround
get_bundle tpope vim-unimpaired
#get_bundle tpope vim-vividchalk
get_bundle vim-ruby vim-ruby
#get_bundle wgibbs vim-irblack
get_bundle vim-scripts bufkill.vim
get_bundle vim-scripts bufexplorer.zip
#get_bundle jgdavey vim-blockle
#get_bundle jgdavey vim-railscasts
#get_bundle jgdavey vim-twiddle
#get_bundle jgdavey tslime.vim
#get_bundle jgdavey vim-turbux
#get_bundle gregsexton gitv
#get_bundle nathanaelkane vim-indent-guides
get_bundle tmallen transmit-vim

vim -c 'call pathogen#helptags()|q'
