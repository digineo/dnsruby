require 'rake/testtask'
require 'rdoc/task'

Rake::TestTask.new do |t|
  t.libs = ["lib","test"]
  t.verbose = true
  t.test_files = FileList['test/tc_*.rb']
end

Rake::RDocTask.new do |rd|
  rd.rdoc_files.include("lib/**/*.rb")
  rd.rdoc_files.exclude("lib/Dnsruby/iana_ports.rb")
  rd.main = "Dnsruby"
#  rd.options << "--ri"
end

task default: :test
