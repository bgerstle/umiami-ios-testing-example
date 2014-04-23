//
//  NSIndexSet+NSIndexPathUtils.h
//  SoundCloudSearch
//
//  Created by Brian Gerstle on 4/22/14.
//  Copyright (c) 2014 Brian Gerstle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSIndexSet (NSIndexPathUtils)

- (NSArray*)asRowsOfIndexPathsInSection:(NSUInteger)section;

@end
