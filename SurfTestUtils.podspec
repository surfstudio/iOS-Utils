Pod::Spec.new do |s|

  s.name = "SurfTestUtils"
  s.version = "11.0.1"
  s.summary = "Contains a set of utils in subspecs"
  s.description  = <<-DESC
  Contains:
    - Utils for easy SnapshotTesting
                   DESC

  s.homepage  = "https://github.com/surfstudio/ios-utils"
  s.license  = { :type => "MIT", :file => "LICENSE" }
  s.author  = { "Alexander Kravchenkov" => "akravchenkov@surfstudio.co" }
  s.source = { :git => "https://github.com/surfstudio/ios-utils.git", :branch => "snapshot-tests-test-spec" }
  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'

  s.subspec 'SnapshotTests' do |sp|
    sp.source_files = 'Utils/Utils/SnapshotTests/*.swift'
    sp.framework = 'UIKit'
    sp.dependency 'SnapshotTesting', '1.8.2'
  end

end
