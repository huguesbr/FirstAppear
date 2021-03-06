Pod::Spec.new do |spec|
  spec.name         = 'FirstAppear'
  spec.platform 	= :ios
  spec.version      = '0.1.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/huguesbr/FirstAppear'
  spec.authors      = { 'Hugues Bernet-Rollande' => 'hugues@xdev.fr' }
  spec.summary      = 'Extend all viewController to include a view[Will/Did]FirstAppear method.'
  spec.source       = { :git => 'https://github.com/huguesbr/FirstAppear.git', :tag => 'v0.1.0' }
  spec.source_files = 'UIViewController+firstAppear.{h,m}'
  spec.framework    = 'UIKit'
end