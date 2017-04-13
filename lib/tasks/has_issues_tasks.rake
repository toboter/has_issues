HASISSUES_COPY_TASKS = ['config/locales', 'app/assets/images',
                          'app/assets/stylesheets', 'app/views', 'app/mailers',
                          'app/helpers', 'app/controllers', 'app/models']

namespace :has_issues do
  namespace :install do
    desc "Copy initializers from has_issues to application"
    task :initializers do
      Dir.glob(File.expand_path('../../../config/initializers/*.rb', __FILE__)) do |file|
        if File.exists?(File.expand_path(File.basename(file), 'config/initializers'))
          print "NOTE: Initializer #{File.basename(file)} from has_issues has been skipped. Initializer with the same name already exists.\n"
        else
          cp file, 'config/initializers', verbose: false
          print "Copied initializer #{File.basename(file)} from has_issues\n"
        end
      end
    end
  end

  namespace :copy do
    HASISSUES_COPY_TASKS.each do |path|
      name = File.basename(path)
      desc "Copy #{name} from has_issues to application"
      task name.to_sym do
        namespace = path.start_with?('app') ? '/has_issues' : ''
        cp_r File.expand_path("../../../#{path}#{namespace}", __FILE__), path, verbose: false
        print "Copied #{name} from has_issues\n"
      end
    end
  end

  desc "Copy initializers and migrations from has_issues to application"
  task :install do
    Rake::Task["has_issues:install:initializers"].invoke
    Rake::Task["has_issues:install:migrations"].invoke
  end

  desc "Copy assets, views, mailers, helpers, controllers and models from has_issues to application"
  task :copy do
    HASISSUES_COPY_TASKS.each do |path|
      Rake::Task["has_issues:copy:#{File.basename(path)}"].invoke
    end
  end
end