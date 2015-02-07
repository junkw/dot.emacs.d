# -*- mode: ruby; coding: utf-8; indent-tabs-mode: nil -*-
require 'fileutils'



task :make_dir do
  emacs_dirs = ["#{Dir.pwd}/etc/auto-complete.dict",
                "#{Dir.pwd}/etc/snippets",
                "#{Dir.pwd}/var/backup",
                "#{Dir.pwd}/var/bookmark",
                "#{Dir.pwd}/var/cache",
                "#{Dir.pwd}/var/log",
                "#{Dir.pwd}/var/tmp",
                "#{Dir.pwd}/vendor"]
  FileUtils.mkdir_p(emacs_dirs)
end

task :compile do
  modules = ["#{Dir.pwd}/init.el"]
  modules += Dir.glob("#{Dir.pwd}/modules/*-init-[^-]*.el")

  modules.each do |el|
    sh "emacs --batch -L #{Dir.pwd}/modules/ -f batch-byte-compile #{el}"
  end
end

task :tags do
  sh "ctags -e #{Dir.pwd}/init.el #{Dir.pwd}/modules/*.el #{Dir.pwd}/configs/*.el"
end

task :link do
  git_hooks = Dir.glob("#{Dir.pwd}/lib/git-hooks/*")

  FileUtils.ln_sf(git_hooks, "#{Dir.pwd}/.git/hooks/")
  FileUtils.ln_sf(Dir.pwd, "#{Dir.home}/.emacs.d")
end

task :cleanup_var do
  FileUtils.rm_r(Dir.glob("#{Dir.pwd}/var/{backup,bookmark,cache,log,tmp}/*"))
end

task :cleanup_elc do
  FileUtils.rm(Dir.glob("#{Dir.pwd}/{init.elc,{modules,configs}/*.elc}"))
end

task :default => [:make_dir, :compile, :tags, :link]
