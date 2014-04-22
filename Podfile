#e Uncomment this line to define a global platform for your project
platform :ios, "7.0"

xcodeproj 'SoundCloudSearch'

pod 'RequestUtils'
pod 'RXPromise'

target :apptests, :exclusive => true  do
  link_with 'SoundCloudSearchTests'
  pod 'OCMock'
end

target :logictests  do
  link_with 'SoundCloudSearchLogicTests'
  pod 'OCMock'
end

