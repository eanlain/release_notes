# Creates an app and sets the RAILS_ROOT and navigates to that app's root
Given /^a Rails app named "([^\"]*)" exists$/ do |app_name|
  @app_name = app_name
  step "I successfully run `rm -rf #{app_name}`" # ensure working directory is clean
  step "a directory named \"#{app_name}\" should not exist"
  step "I successfully run `rails new #{app_name}`"

  ENV["RAILS_ENV"] ||= "test"
  require File.expand_path("../../../tmp/#{app_name}/config/environment.rb",  __FILE__)
  ENV["RAILS_ROOT"] ||= File.dirname(__FILE__) + "/tmp/#{app_name}"
  
  step "I cd to \"#{app_name}\""
end

When /^this gem "([^\"]*)" is installed in the app$/ do |gem_name|
  gem_path = File.expand_path('../../../', __FILE__)
  step "I append to \"Gemfile\" with \"gem '#{gem_name}', :path => '#{gem_path}'\""
  step "I successfully run `bundle check`"
end

When /^this gem is ready to use$/ do
  ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => 'db/test.sqlite3')

  step "I run `rails generate release_notes:install`"
  step "I run `rails generate release_notes ReleaseNote`"
  step "I run `rake db:migrate`"
end

Then /^a file matching "([^\"]*)" should contain "([^\"]*)"$/ do |simple_regex, partial_content|
  file = Dir[[@basedir, simple_regex].join][0]
  file.slice! @basedir + '/'
  check_file_content(file, partial_content, true)
end

Then /^a model named "([^\"]*)" should have "([0-9]+)" records$/ do |model_name, record_count|
  expect(model_name.constantize.count).to eq(record_count.to_i)
end

Given /^I am in "([^\"]*)"$/ do |directory|
  @basedir = directory
end

Given /^the file "([^\"]*)" exists$/ do |filename|
  expect(File.exists?(File.join(@basedir, filename))).to eq(true)
end

When /^I copy the file "([^\"]*)" to "([^\"]*)"$/ do |src, dest|
  FileUtils.cp(File.join(@basedir, src), File.join(@basedir, dest))
end

Then /^the file "([^\"]*)" should exist$/ do |filename|
  expect(File.exists?(File.join(@basedir, filename))).to eq(true)
end

Given /^the following files exist:$/ do |table|
  (@files_i_care_about || table.hashes).each do |file|
    expect(File.exists?(File.join(@basedir, file["filename"]))).to eq(true)
  end
end

When /^I copy the following files to "([^\"]*)":$/ do |destination, table|
  table.hashes.each do |file|
    filename = File.join(@basedir, file["filename"])
    FileUtils.cp(filename, destination)
  end
end

Then /^the following files should exist in "([^\"]*)":$/ do |destination, table|
  table.hashes.each do |file|
    expect(File.exists?(File.join(destination, file["filename"]))).to eq(true)
  end
end

When /^I create the directory "([^\"]*)"$/ do |directory|
  FileUtils.mkdir_p(directory).should_not be_nil
end

Given /^the following table of (.+):$/ do |name, table|
  @tables = {}
  @tables[name] = table.hashes
end

When /^I copy the (.+) in the table to "([^\"]*)"$/ do |name, destination|
  @tables[name].each do |file|
    filename = File.join(@basedir, file["filename"])
    FileUtils.cp(filename, destination)
  end
end

Then /^the (.+) in the table should exist in "([^\"]*)"$/ do |name, destination|
  @tables[name].each do |file|
    expect(File.exists?(File.join(destination, file["filename"]))).to eq(true)
  end
end

When /^I copy files beginning with the letters (\S+) to "([^\"]*)"$/ do |pattern, destination|
  patterns = pattern.split(',')
  @filelist = []
  @destination = destination
  patterns.each do |pattern|
    glob = Dir.glob(File.join(@basedir, "#{pattern}*"))

    actual_files = glob.find_all do |filename| 
      File.file?(filename)
    end

    @filelist << actual_files.map do |filename| 
      File.basename(filename) 
    end
  end
  @filelist.flatten!
  @filelist.each do |filename|
    FileUtils.cp(File.join(@basedir, filename), @destination)
  end
end

Then /^they should exist there$/ do
  raise unless @filelist && @destination
  @filelist.each do |filename|
    expect(File.exists?(File.join(@destination, filename))).to eq(true)
  end
end
