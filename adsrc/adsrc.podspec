#
# Be sure to run `pod lib lint adsrc.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'adsrc'
  s.version          = '0.1.0'
  s.summary          = 'A short description of adsrc.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.resources = ['BUAD/BUAdSDK.bundle']
  s.homepage         = 'https://github.com/admin@qq.com/adsrc'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'admin@qq.com' => 'admin@qq.com' }
  s.source           = { :git => 'https://github.com/admin@qq.com/adsrc.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.vendored_frameworks = "BUAD/*.framework"
  s.ios.deployment_target = '8.0'

  s.source_files = 'adsrc/Classes/**/*'
  s.public_header_files = 'adsrc/Classes/AdHelper.h'
  s.libraries = "c++" , "sqlite3", "resolv"
  
  wv_script = <<-EOF
  FMK_NAME=${PROJECT_NAME}
  if [ "${ACTION}" = "build" ]
    then
    INSTALL_DIR=${SRCROOT}/Products/adsrc
    DEVICE_DIR=${BUILD_ROOT}/${CONFIGURATION}-iphoneos/adsrc
    SIMULATOR_DIR=${BUILD_ROOT}/${CONFIGURATION}-iphonesimulator/adsrc
    
    # -configuration ${CONFIGURATION}
    # Clean and Building both architectures.
    #xcodebuild -configuration "Release" -target "${FMK_NAME}" -sdk iphoneos clean build
    #xcodebuild -configuration "Release" -target "${FMK_NAME}" -sdk iphonesimulator clean build
    
    if [ -d "${INSTALL_DIR}" ]
      then
      rm -rf "${INSTALL_DIR}"
    fi
    mkdir -p "${INSTALL_DIR}"
    cp -R "${DEVICE_DIR}/" "${INSTALL_DIR}/"
    #ditto "${DEVICE_DIR}/Headers" "${INSTALL_DIR}/Headers"
    lipo -create "${DEVICE_DIR}/libadsrc.a" "${SIMULATOR_DIR}/libadsrc.a" -output "${INSTALL_DIR}/libadsrc.a"
    #这个是合并完成后打开对应的文件夹，你就可以直接看到文件了
    open "${SRCROOT}/Products/adsrc"
  fi
  EOF
  s.script_phase = { :name => 'rebuild_a', :script => wv_script, :execution_position => :after_compile }
  # s.resource_bundles = {
  #   'adsrc' => ['adsrc/Assets/*.png']
  # }
  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'CoreMotion'
  # s.dependency 'AFNetworking', '~> 2.3'
end
