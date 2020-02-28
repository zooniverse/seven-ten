revision_file = Rails.root.join 'config/commit_id.txt'

if File.exists?(revision_file)
  Rails.application.revision = File.read(revision_file).chomp
end
