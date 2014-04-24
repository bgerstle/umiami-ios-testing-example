//
//  SCHomeViewController.m
//  SoundCloudSearch
//
//  Created by Brian Gerstle on 4/21/14.
//  Copyright (c) 2014 Brian Gerstle. All rights reserved.
//

#import "SCHomeViewController.h"
#import "NSIndexSet+NSIndexPathUtils.h"

#define kTrackTableCellReuseID @"TrackTableCellReuseID"

static void* const kTracksKVOContext = (void*)&kTracksKVOContext;

@interface SCHomeViewController ()
<UITableViewDataSource, UITableViewDelegate>
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
        [self addObserver:self
               forKeyPath:@"tracks"
                  options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                  context:kTracksKVOContext];
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
    self.trackListView.delegate = self;
    self.trackListView.dataSource = self;
    [self.trackListView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTrackTableCellReuseID];
    self.trackListView.allowsSelection = NO;
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

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

- (int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tracks count];
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTrackTableCellReuseID];
    cell.textLabel.text = _tracks[indexPath.row][@"title"];
    return cell;
}

#pragma mark - Tracks Change Callbacks

- (void)didSetTracks:(NSArray*)newTracks previousTracks:(NSArray*)previousTracks
{
    [self.trackListView reloadData];
}

- (void)didInsertTracksAtIndexes:(NSIndexSet*)indexes
{
	[self.trackListView insertRowsAtIndexPaths:[indexes asRowsOfIndexPathsInSection:0]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)didRemoveTracksAtIndexes:(NSIndexSet*)indexes
{
	[self.trackListView deleteRowsAtIndexPaths:[indexes asRowsOfIndexPathsInSection:0]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)didReplaceTracksAtIndexes:(NSIndexSet*)indexes
{
    [self.trackListView reloadRowsAtIndexPaths:[indexes asRowsOfIndexPathsInSection:0]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
	if (context == kTracksKVOContext) {
        switch ([change[NSKeyValueChangeKindKey] integerValue]) {
            case NSKeyValueChangeInsertion:
                [self didInsertTracksAtIndexes:change[NSKeyValueChangeIndexesKey]];
                break;
            case NSKeyValueChangeRemoval:
                [self didRemoveTracksAtIndexes:change[NSKeyValueChangeIndexesKey]];
                break;
            case NSKeyValueChangeReplacement:
                [self didReplaceTracksAtIndexes:change[NSKeyValueChangeIndexesKey]];
                break;
            case NSKeyValueChangeSetting:
                [self didSetTracks:change[NSKeyValueChangeNewKey]
                    previousTracks:change[NSKeyValueChangeOldKey]];
                break;
                
            default:
                break;
        }
    } else if ([super respondsToSelector:@selector(observeValueForKeyPath:ofObject:change:context:)]) {
        // make sure we inform "super" about any changes we're not observing in our subclass implementation
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
