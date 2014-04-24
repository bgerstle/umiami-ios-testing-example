namespace :test do
  TEST_SCHEMES = ['SoundCloudSearchTests', 'SoundCloudSearchLogicTests']

  desc 'Run e2e tests using bwoken'
  task :integration do
    abort "Integration tests failed!" unless system "bwoken test"
  end

  # Hacky workaround to get test coverage for integration tests
  task :integration_coverage do
    require 'fileutils'
    FileUtils.rm_f '*.info'
    test_helper = PodTestHelper.new()
    test_helper.scheme = 'SoundCloudSearch'
    app_build_cmd = 'xcodebuild build -scheme SoundCloudSearch \
                                      -workspace SoundCloudSearch.xcworkspace \
                                      -configuration Debug \
                                      -sdk iphonesimulator'
    raw_app_build_settings = test_helper.get_raw_build_settings  app_build_cmd
    app_build_settings = test_helper.parse_build_settings raw_app_build_settings
    test_helper.build_settings = app_build_settings
    test_helper.get_coverage!
    test_helper.process_coverage
  end

  desc "Generates a coverage report"
  task :coverage, :scheme do |t, args|
    require 'fileutils'
    FileUtils.rm_f '*.info'

    test_helper = PodTestHelper.new()
    if args.key? :scheme
      Rake::Task[:integration_coverage].invoke
    end
    schemes = args[:scheme] ? [args[:scheme]] : TEST_SCHEMES
    schemes.each do |scheme|
      test_helper.scheme = scheme
      test_helper.get_coverage!
    end
    test_helper.process_coverage
  end

  desc "Run tests"
  task :run do
    Rake::Task[:integration].invoke
    test_helper = PodTestHelper.new()
    TEST_SCHEMES.each do |scheme|
      test_helper.scheme = scheme
      test_helper.run_tests!
    end
  end

  desc "Print Xcode build settings"
  task :xcsettings do
    test_helper = PodTestHelper.new()
    TEST_SCHEMES.each do |scheme|
      test_helper.scheme = scheme
      test_helper.build_settings.each_pair do |key, value|
        puts "\e[#{34}m#{key}\e[0m: #{value}"
      end
    end
  end

  desc 'Run all tests'
  task :all => [:run, :coverage]
end
