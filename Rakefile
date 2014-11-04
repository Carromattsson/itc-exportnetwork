load 'environment.rb'

task :monitor do
  require 'sidekiq/web'
  app = Sidekiq::Web
  app.set :environment, :production
  app.set :bind, '0.0.0.0'
  app.set :port, 9494
  app.set :server, :webrick
  app.run!
end

task :run do
  `ls dataset`.split("\n").each do |file|
    StoreCountryData.perform_async(`pwd`.strip+"/dataset/"+file, file.downcase.include?("mirror"))
  end
end

task :graph do
  [true, false].each do |mirrored|
    2001.upto(2013).each do |year|
      puts "Generating #{year} #{mirrored ? "" : "Not "}Mirrored..."
      f = GenerateYear.new(year, mirrored).to_graph.to_gexf(File.open("results/#{mirrored ? "#{year}_mirrored" : year}.gexf", "w"))
      f.close
    end
  end
end
