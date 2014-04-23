//
//  SCHomeViewController.m
//  SoundCloudSearch
//
//  Created by Brian Gerstle on 4/21/14.
//  Copyright (c) 2014 Brian Gerstle. All rights reserved.
//

#import "SCHomeViewController.h"

@interface SCHomeViewController ()
{
    UITabBarItem *_tabBarItem;
}
@property (nonatomic, strong, readwrite) UITableView *trackListView;
@end

@implementation SCHomeViewController

- (id)init
{
    self = [super init];
    if (self) {
        // automatically get notified whenever our "tracks" object changes
    }
    return self;
}

- (UITabBarItem*)tabBarItem
{
    if (!_tabBarItem) {
        // "Favorites" system item will give this tab bar item the "Favorites" label
        _tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:nil tag:0];
        _tabBarItem.accessibilityLabel = @"Home";
    }
    return _tabBarItem;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.trackListView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.trackListView];
    
    self.view.accessibilityIdentifier = @"home";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
