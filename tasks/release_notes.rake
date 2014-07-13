namespace :release_notes do
  desc 'Creates a new ReleaseNote template.'
  task :new => :environment do
    exec 'release_notes new'
  end

  desc 'Rebuilds ReleaseNote records in the database.'
  task :rebuild => :environment do
    exec 'release_notes update -r'
  end

  desc 'Saves new ReleaseNotes to the database.'
  task :update => :environment do
    exec 'release_notes update'
  end
end