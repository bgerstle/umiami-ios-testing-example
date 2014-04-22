namespace :test do
  desc 'Run e2e tests using bwoken'
  task :integration do
    abort "Integration tests failed!" unless system "bwoken test"
  end

  desc 'Run tests in logic test target'
  task :logic do
    abort "Logic tests failed!" unless system "xcodebuild clean test \
                                                -sdk iphonesimulator \
                                                -workspace SoundCloudSearch.xcworkspace \
                                                -scheme SoundCloudSearchLogicTests"
  end

  desc 'Run tests in app test target'
  task :app do
    abort "App tests failed!" unless system "xcodebuild clean test \
                                                -sdk iphonesimulator \
                                                -workspace SoundCloudSearch.xcworkspace \
                                                -scheme SoundCloudSearchTests"
  end

  desc 'Run all tests'
  task :all => [:integration, :logic, :app]
end
