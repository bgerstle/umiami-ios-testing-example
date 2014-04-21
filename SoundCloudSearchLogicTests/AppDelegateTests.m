//
//  AppDelegateTests.m
//  SoundCloudSearch
//
//  Created by Brian Gerstle on 4/20/14.
//  Copyright (c) 2014 Brian Gerstle. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "AppDelegate.h"
@interface AppDelegateTests : XCTestCase
@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, strong) id mockWindow;
@end

@implementation AppDelegateTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _appDelegate = [[AppDelegate alloc] init];
    _mockWindow = [OCMockObject mockForClass:[UIWindow class]];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testShouldSetupRootTabControllerAfterLaunching
{
    [[_mockWindow expect] setRootViewController:OCMOCK_ANY];
    [[_mockWindow expect] makeKeyAndVisible];
    _appDelegate.window = _mockWindow;
	[_appDelegate application:nil didFinishLaunchingWithOptions:nil];
    XCTAssertNoThrow([_mockWindow verify], @"");
}

@end
