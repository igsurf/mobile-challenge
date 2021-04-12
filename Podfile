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
    pod 'SDKGithubServices', '0.1.9'

end