#!/usr/bin/env bash


el_get_dir="vender/el-get"

install_pkgs() {
	git clone --depth 1 --branch master https://github.com/dimitri/el-get.git ${el_get_dir}
}

# todo
compile_init_module() {
	emacs -batch -Q -L modules/core/ -f batch-byte-compile \
		  init.el \
		  modules/core/*.el \
		  modules/builtins-config/*.el \
		  modules/local-config/*.el
}

check_recipes() {
	emacs -batch -Q -L ${el_get_dir} -l ${el_get_dir}/el-get-check.el \
		  -f el-get-check-recipe-batch \
		  -Wno-features -Wno-github -Wno-autoloads \
		  etc/recipes/*.rcp
}

# todo
ert_tests() {
    emacs -batch -L modules/core/ -L modules/local-config/ -L ${el_get_dir} -L lib/test/ \
		  --eval '(setq user-emacs-directory (file-name-as-directory (getenv "GITHUB_WORKSPACE")))' \
		  -l lib/test/run-tests.el
}

#shopt -s nullglob

declare -f install_pkgs compile_init_module check_recipes ert_tests
