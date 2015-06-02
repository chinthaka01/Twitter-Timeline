//
//  TwitterTimelineViewController.m
//  Twitter Timeline
//
//  Created by Chinthaka Perera on 5/1/15.
//  Copyright (c) 2015 Chinthaka Perera. All rights reserved.
//

#import "TwitterTimelineViewController.h"
#import "SDWebImageManager.h"
#import "TwitterTimelineTableViewCell.h"
#import "TwitterDetailViewController.h"

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"TwitterStatusDetailViewSegue"])
    {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        TwitterTimelineTableViewCell *cell = (TwitterTimelineTableViewCell *)[self.tableView cellForRowAtIndexPath:selectedIndexPath];
        [(TwitterDetailViewController *)segue.destinationViewController setTwitterStatusInfo:cell.twitterStatusInfo];
    }
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
    TwitterTimelineTableViewCell *cell = (TwitterTimelineTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TwitterTimelineTableViewCell"];
    
    if(cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TwitterTimelineTableViewCell" owner:nil options:nil];
        cell = topLevelObjects[0];
    }
    
    NSDictionary *status = [self.tweets objectAtIndex:indexPath.row];
    NSDictionary *userInfo = [status valueForKey:@"user"];
    cell.twitterStatusInfo = [NSDictionary dictionaryWithDictionary:status];
    
    NSString *text = [status valueForKey:@"text"];
    NSString *screenName = [userInfo valueForKeyPath:@"screen_name"];
    NSString *dateString = [status valueForKey:@"created_at"];
    NSString *profileImaeUrl = [userInfo valueForKey:@"profile_image_url"];
    
    NSURL *url = [NSURL URLWithString:profileImaeUrl];
    
    UIImage *placeholderImage = [UIImage imageNamed:@"TimelineFeedThumb"];
    
    __weak UIImageView *promoView = cell.profileImageView;
    promoView.image = placeholderImage;
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:url
                          options:SDWebImageContinueInBackground
                         progress:^(NSInteger receivedSize, NSInteger expectedSize)
     {
         //         [_activityIndicator startAnimating];
     }
                        completed:^(UIImage *image,
                                    NSError *error,
                                    SDImageCacheType cacheType,
                                    BOOL finished,
                                    NSURL *imageURL)
     {
         if (image)
         {
             //             [_activityIndicator stopAnimating];
             promoView.image = image;
             [promoView setNeedsLayout];
         }
         else
         {
             //             [_activityIndicator stopAnimating];
                          promoView.image = placeholderImage;
         }
     }];
    
    cell.twitterTextLabel.text = text;
    cell.screenNameLabel.text = screenName;
    cell.createdDateLabel.text = dateString;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"TwitterStatusDetailViewSegue" sender:self];
}

@end
