#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint fancy_toast.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'fancy_toast'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin for custom Toast notifications.'
  s.description      = <<-DESC
A Flutter plugin to show custom Toast notifications with various styles and icons.
                       DESC
  s.homepage         = 'https://github.com/xianwen-zhu/flutter_fancy_toast'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'xianwen-zhu' => 'fmxianwen@gmail.com' }
  s.source           = { :git => 'https://github.com/xianwen-zhu/flutter_fancy_toast.git', :tag => s.version.to_s }
  s.source_files     = 'Classes/**/*'
  s.resource_bundles = {'Image_Picker'=>['Assets/*.png']}
  s.dependency       'Flutter'
  s.platform         = :ios, '11.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version    = '5.0'
end
