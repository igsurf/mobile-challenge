#source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

def default_pods
    pod 'Alamofire'
    pod 'AlamofireImage'
    pod 'ReachabilitySwift'
end

target 'SafraChallenge' do
    default_pods
end

target 'SafraChallengeTests' do
    default_pods
    pod 'Nimble'
    pod 'Quick'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
	if target.name == 'AfroLayout' || target.name == 'ObjectMapper' || target.name == 'HanekeSwift' || target.name == 'SlideMenuControllerSwift'
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.3'
                config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
	        end
        end
    end
end
