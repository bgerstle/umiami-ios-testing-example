//
//  NSIndexSet+NSIndexPathUtilsTests.m
//  SoundCloudSearch
//
//  Created by Brian Gerstle on 4/22/14.
//  Copyright (c) 2014 Brian Gerstle. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSIndexSet+NSIndexPathUtils.h"

@interface NSIndexSet_NSIndexPathUtilsTests : XCTestCase

@end

@implementation NSIndexSet_NSIndexPathUtilsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testConversion
{
	NSIndexSet *testIndexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)];
    NSArray *derivedIndexPaths = [testIndexSet asRowsOfIndexPathsInSection:0];
    XCTAssertEqualObjects(derivedIndexPaths[0], [NSIndexPath indexPathForRow:0 inSection:0], @"");
    XCTAssertEqualObjects(derivedIndexPaths[1], [NSIndexPath indexPathForRow:1 inSection:0], @"");
}

@end
