source 'https://github.com/gabrielsousaleal/pod-specs.git'

target 'teste-safra' do

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |configuration|
      target.build_settings(configuration.name)['ONLY_ACTIVE_ARCH'] = 'YES'
    end
  end
end

  # Pods for teste-safra
    pod 'SDKGithubServices/Debug', '0.2.4'

target 'teste-safraTests' do
 use_frameworks!
end

end