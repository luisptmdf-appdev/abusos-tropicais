namespace :slurp4 do
  desc "TODO"
  task songs_queues: :environment do
    
    SongsQueue.destroy_all
    
    require "csv"
    csv_text = File.read(Rails.root.join("lib", "csvs", "Songs_queues.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      x = SongsQueue.new
      x.singer_id = row["singer_id"]
      x.song_id = row["song_id"]
      x.played = true
      x.save
      puts "Song id #{x.song_id} from #{x.singer_id} saved"
    end
    
    puts "There are now #{SongsQueue.count} rows in the Songs_queues table"

  end

end
