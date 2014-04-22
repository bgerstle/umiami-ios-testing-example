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
@property (nonatomic, strong) UIViewController *dummyRootViewController;
@end

@implementation AppDelegateTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _dummyRootViewController = [UIViewController new];
    _mockWindow = [OCMockObject mockForClass:[UIWindow class]];
    _appDelegate = [[AppDelegate alloc] initWithWindow:_mockWindow
                                    rootViewController:_dummyRootViewController];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testShouldSetupRootViewControllerAfterLaunching
{
    [[_mockWindow expect] setRootViewController:_dummyRootViewController];
    [[_mockWindow expect] makeKeyAndVisible];
	[_appDelegate application:nil didFinishLaunchingWithOptions:nil];
    XCTAssertNoThrow([_mockWindow verify], @"");
}

@end
