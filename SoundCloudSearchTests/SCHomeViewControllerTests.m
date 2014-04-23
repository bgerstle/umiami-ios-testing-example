//
//  SCHomeViewControllerTests.m
//  SoundCloudSearch
//
//  Created by Brian Gerstle on 4/22/14.
//  Copyright (c) 2014 Brian Gerstle. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SCHomeViewController.h"


static id scs_createDummyTrackWithTitle(NSString *title)
{
    return @{@"title": title};
}

static NSArray* scs_createDummyTracks(NSArray *dummyTrackTitles)
{
    NSMutableArray * dummyTracks = [[NSMutableArray alloc] initWithCapacity:[dummyTrackTitles count]];
    [dummyTrackTitles enumerateObjectsUsingBlock:^(NSString *dummyTitle, NSUInteger idx, BOOL *stop) {
        id dummyTrack = scs_createDummyTrackWithTitle(dummyTitle);
        [dummyTracks addObject:dummyTrack];
    }];
    return dummyTracks;
}

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

- (void)testShouldShowCurrentTracksInList
{
    _homeViewController.tracks = [NSMutableArray new];
    NSMutableArray *tracksProxy = [_homeViewController mutableArrayValueForKey:@"tracks"];
    
    NSArray *dummyTracks = scs_createDummyTracks(@[@"A", @"B"]);
    
    // addition
    [tracksProxy addObjectsFromArray:dummyTracks];
    XCTAssertEqual([_homeViewController.trackListView numberOfRowsInSection:0], 2,
                   @"didn't update table after adding tracks");
    
    // substitution
    NSDictionary *trackC = scs_createDummyTrackWithTitle(@"C");
    [tracksProxy replaceObjectAtIndex:0 withObject:trackC];
    XCTAssertEqual([_homeViewController.trackListView numberOfRowsInSection:0], 1,
                   @"replacing should preserve number of rows.");
    UITableViewCell *trackCCell = [_homeViewController.trackListView cellForRowAtIndexPath:
                                   [NSIndexPath indexPathForRow:0 inSection:0]];
    XCTAssertEqualObjects(trackCCell.textLabel.text, @"C", @"Should be showing track C since we replaced A");
    
    // deletion
    [tracksProxy removeObjectAtIndex:1];
    XCTAssertEqual([_homeViewController.trackListView numberOfRowsInSection:0], 1,
                   @"should only have 1 row after removing a track");
    UITableViewCell *trackBCell = [_homeViewController.trackListView cellForRowAtIndexPath:
                                   [NSIndexPath indexPathForRow:0 inSection:0]];
    XCTAssertEqualObjects(trackBCell.textLabel.text, @"B", @"Should be showing track C since we removed B");
}

@end
