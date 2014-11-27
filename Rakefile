# -*- mode: ruby; coding: utf-8; indent-tabs-mode: nil -*-
require 'fileutils'



task :make_dir do
  emacs_dirs = ["#{Dir.pwd}/bin",
                "#{Dir.pwd}/etc/auto-complete",
                "#{Dir.pwd}/etc/el-get/recipes/elpa",
                "#{Dir.pwd}/etc/el-get/recipes/emacswiki",
                "#{Dir.pwd}/etc/mu4e",
                "#{Dir.pwd}/etc/yasnippet",
                "#{Dir.pwd}/share/info",
                "#{Dir.pwd}/share/man",
                "#{Dir.pwd}/var/backup",
                "#{Dir.pwd}/var/bookmark",
                "#{Dir.pwd}/var/cache",
                "#{Dir.pwd}/var/log",
                "#{Dir.pwd}/var/tmp",
                "#{Dir.pwd}/vendor"]
  FileUtils.mkdir_p(emacs_dirs)
end

task :compile do
  sh "emacs --batch -L #{Dir.pwd}/init.d/ -f batch-byte-compile #{Dir.pwd}/init.el #{Dir.pwd}/init.d/*.el"
end

task :tags do
  sh "ctags -e #{Dir.pwd}/init.el #{Dir.pwd}/init.d/*.el #{Dir.pwd}/etc/el-get/conf.d/*.el"
end

task :link do
  git_hooks = ["#{Dir.pwd}/share/git/post-checkout",
               "#{Dir.pwd}/share/git/post-merge",
               "#{Dir.pwd}/share/git/post-rewrite"]
  FileUtils.ln_sf(git_hooks, "#{Dir.pwd}/.git/hooks/")
  FileUtils.ln_sf(Dir.pwd, "#{Dir.home}/.emacs.d")
end

task :cleanup_var do
  FileUtils.rm_r(Dir.glob("#{Dir.pwd}/var/{backup,bookmark,cache,log,tmp}/*"))
end

task :cleanup_elc do
  FileUtils.rm(Dir.glob("#{Dir.pwd}/{init.elc,**/*init-*.elc}"))
end

task :default => [:make_dir, :compile, :tags, :link]
