Pod::Spec.new do |s|
  s.name         = "Autocomplete"
  s.version      = "1.0.0"
  s.summary      = "Autocompletion for iOS Swift projects"
  s.description  = <<-DESC
                   The Autocomplete module provide suggestions while you type into a UITextField.
                   DESC
  s.homepage     = "http://balazskiss.name"
  s.documentation_url = "http://balazskiss.name"
  s.license      = { :type => "BSD" }
  s.author             = { "Balazs Kiss" => "dev@balazskiss.name" }
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"
  s.requires_arc = true
  s.source       = { :git => "https://github.com/balazskiss/autocomplete.git", :tag => "1.0.0" }
  s.source_files  = "src/*"
end