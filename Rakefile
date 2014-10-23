# -*- mode: ruby; coding: utf-8; indent-tabs-mode: nil -*-


task :make_dir do
  sh "mkdir -p #{Dir.pwd}/bin #{Dir.pwd}/etc/auto-complete #{Dir.pwd}/etc/el-get/recipes/elpa #{Dir.pwd}/etc/el-get/recipes/emacswiki #{Dir.pwd}/etc/mu4e #{Dir.pwd}/etc/yasnippet #{Dir.pwd}/share/info #{Dir.pwd}/share/man #{Dir.pwd}/var/backup #{Dir.pwd}/var/bookmark #{Dir.pwd}/var/cache #{Dir.pwd}/var/log #{Dir.pwd}/var/tmp #{Dir.pwd}/vendor"
end

task :compile do
  sh "emacs -batch -L #{Dir.pwd}/init.d/ -f batch-byte-compile init.el #{Dir.pwd}/init.d/*.el"
end

task :tags do
  sh "ctags -e #{Dir.pwd}/init.el #{Dir.pwd}/init.d/*.el #{Dir.pwd}/etc/el-get/conf.d/*.el"
end

task :link do
  sh "ln -s #{Dir.pwd} ~/.emacs.d"
end

task :cleanup_var do
  sh "rm -rf #{Dir.pwd}/var/backup/* #{Dir.pwd}/var/bookmark/* #{Dir.pwd}/var/cache/* #{Dir.pwd}/var/log/* #{Dir.pwd}/var/tmp/*"
end

task :cleanup_elc do
  sh "rm -f #{Dir.pwd}/init.elc #{Dir.pwd}/init.d/*.elc  #{Dir.pwd}/etc/el-get/conf.d/*.elc"
end

task :default => [:make_dir, :compile, :tags, :link]
