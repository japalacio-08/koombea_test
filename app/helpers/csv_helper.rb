require 'csv'
require 'open-uri'
module CsvHelper
  def self.process_file(file_url, order)
    CSV.parse(URI.open(file_url), headers: order, col_sep: ';').map { |row| row.to_hash }
  end
    
    
end