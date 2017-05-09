Pod::Spec.new do |s|
 
  s.platform              = :ios
  s.ios.deployment_target = '8.0'
  s.name                  = "EventBusSwift"
  s.summary               = "Simplifies the communication between components"
  s.requires_arc          = true
  s.version               = "0.1.2"
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.author                = { "TVG" => "tvg@gmail.com" }
  s.homepage              = "https://github.com/TVGSoft/EventBusSwift"
  s.source                = { :git => "https://github.com/TVGSoft/EventBusSwift.git", :tag => "#{s.version}"} 
  s.source_files          = "EventBusSwift/Classes/*.{swift}"

end