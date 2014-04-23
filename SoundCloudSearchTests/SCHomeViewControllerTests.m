//
//  SCHomeViewControllerTests.m
//  SoundCloudSearch
//
//  Created by Brian Gerstle on 4/22/14.
//  Copyright (c) 2014 Brian Gerstle. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SCHomeViewController.h"

@interface SCHomeViewControllerTests : XCTestCase
@property (nonatomic, strong) SCHomeViewController *homeViewController;
@end

@implementation SCHomeViewControllerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _homeViewController = [SCHomeViewController new];
    [[[[UIApplication sharedApplication] delegate] window] setRootViewController:_homeViewController];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testShouldShowEmptyListWhenTracksAreEmpty
{
    XCTAssertTrue(_homeViewController.trackListView && _homeViewController.trackListView.superview,
                  @"Can't find track list view!");
    
	XCTAssertEqual([_homeViewController.trackListView numberOfRowsInSection:0], 0, @"should have 0 tracks in list");
}

@end
