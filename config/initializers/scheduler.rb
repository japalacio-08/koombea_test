#
# config/initializers/scheduler.rb
require 'rufus-scheduler'

# Let's use the rufus-scheduler singleton
#
s = Rufus::Scheduler.singleton

# Awesome recurrent task...
#
s.every '5m' do
  Rails.logger.info "hello, it's #{Time.now} and running"
  files_to_save = UploadedContactsFile.where(status: 'on_hold').first(50)
  files_to_save.each do |row|
    puts "Processing: #{row.name} ======> Document: #{row.document.url}"
    row.process
  end
end