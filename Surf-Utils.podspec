Pod::Spec.new do |s|

  s.name = "Surf-Utils"
  s.version = "0.0.1"
  s.summary = "Contains a set of utils in subspecs"
  s.description  = <<-DESC
  Contains:
    - Extension for easy use NSAttributedString
                   DESC

  s.homepage  = "https://github.com/surfstudio/ios-utils"
  s.license  = { :type => "MIT", :file => "LICENSE" }
  s.author  = { "Alexander Kravchenkov" => "akravchenkov@surfstudio.co" }
  s.source = { :git => "https://github.com/surfstudio/ios-utils.git", :tag => "#{s.version}" }
  s.ios.deployment_target = '10.0'
  s.swift_version = '4.1'

  s.subspec 'StringAttributes' do |sp|
    sp.source_files = 'Utils/Utils/String/String+Attributes.swift'
    sp.framework = 'Foundation', 'UIKit'
  end

end
