guard :rspec do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/sequel-setup\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { "spec" }
  watch('spec/spec_helper.rb') { "spec" }
  watch('spec/sequel-setup.rb') { "spec" }
end