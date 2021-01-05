#
# Be sure to run `pod lib lint ObjcUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ObjcUI'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ObjcUI.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ruiq/ObjcUI'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ruiq' => 'theruiq@gmail.com' }
  s.source           = { :git => 'https://github.com/ruiq/ObjcUI.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'Source/*.{h,m}'
  
  # s.resource_bundles = {
  #   'ObjcUI' => ['ObjcUI/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Masonry', '~> 1.1.0'
  s.dependency 'JKCategories', '~> 1.9.1'
end
