Pod::Spec.new do |s|

  s.name = "SurfUtils"
  s.version = "13.2.0"
  s.summary = "Utils collection for iOS-development."
  s.description  = <<-DESC
  Each utility is a small and frequently used piece of logic or UI component.
  Contains:
    - Extension for easy use NSAttributedString
    - Method for detection JailBreak
    - Helper for working with keyboard
    - Device detection manager
    - and lots more!
                   DESC

  s.homepage  = "https://github.com/surfstudio/ios-utils"
  s.license  = { :type => "MIT", :file => "LICENSE" }
  s.author  = { "Surf" => "chausov@surf.dev" }
  s.source = { :git => "https://github.com/surfstudio/ios-utils.git", :tag => "#{s.version}" }
  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'

  s.subspec 'StringAttributes' do |sp|
    sp.source_files = 'Utils/String/*.swift'
    sp.framework = 'Foundation', 'UIKit'
  end

  s.subspec 'BrightSide' do |sp|
    sp.source_files = 'Utils/BrightSide/BrightSide.swift'
    sp.framework = 'Foundation'
  end

  s.subspec 'VibrationFeedbackManager' do |sp|
    sp.source_files = 'Utils/VibrationFeedbackManager/*.swift'
    sp.framework = 'AudioToolbox'
  end

  s.subspec 'QueryStringBuilder' do |sp|
    sp.source_files = 'Utils/Dictionary/Dictionary+QueryStringBuilder.swift'
    sp.framework = 'Foundation'
  end

  s.subspec 'BlurBuilder' do |sp|
    sp.source_files = 'Utils/UIView/UIView+BlurBuilder.swift'
    sp.framework = 'UIKit'
  end

  s.subspec 'RouteMeasurer' do |sp|
    sp.source_files = 'Utils/RouteMeasurer/RouteMeasurer.swift'
    sp.framework = 'MapKit'
  end

  s.subspec 'SettingsRouter' do |sp|
    sp.source_files = 'Utils/SettingsRouter/SettingsRouter.swift'
    sp.framework = 'Foundation'
  end

  s.subspec 'AdvancedNavigationStackManagement' do |sp|
    sp.source_files = 'Utils/UINavigationController/UINavigationController+AdvancedNavigationStackManagement.swift'
    sp.framework = 'UIKit'
  end

  s.subspec 'WordDeclinationSelector' do |sp|
    sp.source_files = 'Utils/WordDeclinationSelector/WordDeclinationSelector.swift'
    sp.framework = 'Foundation'
  end

  s.subspec 'ItemsScrollManager' do |sp|
    sp.source_files = 'Utils/ItemsScrollManager/ItemsScrollManager.swift'
    sp.framework = 'UIKit'
  end

  s.subspec 'KeyboardPresentable' do |sp|
    sp.source_files = 'Utils/KeyboardPresentable/*.swift'
    sp.framework = 'UIKit'
  end

  s.subspec 'SkeletonView' do |sp|
    sp.source_files = 'Utils/SkeletonView/*.swift', 'Utils/UIView/UIView+Masking.swift'
    sp.framework = 'UIKit'
  end

  s.subspec 'XibView' do |sp|
    sp.source_files = 'Utils/UIView/UIView+XibSetup.swift'
    sp.framework = 'UIKit'
  end

  s.subspec 'UIImageExtensions' do |sp|
    sp.source_files = 'Utils/UIImage/*.swift'
    sp.framework = 'UIKit'
  end

  s.subspec 'CommonButton' do |sp|
    sp.source_files = 'Utils/CommonButton/CommonButton.swift', 'Utils/UIImage/UIImageExtensions.swift'
    sp.framework = 'UIKit'
  end

  s.subspec 'LocalStorage' do |sp|
    sp.source_files = 'Utils/LocalStorage/LocalStorage.swift'
    sp.framework = 'Foundation'
  end

  s.subspec 'GeolocationService' do |sp|
    sp.source_files = 'Utils/GeolocationService/**/*.swift'
    sp.framework = 'Foundation', 'CoreLocation'
  end

  s.subspec 'UIDevice' do |sp|
    sp.source_files = 'Utils/UIDevice/UIDevice.swift', 'Utils/UIDevice/Support/iOS/Device.swift', 'Utils/UIDevice/Support/macOS/DeviceMacOS.swift', 'Utils/UIDevice/Support/Type.swift', 'Utils/UIDevice/Support/Version.swift', 'Utils/UIDevice/Support/Size.swift'
    sp.framework = 'UIKit'
  end

  s.subspec 'LayoutHelper' do |sp|
    sp.source_files = 'Utils/LayoutHelper/LayoutHelper.swift', 'Utils/UIDevice/UIDevice.swift', 'Utils/UIDevice/Support/iOS/Device.swift', 'Utils/UIDevice/Support/macOS/DeviceMacOS.swift', 'Utils/UIDevice/Support/Type.swift', 'Utils/UIDevice/Support/Version.swift', 'Utils/UIDevice/Support/Size.swift'
    sp.framework = 'UIKit'
  end

  s.subspec 'UIStyle' do |sp|
    sp.source_files = 'Utils/UIStyle/UIStyle.swift', 'Utils/UIStyle/AnyStyle.swift'
    sp.framework = 'UIKit'
  end

  s.subspec 'MailSender' do |sp|
    sp.source_files = 'Utils/MailSender/**/*.swift'
  end

  s.subspec 'LoadingView' do |sp|
    sp.source_files = 'Utils/LoadingView/**/*.swift', 'Utils/SkeletonView/*.swift', 'Utils/UIView/UIView+Masking.swift', 'Utils/UIView/UIView+XibSetup.swift'
    sp.framework = 'UIKit'
  end
  
  s.subspec 'SecurityService' do |sp|
    sp.source_files = 'Utils/SecurityService/**/*.swift'
    sp.framework = 'Foundation'
    sp.dependency 'CryptoSwift', '1.5.1'
  end

  s.subspec 'BeanPageControl' do |sp|
    sp.source_files = 'Utils/BeanPageControl/*.swift'
    sp.framework = 'UIKit'
  end

  s.subspec 'TouchableControl' do |sp|
    sp.source_files = 'Utils/UIControl/TouchableControl.swift'
    sp.framework = 'UIKit'
  end

  s.subspec 'CustomSwitch' do |sp|
    sp.source_files = 'Utils/CustomSwitch/*.swift'
    sp.framework = 'UIKit'
  end

  s.subspec 'MapRoutingService' do |sp|
    sp.source_files = 'Utils/MapRoutingService/*.swift'
    sp.framework = 'UIKit'
  end

end
