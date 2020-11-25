namespace :slurp2 do
  desc "TODO"
  task singers: :environment do
    
    require "csv"
    csv_text = File.read(Rails.root.join("lib", "csvs", "Singers.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      x = Singer.new
      x.room_id = row["room_id"]
      x.user_id = row["user_id"]
      x.save
      puts "#{x.id} who is user #{x.user_id} saved"
    end
    
    puts "There are now #{Singer.count} rows in the Singers table"

  end

end
