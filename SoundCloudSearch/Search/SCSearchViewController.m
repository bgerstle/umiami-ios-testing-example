//
//  SCSearchViewController.m
//  SoundCloudSearch
//
//  Created by Brian Gerstle on 4/21/14.
//  Copyright (c) 2014 Brian Gerstle. All rights reserved.
//

#import "SCSearchViewController.h"

@interface SCSearchViewController ()
{
    UITabBarItem *_tabBarItem;
}
@end

@implementation SCSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UITabBarItem*)tabBarItem
{
    if (!_tabBarItem) {
        _tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:0];
        _tabBarItem.accessibilityLabel = @"Search";
    }
    return _tabBarItem;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.accessibilityIdentifier = @"search";
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
