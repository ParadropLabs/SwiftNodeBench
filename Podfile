use_frameworks!

platform :osx, '10.10'
pod 'Riffle', :git => 'https://github.com/ParadropLabs/riffle-swift'

post_install do |installer|
    installer.pods_project.build_configuration_list.build_configurations.each do |configuration|
        configuration.build_settings['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
    end
end