Pod::Spec.new do |s|

  s.name                 = "MKShowDetail"
  s.version              = "0.0.3"
  s.summary              = "Show shopdetail,like ele,meituan etc"
  s.homepage             = "https://github.com/Mekor/MKShowDetail"
  s.license              = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Mekor" => "mekor@live.cn" }
  s.social_media_url   = "http://weibo.com/gliii"
  s.platform             = :ios, "7.0"
  s.source               = { :git => "https://github.com/Mekor/MKShowDetail.git", :tag => s.version }
  s.source_files          = "MKShowDetail/*.{h,m}"
  s.resources          = "MKShowDetail/*.{xib,jpg,png}"
  s.requires_arc         = true
  s.frameworks = 'UIKit'                  #所需的framework，多个用逗号隔开

end