vader= ./tmp/vim/plugins/vader.vim

$(vader):
	git clone git@github.com:junegunn/vader.vim.git ./tmp/vim/plugins/vader.vim

dependencies: $(vader)

vimrctest:
	./test/vim/test-vimrc.sh

test: dependencies vimrctest
