task export_sources: :environment do
  # You can load the file back in like this:
  # sources = eval(File.read("tmp/sources_export.rb"))
  File.write("tmp/sources_export.rb", Source.all.as_json)
end

task export_feeds: :environment do
  # You can load the file back in like this:
  # feeds = eval(File.read("tmp/feeds_export.rb"))
  File.write("tmp/feeds_export.rb", Feed.all.as_json)
end