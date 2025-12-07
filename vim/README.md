# vim

## Install and configure plugins

```bash
mkdir -p ~/.vim/pack/plugins/start

git clone --depth 1 https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
git clone https://github.com/prabirshrestha/vim-lsp.git ~/.vim/pack/lsp/start/vim-lsp
git clone https://github.com/prabirshrestha/async.vim.git ~/.vim/pack/lsp/start/async.vim

pip install python-lsp-server
```

Run `:GoInstallBinaries` to install [vim-go](https://github.com/fatih/vim-go) binaries.
