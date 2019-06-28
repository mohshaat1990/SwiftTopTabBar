
Pod::Spec.new do |s|
  s.name             = 'SwiftTopTabBar'
  s.version          = '0.1.0'
  s.summary          = 'Swift Top Tab Bar'
  s.description      = <<-DESC
SwiftTopTabBar is swift library to create top tab bar like android in iOS
DESC
 
  s.homepage         = 'https://github.com/sh3at90/SwiftTopTabBar.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '<MOHAMED MAHMOUD>' => '<mohamed.sh3t90@gmail.com>' }
  s.source           = { :git => 'https://github.com/sh3at90/SwiftTopTabBar.git', :tag => s.version.to_s  }
 
  s.ios.deployment_target = '11.0'
  s.source_files = 'TabBar/SourceCode/**/*.{lproj,storyboard,xcdatamodeld,xib,swift}'
 
end