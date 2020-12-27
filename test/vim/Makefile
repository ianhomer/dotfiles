vimPlugins = ./tmp/vim/plugins
vader= $(vimPlugins)/vader.vim

$(vader):
	git clone git@github.com:junegunn/vader.vim.git ./tmp/vim/plugins/vader.vim

dependencies: $(vader)

testdotfilesvim:
	./test-dotfiles-vim.sh

test: dependencies testdotfilesvim
