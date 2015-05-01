//
//  TwitterTimelineViewController.m
//  Twitter Timeline
//
//  Created by Chinthaka Perera on 5/1/15.
//  Copyright (c) 2015 Chinthaka Perera. All rights reserved.
//

#import "TwitterTimelineViewController.h"
#import "TwitterAuthenticateHandler.h"

@interface TwitterTimelineViewController ()

@property (nonatomic, strong) TwitterAuthenticateHandler *twitterAuthenticateHandler;

/** Tweets to show once in the view. */
@property (nonatomic, strong) NSMutableArray *tweets;

@property (nonatomic, weak) IBOutlet UIView *infoView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, weak) IBOutlet UILabel *infoLabel;
@property (nonatomic, weak) IBOutlet UIButton *signInButton;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

static float INFO_VIEW_VISIBILITY = .6f;

@implementation TwitterTimelineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.twitterAuthenticateHandler = [[TwitterAuthenticateHandler alloc] init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self configureViews];
    
    [self validateUser];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)configureViews
{
    [self.signInButton setAlpha:0.f];
}

- (void)validateUser
{
    [self.activityIndicator startAnimating];
    self.infoLabel.text = NSLocalizedString(@"Validating...", nil);
    
    [self.twitterAuthenticateHandler validateUserAuthenticationWithCompletionHandler:^(BOOL valid) {
        [self.activityIndicator stopAnimating];
        [self.infoView setAlpha:0.f];
        [self.view sendSubviewToBack:self.infoView];
        
        if (valid)
        {
            [self loadTwitterTimeline];
        }
        else
        {
           [self configureUserAuthentication];
        }
    }];
}

- (void)configureUserAuthentication
{
    self.infoLabel.text = NSLocalizedString(@"Autenticating...", nil);
    [self.infoView setAlpha:INFO_VIEW_VISIBILITY];
    [self.view bringSubviewToFront:self.infoView];
    [self.activityIndicator startAnimating];
    
    [self.twitterAuthenticateHandler authenticateWithCompletionHandler:^(id result, NSError *error) {
        [self.activityIndicator stopAnimating];
        
        if (error) {
            self.infoLabel.text = NSLocalizedString(@"Failed", nil);
            [self.signInButton setUserInteractionEnabled:YES];
        }
        else
        {
            [self.infoView setAlpha:0.f];
            [self.view sendSubviewToBack:self.infoView];
            [self.signInButton removeFromSuperview];
            
            [self loadTwitterTimeline];
        }
    }];
}

- (void)setOAuthToken:(NSString *)token oauthVerifier:(NSString *)verifier
{
    [self.twitterAuthenticateHandler setOAuthToken:token oauthVerifier:verifier];
}

- (IBAction)signIn:(id)sender
{
    [self configureUserAuthentication];
    
    [self.signInButton setUserInteractionEnabled:NO];
}

- (void)loadTwitterTimeline
{
    [self.activityIndicator startAnimating];
    self.infoLabel.text = NSLocalizedString(@"Loading", nil);
    
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
