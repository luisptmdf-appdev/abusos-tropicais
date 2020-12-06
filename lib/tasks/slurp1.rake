namespace :slurp1 do
  desc "TODO"
  task rooms: :environment do
    
    Room.destroy_all

    require "csv"
    csv_text = File.read(Rails.root.join("lib", "csvs", "Rooms.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      x = Room.new
      x.admin_id = row["admin_id"]
      x.password = row["password"]
      x.save
      puts "#{x.id} from #{x.admin_id} saved"
    end
    
    puts "There are now #{Room.count} rows in the Rooms table"

  end

end
