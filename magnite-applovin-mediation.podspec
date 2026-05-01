Pod::Spec.new do |spec|

  spec.name         = "magnite-applovin-mediation"
  spec.version      = "1.0.0"
  spec.summary      = "Magnite <-> AppLovin MAX iOS Mediation Adapter."

  spec.description  = <<-DESC
  Using this adapter you will be able to integrate Magnite SDK via AppLovin MAX mediation
                   DESC

  spec.homepage     = "https://www.magnite.com/"
  spec.license      = { :type => 'Commercial', :file => 'LICENSE.md' }
  spec.author       = { 'Magnite' => 'sdk@magnite.com' }
  
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://github.com/MagniteEngineering/ios-applovinmax-mediation.git", :tag => spec.version.to_s }
  spec.source_files = "MagniteApplovinMediation/*.{h,m}"

  spec.frameworks   = "Foundation", "UIKit"

  spec.requires_arc = true
  spec.static_framework = true

  spec.user_target_xcconfig = { 'ONLY_ACTIVE_ARCH' => 'YES' } 
  
  spec.dependency "AppLovinSDK", ">= 12", "< 14"
  spec.dependency "MagniteSDK", "~> 1.0"

end
