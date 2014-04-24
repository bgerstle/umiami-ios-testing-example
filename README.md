# umiami-ios-testing-example

## Requirements
- OS X 10.8+
- Xcode 5+
- Ruby (comes installed by default on OSX)

## Getting Started
Run the bootstrap script: `./bootstrap.sh` (see contents for details).

## Testing
The `Rakefile` loads all rake tasks (`*.rake`) & ruby helpers (`*.rb`) in the `tasks/` folder.
Run `rake -T` from the root directory of the repo to see a list of all available tasks and their descriptions.

## Test Framework References
- [OCMock Documentation](http://ocmock.org/) (ObjC mocking library)
- [UIAutomation Javascript Reference](https://developer.apple.com/library/ios/documentation/DeveloperTools/Reference/UIAutomationRef/_index.html) (Javascript app automation)
- [tuneup.js](http://www.tuneupjs.org/writing.html) (Javascript extension for UIAutomation)
- [mechanic.js](https://github.com/jaykz52/mechanic) (Javascript extension for UIAutomation)
- [bwoken](https://github.com/bendyworks/bwoken) (UIAutomation test runner written in Ruby)
