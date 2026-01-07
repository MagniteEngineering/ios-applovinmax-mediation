Pod::Spec.new do |spec|

  spec.name         = "magnite-applovin-mediation"
  spec.version      = "0.0.1"
  spec.summary      = "Magnite <-> AppLovin MAX iOS Mediation Adapter."

  spec.description  = <<-DESC
  Using this adapter you will be able to integrate Magnite SDK via AppLovin MAX mediation
                   DESC

  spec.homepage     = "https://www.magnite.com/"
  spec.license      = { :type => "Apache License, Version 2.0", :file => "<LICENSE_FILENAME>" }
  spec.author       = { "iOS Dev" => "<SUPPORT_EMAIL>" }
  
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "<PUBLIC_REPO_URL>", :tag => spec.version.to_s }
  spec.source_files = "MagniteApplovinMediation/*.{h,m}"

  spec.frameworks   = "Foundation", "UIKit"

  spec.requires_arc = true
  spec.static_framework = true

  spec.user_target_xcconfig = { 'ONLY_ACTIVE_ARCH' => 'YES' } 
  
  spec.dependency "AppLovinSDK", ">= 12", "< 14"
  spec.dependency "MagniteSDK", "~> 0.0.1"

end
