# -*- mode: ruby; coding: utf-8; indent-tabs-mode: nil -*-
require 'fileutils'



user_emacs_dir = "#{Dir.home}/.emacs.d"

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

task :generate_loaddefs do
  site_lisp_dir  = '/usr/local/share/emacs/site-lisp'
  site_lisp_dirs = Dir.glob("#{site_lisp_dir}/{,*/}")

  evals = '(setq make-backup-files nil generated-autoload-file \"' + site_lisp_dir + '/site-loaddefs.el\")'
  paths = site_lisp_dirs.join(" ")

  sh "emacs -Q --batch --eval \"#{evals}\" -f batch-update-autoloads #{paths}"
end

task :compile do
  modules = ["#{user_emacs_dir}/init.el"]
  modules += Dir.glob("#{user_emacs_dir}/modules/*-init-[^-]*.el")

  modules.each do |el|
    sh "emacs --batch -L #{user_emacs_dir}/modules/ -f batch-byte-compile #{el}"
  end
end

task :tags do
  sh "ctags -e #{user_emacs_dir}/init.el #{user_emacs_dir}/modules/*.el #{user_emacs_dir}/configs/*.el"
end

task :link do
  FileUtils.ln_sf(Dir.pwd, user_emacs_dir)

  git_hooks = Dir.glob("#{user_emacs_dir}/lib/git-hooks/*")
  FileUtils.ln_sf(git_hooks, "#{user_emacs_dir}/.git/hooks/")
end

task :cleanup_var do
  FileUtils.rm_r(Dir.glob("#{user_emacs_dir}/var/{initerror,{backup,bookmark,cache,log,tmp}/*}"))
end

task :cleanup_elc do
  FileUtils.rm(Dir.glob("#{user_emacs_dir}/{init.elc,{modules,configs}/*.elc}"))
end

task :default => [:generate_loaddefs, :link, :make_dir, :compile, :tags]
