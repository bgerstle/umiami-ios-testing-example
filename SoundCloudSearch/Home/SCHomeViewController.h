//
//  SCHomeViewController.h
//  SoundCloudSearch
//
//  Created by Brian Gerstle on 4/21/14.
//  Copyright (c) 2014 Brian Gerstle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCHomeViewController : UIViewController

@property (nonatomic, strong, readonly) UITableView *trackListView;
@property (nonatomic, strong) NSMutableArray *tracks;

@end
