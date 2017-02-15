Pod::Spec.new do |s|
  s.name         = "AuthKit"
  s.version      = "0.0.1"
  s.summary      = "A prefabricated component for user authentication."
  s.description  = <<-DESC
                   Provides a skeleton view controller, as well as view model and manager
                   classes for handling login.
                   DESC
  s.homepage     = "https://github.com/IntrepidPursuits/auth-ios"
  s.license      = "MIT"
  s.author             = { "Mark Daigneault" => "markd@intrepid.io" }
  s.source       = { :git => "https://github.com/IntrepidPursuits/auth-ios.git", :tag => "#{s.version}" }
  s.source_files  = "AuthKit/*.swift"
  s.exclude_files = "Classes/Exclude"
  s.platform      = :ios
  s.ios.deployment_target = "9.0"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }

  s.dependency 'Intrepid', '~> 0.6.6'
  s.dependency 'Intrepid/Rx', '~> 0.6.6'
  s.dependency 'Genome', '~> 3.0.0'
  s.dependency 'KeychainAccess', '~> 3.0.0'
end
