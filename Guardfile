guard :rspec, cmd: "bundle exec rspec" do
  watch('spec/spec_helper.rb')                        { "spec" }
  watch('config/routes.rb')                           { "spec/requests" }
  watch('app/controllers/application_controller.rb')  { "spec/requests" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| "spec/requests/#{m[1]}_spec.rb" }
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^spec/.+_spec\.rb$})
end
