# -*- mode: ruby; coding: utf-8; indent-tabs-mode: nil -*-
require 'fileutils'


emacs_cmd       = "emacs -Q --batch"

site_lisp_dir   = '/usr/local/share/emacs/site-lisp'
user_emacs_dir  = "#{Dir.home}/.emacs.d"
init_module_dir = "#{user_emacs_dir}/modules"
pkg_conf_dir    = "#{user_emacs_dir}/configs"
pkg_dir         = "#{user_emacs_dir}/vendor"
elget_dir       = "#{pkg_dir}/el-get"

task :generate_loaddefs do
  site_lisp_dirs = Dir.glob("#{site_lisp_dir}/*/**/")

  paths = site_lisp_dirs.join(" ")
  s     = "(setq make-backup-files nil generated-autoload-file \"#{site_lisp_dir}/site-loaddefs.el\")"

  sh "#{emacs_cmd} --eval '#{s}' -f batch-update-autoloads #{paths}"
end

task :clone_revealjs do
  sh "git clone https://github.com/hakimel/reveal.js.git #{Dir.home}/lib/reveal.js"
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
                "#{user_emacs_dir}/var/cache/pcache",
                "#{user_emacs_dir}/var/log",
                "#{user_emacs_dir}/var/tmp",
                "#{user_emacs_dir}/vendor"]
  FileUtils.mkdir_p(emacs_dirs)
end

task :compile_init_module do
  els  = ["#{user_emacs_dir}/init.el"]
  els += Dir.glob("#{init_module_dir}/*-init-[^-]*.el")

  conf = els.join(" ")

  sh "#{emacs_cmd} -L #{init_module_dir}/ -f batch-byte-compile #{conf}"
end

task :compile_all do
  els  = ["#{user_emacs_dir}/init.el"]
  els += Dir.glob("#{init_module_dir}/*-init-[^-]*.el")
  els += Dir.glob("#{pkg_conf_dir}/init-*.el")

  conf = els.join(" ")
  s    = "(let ((default-directory \"#{pkg_dir}\")) (normal-top-level-add-subdirs-to-load-path))"

  sh "#{emacs_cmd} -L #{init_module_dir}/ --eval '#{s}' -f batch-byte-compile #{conf}"
end

task :tag do
  sh "ctags -e #{user_emacs_dir}/init.el #{init_module_dir}/*.el #{pkg_conf_dir}/*.el"
end

task :install_elget do
  sh "#{emacs_cmd} -L #{init_module_dir} --eval '(setq init-module-safe-mode-p t)' -l opt-init-packages -f el-get--installer"
end

task :remove_var do
  FileUtils.rm_r(Dir.glob("#{user_emacs_dir}/var/{initerror,{backup,bookmark,cache,log,tmp}/*}"))
end

task :remove_elc do
  FileUtils.rm(Dir.glob("#{user_emacs_dir}/{init.elc,{modules,configs}/*.elc}"))
end

task :run_tests do
  sh "#{emacs_cmd} -l #{user_emacs_dir}/lib/test/run-tests.el"
end

task :check_recipes do
  args    = '-Wno-features -Wno-autoloads'
  recipes = "#{user_emacs_dir}/etc/recipes/*.rcp"

  sh "#{emacs_cmd} -L #{elget_dir} -l #{elget_dir}/el-get-check.el -f el-get-check-recipe-batch #{args} #{recipes}"
end

task :default => [:generate_loaddefs, :compile, :tag]
task :install => [:generate_loaddefs, :clone_revealjs, :link, :make_dir, :compile_init_module, :tag]
task :travis  => [:link, :make_dir, :install_elget]
task :compile => [:compile_all]
task :clear   => [:remove_var]
task :cleanup => [:remove_var, :remove_elc, :compile_all]
task :test    => [:compile_init_module, :run_tests, :check_recipes]
