Pod::Spec.new do |s|
  s.name         = "LxFTPRequest"
  s.version      = "1.0.1"
  s.summary      = "A convenient FTP request library for iOS and Mac OS X. Support progress tracking, Breakpoint continuingly etc."

  s.homepage     = "https://github.com/DeveloperLx/LxFTPRequest"
  s.license      = 'Apache'
  s.authors      = { 'DeveloperLx' => 'developerlx@yeah.com' }
  s.platform     = :ios, "6.0"
  s.ios.deployment_target = "6.0"
  s.source       = { :git => "https://github.com/DeveloperLx/LxFTPRequest.git", :tag => s.version}
  s.source_files = 'LxFTPRequest/LxFTPRequest.*'
  s.requires_arc = true
  s.frameworks   = 'Foundation'
end
