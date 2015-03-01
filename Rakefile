# -*- mode: ruby; coding: utf-8; indent-tabs-mode: nil -*-
require 'fileutils'



emacs_cmd       = "emacs -Q --batch"

site_lisp_dir   = '/usr/local/share/emacs/site-lisp'
user_emacs_dir  = "#{Dir.home}/.emacs.d"
init_module_dir = "#{user_emacs_dir}/modules"
package_dir     = "#{user_emacs_dir}/vendor"
el_get_dir      = "#{package_dir}/el-get"

task :generate_loaddefs do
  site_lisp_dirs = Dir.glob("#{site_lisp_dir}/{,*/}")

  evals = '(setq make-backup-files nil generated-autoload-file \"' + site_lisp_dir + '/site-loaddefs.el\")'
  paths = site_lisp_dirs.join(" ")

  sh "#{emacs_cmd} --eval \"#{evals}\" -f batch-update-autoloads #{paths}"
end

task :link do
  FileUtils.ln_sf(Dir.pwd, user_emacs_dir)

  git_hooks = Dir.glob("#{user_emacs_dir}/lib/git-hooks/*")
  FileUtils.ln_sf(git_hooks, "#{user_emacs_dir}/.git/hooks/")
end

task :make_dir do
  emacs_dirs = ["#{user_emacs_dir}/etc/auto-complete.dict",
                "#{user_emacs_dir}/etc/snippets",
                "#{user_emacs_dir}/var/backup",
                "#{user_emacs_dir}/var/bookmark",
                "#{user_emacs_dir}/var/cache",
                "#{user_emacs_dir}/var/log",
                "#{user_emacs_dir}/var/tmp",
                "#{user_emacs_dir}/vendor"]
  FileUtils.mkdir_p(emacs_dirs)
end

task :compile do
  modules = ["#{user_emacs_dir}/init.el"]
  modules += Dir.glob("#{init_module_dir}/*-init-[^-]*.el")

  modules.each do |el|
    sh "#{emacs_cmd} -L #{init_module_dir}/ -f batch-byte-compile #{el}"
  end
end

task :tags do
  sh "ctags -e #{user_emacs_dir}/init.el #{init_module_dir}/*.el #{user_emacs_dir}/configs/*.el"
end

task :install_el_get do
  sh "#{emacs_cmd} -L #{init_module_dir} --eval '(setq init-module-safe-mode-p nil)' -l opt-init-packages -f el-get--installer"
end

task :cleanup_var do
  FileUtils.rm_r(Dir.glob("#{user_emacs_dir}/var/{initerror,{backup,bookmark,cache,log,tmp}/*}"))
end

task :cleanup_elc do
  FileUtils.rm(Dir.glob("#{user_emacs_dir}/{init.elc,{modules,configs}/*.elc}"))
end

task :run_tests do
  sh "#{emacs_cmd} -l #{user_emacs_dir}/lib/test/run-tests.el"
end

task :check_recipes do
  args    = '-Wno-features -Wno-autoloads'
  recipes = "#{user_emacs_dir}/etc/recipes/*.rcp"

  sh "#{emacs_cmd} -L #{el_get_dir} -l #{el_get_dir}/el-get-recipes.el -f el-get-check-recipe-batch #{args} #{recipes}"
end

task :default => [:generate_loaddefs, :compile, :tags]
task :install => [:generate_loaddefs, :link, :make_dir, :compile, :tags]
task :travis  => [:link, :make_dir, :install_el_get]
task :cleanup => [:cleanup_var, :cleanup_elc, :compile]
task :test    => [:compile, :run_tests, :check_recipes]
