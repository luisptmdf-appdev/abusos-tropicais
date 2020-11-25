namespace :slurp3 do
  desc "TODO"
  task songs: :environment do
    
    require "csv"
    csv_text = File.read(Rails.root.join("lib", "csvs", "Songs.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      x = Song.new
      x.name = row["name"]
      x.artist = row["artist"]
      x.user_id = row["user_id"]
      x.url = row["url"]
      x.save
      if x.id < 20
        puts "Song #{x.name}, with url #{x.url}, saved"
      end
    end
    
    puts "There are now #{Song.count} rows in the Songs table"

  end

end
