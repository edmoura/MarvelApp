project 'MarvelApp.xcodeproj'

platform :ios, '9.1'
source 'https://github.com/CocoaPods/Specs.git'
inhibit_all_warnings!
use_frameworks!

def shared_pods

  # Network
  pod 'Alamofire'
  pod 'Kingfisher'

  #Mapper
  pod 'ObjectMapper'
  pod 'AlamofireObjectMapper'
    
  #Crypt 
  pod 'CryptoSwift'

  #Motion
  pod 'Hero'

  #Gradient
  pod 'EZYGradientView', :git => 'https://github.com/Niphery/EZYGradientView'

end

target 'MarvelApp' do
  
  use_frameworks!

  plugin 'cocoapods-keys', {
    :project => "MarvelApp",
    :target => "MarvelApp",
    :keys => [
      "MarvelApiKey",
      "MarvelPrivateKey"
  ]}

  # Shared pods
  shared_pods

end

target 'MarvelAppTests' do

  use_frameworks!
  inherit! :search_paths

  pod 'Quick'
  pod 'Nimble'
  pod 'ObjectMapper'

end

