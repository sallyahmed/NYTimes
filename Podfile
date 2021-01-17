# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!
def common_pods()
  pod 'RxCocoa'
  pod 'RxSwift'
  pod 'Moya/RxSwift'
  pod 'SwiftLint'
  pod 'SwiftFormat/CLI'
  pod 'AlamofireImage'
  pod 'OHHTTPStubs/Swift', '~> 8.0.0' 
end

target 'NYTimes' do
  # Comment the next line if you don't want to use dynamic frameworks
  common_pods
  # Pods for NYTimes

  target 'NYTimesTests' do
    inherit! :search_paths
    # Pods for testing
    common_pods
    pod 'Quick'
    pod 'Nimble'
    pod 'RxBlocking'
    pod 'RxTest'
  end

  target 'NYTimesUITests' do
    # Pods for testing
  end

end
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '5.1'
            config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
        end
    end
end
