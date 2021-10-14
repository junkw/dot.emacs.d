# -*- mode: ruby; coding: utf-8; indent-tabs-mode: nil -*-
require 'fileutils'


emacs_cmd       = "emacs -Q --batch"

site_lisp_dir   = '/usr/local/share/emacs/site-lisp'
user_emacs_dir  = "#{Dir.home}/.emacs.d"
init_module_dir = "#{user_emacs_dir}/modules"
core_dir        = "#{init_module_dir}/core"
vendor_dir      = "#{user_emacs_dir}/vendor"


# Build
task :generate_loaddefs do
  site_lisp_dirs = Dir.glob("#{site_lisp_dir}/*/**/")
  paths = site_lisp_dirs.join(" ")
  s     = "(setq make-backup-files nil generated-autoload-file \"#{site_lisp_dir}/site-loaddefs.el\")"

  sh "#{emacs_cmd} --eval '#{s}' -f batch-update-autoloads #{paths}"
end

task :link do
  FileUtils.ln_sf(Dir.pwd, user_emacs_dir)

  git_hooks = Dir.glob("#{user_emacs_dir}/etc/git-hooks/*")
  FileUtils.ln_sf(git_hooks, "#{user_emacs_dir}/.git/hooks/")
end

task :make_dir do
  emacs_dirs = ["#{user_emacs_dir}/etc/snippets",
                "#{user_emacs_dir}/lib",
                "#{user_emacs_dir}/var/backup",
                "#{user_emacs_dir}/var/bookmark",
                "#{user_emacs_dir}/var/cache/pcache",
                "#{user_emacs_dir}/var/log",
                "#{user_emacs_dir}/var/tmp",
                "#{user_emacs_dir}/vendor"]
  FileUtils.mkdir_p(emacs_dirs)
end

task :set_config do
  if RUBY_PLATFORM.include?("darwin")
    sh "defaults write org.gnu.Emacs TransparentTitleBar DARK"
  end
end

# Byte compile
task :compile_all do
  els = FileList.new("#{user_emacs_dir}/init.el", "#{init_module_dir}/*/*init-*.el") do |el|
    el.exclude(/.+\-init\-private\-.+\.el/)
    el.exclude(/.+\/obsoleted-config\/.+\.el/)
  end
  conf = els.join(" ")
  s    = "(let ((default-directory \"#{vendor_dir}\")) (normal-top-level-add-subdirs-to-load-path))"

  sh "#{emacs_cmd} -L #{core_dir}/ --eval '#{s}' -f batch-byte-compile #{conf}"
end

task :compile_init_module do
  els = FileList.new("#{user_emacs_dir}/init.el", "#{init_module_dir}/*/*-init-*.el") do |el|
    el.exclude(/.+\-init\-private\-.+\.el/)
    el.exclude(/.+\/obsoleted-config\/.+\.el/)
  end
  conf = els.join(" ")

  sh "#{emacs_cmd} -L #{core_dir}/ -f batch-byte-compile #{conf}"
end

task :tag do
  tag = "#{user_emacs_dir}/TAGS"
  els = "#{user_emacs_dir}/init.el #{init_module_dir}/"

  if File.exist?(tag)
    sh "ctags -e -u -f #{tag} -R #{els}"
  else
    sh "ctags -e -f #{tag} -R #{els}"
  end
end

# Cleanup
task :remove_elc do
  FileUtils.rm(Dir.glob("#{user_emacs_dir}/{init.elc,modules/*/*.elc}"))
end

task :remove_var do
  FileUtils.rm_r(Dir.glob("#{user_emacs_dir}/var/{initerror,{backup,bookmark,cache,log,tmp}/*}"))
end


# Commands
task :compile => [:compile_all, :tag]
task :install => [:set_config, :generate_loaddefs, :link, :make_dir, :compile_init_module, :tag]

task :cleanup => [:remove_var, :remove_elc, :compile]
task :clear   => [:remove_var]

task :default => [:generate_loaddefs, :compile, :tag]
