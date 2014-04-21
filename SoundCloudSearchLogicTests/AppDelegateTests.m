//
//  AppDelegateTests.m
//  SoundCloudSearch
//
//  Created by Brian Gerstle on 4/20/14.
//  Copyright (c) 2014 Brian Gerstle. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"
@interface AppDelegateTests : XCTestCase
@property (nonatomic, strong) AppDelegate *appDelegate;
@end

@implementation AppDelegateTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _appDelegate = [[AppDelegate alloc] init];
    _appDelegate.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testShouldSetupRootTabControllerAfterLaunching
{
    XCTFail(@"Implement me!");
}

@end
