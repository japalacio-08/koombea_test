require 'rufus-scheduler'
rufus = Rufus::Scheduler.singleton
namespace :doc_processor do
  desc "Save contacts"
  task save_contacts: :environment do
    rufus.every '5m' do
      files_to_save = UploadedContactsFile.where(status: 'on_hold').first(50)
      files_to_save.each do |row|
        puts "Processing: #{row.name} ======> Document: #{row.document.url}"
        row.process
      end
    end
  end
end
