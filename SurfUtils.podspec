Pod::Spec.new do |s|

  s.name = "SurfUtils"
  s.version = "7.0.0"
  s.summary = "Contains a set of utils in subspecs"
  s.description  = <<-DESC
  Contains:
    - Extension for easy use NSAttributedString
    - Method for detection JailBreak
    - Manager for easily use vibration features
    - Extension for building query string from dictionary
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

  s.subspec 'JailbreakDetect' do |sp|
    sp.source_files = 'Utils/Utils/JailbreakDetect/JailbreakDetect.swift'
    sp.framework = 'Foundation'
  end

  s.subspec 'VibrationFeedbackManager' do |sp|
    sp.source_files = 'Utils/Utils/VibrationFeedbackManager/*.swift'
    sp.framework = 'AudioToolbox'
  end

  s.subspec 'QueryStringBuilder' do |sp|
    sp.source_files = 'Utils/Utils/Dictionary/Dictionary+QueryStringBuilder.swift'
    sp.framework = 'Foundation'
  end

  s.subspec 'BlurBuilder' do |sp|
    sp.source_files = 'Utils/Utils/UIView/UIView+BlurBuilder.swift'
    sp.framework = 'UIKit'
  end

  s.subspec 'RouteMeasurer' do |sp|
    sp.source_files = 'Utils/Utils/RouteMeasurer/RouteMeasurer.swift'
    sp.framework = 'MapKit'
  end

  s.subspec 'SettingsRouter' do |sp|
    sp.source_files = 'Utils/Utils/SettingsRouter/SettingsRouter.swift'
    sp.framework = 'Foundation'
  end

  s.subspec 'AdvancedNavigationStackManagement' do |sp|
    sp.source_files = 'Utils/Utils/UINavigationController/UINavigationController+AdvancedNavigationStackManagement.swift'
    sp.framework = 'UIKit'
  end

  s.subspec 'WordDeclinationSelector' do |sp|
    sp.source_files = 'Utils/Utils/WordDeclinationSelector/WordDeclinationSelector.swift'
    sp.framework = 'Foundation'
  end

  s.subspec 'ItemsScrollManager' do |sp|
    sp.source_files = 'Utils/Utils/ItemsScrollManager/ItemsScrollManager.swift'
    sp.framework = 'UIKit'
  end

  s.subspec 'KeyboardPresentable' do |sp|
    sp.source_files = 'Utils/Utils/KeyboardPresentable/*.swift'
    sp.framework = 'UIKit'
  end

  s.subspec 'LocalStorage' do |sp|
    sp.source_files = 'Utils/Utils/LocalStorage/LocalStorage.swift'
    sp.framework = 'Foundation'
  end

end
