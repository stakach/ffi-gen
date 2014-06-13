task :test do
  $: << File.join(File.dirname(__FILE__), "lib")
  $: << File.join(File.dirname(__FILE__), "test")
  
  require "clang_test"
  
  system "git status test/output"
end
