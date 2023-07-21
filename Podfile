# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'Hearthstone' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Hearthstone
  
  post_install do |installer|
      installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
        end
      end
    end

  pod 'SDWebImage'

  target 'HearthstoneTests' do
    inherit! :search_paths
    # Pods for testing

    pod 'Quick', '5.0.1'
    pod 'Nimble', '10.0.0'
    pod 'Nimble-Snapshots', '9.4.0'
  end

  target 'HearthstoneUITests' do
    # Pods for testing
  end

end
