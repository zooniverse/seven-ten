guard :rspec, cmd: 'bin/rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{ m[1] }_spec.rb" }
  watch('spec/spec_helper.rb')                        { 'spec' }
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{ m[1] }_spec.rb" }
  watch(%r{^spec/support/(.+)\.rb$})                  { 'spec' }
  watch(%r{^app/(.+)/concerns/.+\.rb$})               { |m| "spec/#{ m[1] }" }
  watch('config/routes.rb')                           { 'spec/routing' }
  watch('app/controllers/application_controller.rb')  { 'spec/controllers' }
  watch('app/models/application_record.rb')           { 'spec/models' }
  watch('spec/spec_helper.rb')                        { 'spec' }
end
