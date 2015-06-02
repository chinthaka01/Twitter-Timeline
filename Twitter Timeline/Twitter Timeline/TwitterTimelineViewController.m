//
//  TwitterTimelineViewController.m
//  Twitter Timeline
//
//  Created by Chinthaka Perera on 5/1/15.
//  Copyright (c) 2015 Chinthaka Perera. All rights reserved.
//

#import "TwitterTimelineViewController.h"

@interface TwitterTimelineViewController ()

/** Tweets to show once in the view. */
@property (nonatomic, strong) NSMutableArray *tweets;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation TwitterTimelineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self loadTwitterTimeline];
}

- (void)loadTwitterTimeline
{
//    [self.activityIndicator startAnimating];
//    self.infoLabel.text = NSLocalizedString(@"Loading", nil);
    
    [self.twitterAuthenticateHandler requestTwitterTimelineWithCompletionHandler:^(NSArray *response, NSError *error) {
        self.tweets = [NSMutableArray arrayWithArray:response];
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source methods.

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwitterTVCellIdentifier"];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TwitterTVCellIdentifier"];
    }
    
    NSDictionary *status = [self.tweets objectAtIndex:indexPath.row];
    
    NSString *text = [status valueForKey:@"text"];
    NSString *screenName = [status valueForKeyPath:@"user.screen_name"];
    NSString *dateString = [status valueForKey:@"created_at"];
    
    cell.textLabel.text = text;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"@%@ | %@", screenName, dateString];
    
    return cell;
}

@end
