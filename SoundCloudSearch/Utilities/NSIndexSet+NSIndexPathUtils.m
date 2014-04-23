//
//  NSIndexSet+NSIndexPathUtils.m
//  SoundCloudSearch
//
//  Created by Brian Gerstle on 4/22/14.
//  Copyright (c) 2014 Brian Gerstle. All rights reserved.
//

#import "NSIndexSet+NSIndexPathUtils.h"

@implementation NSIndexSet (NSIndexPathUtils)

- (NSArray*)asRowsOfIndexPathsInSection:(NSUInteger)section
{
	NSMutableArray *indexPaths = [[NSMutableArray alloc] initWithCapacity:[self count]];
    [self enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
    	[indexPaths addObject:[NSIndexPath indexPathForRow:idx inSection:section]];
    }];
    return indexPaths;
    
}

@end
