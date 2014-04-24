class PodTestHelper
  require 'pathname'
  require 'fileutils'

  PROJECT_SEARCH_DIRS = ['.', 'Project/']
  SETTING_NAMES = ['BUILT_PRODUCTS_DIR', 'CURRENT_ARCH', 'OBJECT_FILE_DIR_normal', 'SRCROOT', 'OBJROOT']
  JOINED_SETTINGS = (SETTING_NAMES.map { |setting| "(#{setting})" }).join('|')

  EXCLUDE_PATTERNS = ['/Applications/Xcode**',
                      'main.m',
                      'Tests/**']

  attr_reader :workspace
  attr_reader :scheme
  attr_reader :working_dir

  def self.xcode_version
    `xcodebuild -version`.match(/(?:\d+\.?)+/)[0]
  end

  def self.xcode5_1?
    self.xcode_version().match(/^5.1/)
  end

  def self.workspace_in_dir(dirname)
    Dir.glob(File.join(dirname, '*.xcworkspace')).first
  end

  def self.find_workspace
    PROJECT_SEARCH_DIRS.reduce(nil) do |memo, dirname|
      memo ||= self.workspace_in_dir(dirname)
    end
  end

  def gcov_tool
    @gcov_tool ||= self.find_gcov_tool!
  end

  def initialize()
    @workspace = Pathname.new(self.class.find_workspace)
    @working_dir = Dir.getwd
  end

  def scheme=(scheme)
    @scheme = scheme
    @build_settings = nil
  end

  def build_settings
    @build_settings ||= self.parse_build_settings(self.get_raw_build_settings(nil))
  end

  def build_settings=(build_settings)
    @build_settings = build_settings
  end

  def in_workspace_dir
    Dir.chdir(@workspace.dirname)
    result = yield
    Dir.chdir(@working_dir)
    result
  end

  # gcov utils

  def find_gcov_tool!
    return Pathname.new("#{@working_dir}/tools/bin/llvm-cov-wrapper").realpath if self.class.xcode5_1?

    xc_gcov_42 = 'xcrun -f gcov-4.2'
    xc_gcov = 'xcrun -f gcov'
    which_gcov = 'which gcov'
    gcov = [xc_gcov_42, xc_gcov, which_gcov].reduce(nil) do |memo, cmd|
      return memo if memo
      result = `#{cmd}`
      if result and result.length
        memo = result.chomp
      end
    end
    if !gcov or gcov.empty?
      throw "gcov not found" if gcov.empty?
    else
      puts "Found gcov: #{gcov}"
    end
  end

  # Capture Coverage

  def get_coverage!
    FileUtils.rm_f self.output_file
    self.cd_fresh_lcov
    abort("Failed to capture coverage data, aborting") unless self.capture_data
    Dir.chdir(@working_dir)
  end

  def capture_data
    self.lcov_run %Q|-c \
    --base-directory "#{self.build_settings['SRCROOT']}" \
    --ignore-errors gcov \
    --gcov-tool "#{self.gcov_tool}" \
    -d "#{self.obj_dir}" \
    -o "#{self.output_file}"|
  end

  def reset_coverage
    self.lcov_run %Q|-z \
    --ignore-errors gcov \
    --gcov-tool "#{self.gcov_tool}" \
    -d "#{self.obj_dir}" \
    -o "#{self.output_file}"|
  end

  # Process Coverage

  def process_coverage
    self.aggregate_coverage
    self.exclude_data
    self.generate_report
  end

  def aggregate_coverage
    files = Dir['*.info'].delete_if { |path| path == 'coverage.info' }
    files_as_args = files.map {|f| %Q|-a "#{f}"|}
    self.lcov_run "#{files_as_args.join ' '} -o coverage.info"
  end

  def exclude_data
    patterns_as_args = EXCLUDE_PATTERNS.map {|p| %Q|-r coverage.info "#{p}"| }
    self.lcov_run "#{patterns_as_args.join ' '} -o coverage.info"
  end

  # Report Coverage

  def generate_report
    report_path = 'coverage'
    FileUtils.rm_rf report_path
    FileUtils.mkdir report_path
    if self.bin_run %Q|genhtml -o "#{report_path}" coverage.info|
      Dir.chdir report_path
      `zip -r ../coverage.zip *`
      Dir.chdir '..'
    end
  end

  def output_file
    require 'pathname'
    Pathname.new(@working_dir).join("#{@scheme}-coverage.info").expand_path
  end

  def summary_file
    require 'pathname'
    Pathname.new(@working_dir).join("#{self.output_file}.summary").expand_path
  end

  def cd_fresh_lcov
    Dir.chdir self.build_settings['BUILT_PRODUCTS_DIR']
    FileUtils.rm_rf 'lcov'
    FileUtils.mkdir 'lcov'
    Dir.chdir 'lcov'
  end

  def obj_dir
    File.join(self.build_settings['OBJECT_FILE_DIR_normal'], self.build_settings['CURRENT_ARCH'])
  end

  # lcov utils

  def lcov_run(args)
    self.bin_run %Q|lcov #{args}|
  end

  def bin_run(cmd)
    system "#{@working_dir}/tools/bin/#{cmd}"
  end

  # Build Settings

  def parse_build_settings(raw_settings)
    raw_settings.strip.split(/\n\s+/).reduce(Hash.new) do |memo, line|
      kv_separator_idx = line.index(' = ')
      key = line[0..(kv_separator_idx-1)]
      value = line[(kv_separator_idx+3)..(line.length-1)]
      memo[key] = value
      memo
    end
  end

  def get_raw_build_settings(cmd)
    self.in_workspace_dir do
      `#{cmd || self.get_test_cmd} -showBuildSettings | egrep '#{JOINED_SETTINGS}'`
    end
  end

  # Tests

  def get_test_cmd
    %Q|xcrun xcodebuild clean test \
    -sdk iphonesimulator \
    -configuration Debug \
    -workspace "#{@workspace.basename}" \
    -scheme "#{@scheme}"|
  end

  def self.killall_sims!
    system 'killall "iPhone Simulator"'
  end

  def run_tests!
    self.class.killall_sims!
    self.reset_coverage
    self.in_workspace_dir do
      abort "Tests failed!" unless system self.get_test_cmd
    end
  end
end
