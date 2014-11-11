# -*- mode: ruby; coding: utf-8; indent-tabs-mode: nil -*-
require 'fileutils'



task :make_dir do
  FileUtils.mkdir_p("#{Dir.pwd}/bin")
  FileUtils.mkdir_p("#{Dir.pwd}/etc/auto-complete")
  FileUtils.mkdir_p("#{Dir.pwd}/etc/el-get/recipes/elpa")
  FileUtils.mkdir_p("#{Dir.pwd}/etc/el-get/recipes/emacswiki")
  FileUtils.mkdir_p("#{Dir.pwd}/etc/mu4e")
  FileUtils.mkdir_p("#{Dir.pwd}/etc/yasnippet")
  FileUtils.mkdir_p("#{Dir.pwd}/share/info")
  FileUtils.mkdir_p("#{Dir.pwd}/share/man")
  FileUtils.mkdir_p("#{Dir.pwd}/var/backup")
  FileUtils.mkdir_p("#{Dir.pwd}/var/bookmark")
  FileUtils.mkdir_p("#{Dir.pwd}/var/cache")
  FileUtils.mkdir_p("#{Dir.pwd}/var/log")
  FileUtils.mkdir_p("#{Dir.pwd}/var/tmp")
  FileUtils.mkdir_p("#{Dir.pwd}/vendor")
end

task :compile do
  sh "emacs -batch -L #{Dir.pwd}/init.d/ -f batch-byte-compile init.el #{Dir.pwd}/init.d/*.el"
end

task :tags do
  sh "ctags -e #{Dir.pwd}/init.el #{Dir.pwd}/init.d/*.el #{Dir.pwd}/etc/el-get/conf.d/*.el"
end

task :link do
  FileUtils.ln_sf(Dir.pwd, "#{Dir.home}/.emacs.d")
end

task :cleanup_var do
  FileUtils.rm_rf("#{Dir.pwd}/var/backup/*")
  FileUtils.rm_rf("#{Dir.pwd}/var/bookmark/*")
  FileUtils.rm_rf("#{Dir.pwd}/var/cache/*")
  FileUtils.rm_rf("#{Dir.pwd}/var/log/*")
  FileUtils.rm_rf("#{Dir.pwd}/var/tmp/*")
end

task :cleanup_elc do
  FileUtils.rm_rf("#{Dir.pwd}/init.elc")
  FileUtils.rm_rf("#{Dir.pwd}/init.d/*.elc")
  FileUtils.rm_rf("#{Dir.pwd}/etc/el-get/conf.d/*.elc")
end

task :default => [:make_dir, :compile, :tags, :link]
