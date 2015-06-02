//
//  TwitterDetailViewController.m
//  Twitter Timeline
//
//  Created by Chinthaka Perera on 6/2/15.
//  Copyright (c) 2015 Chinthaka Perera. All rights reserved.
//

#import "TwitterDetailViewController.h"
#import "SDWebImageManager.h"

@interface TwitterDetailViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *profileImageView;
@property (nonatomic, weak) IBOutlet UILabel *userNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *userDescriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *textLabel;

@end

@implementation TwitterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self configureView];
}

- (void)configureView
{
    NSDictionary *userInfo = [self.twitterStatusInfo valueForKey:@"user"];
    self.userNameLabel.text = [userInfo valueForKey:@"name"];
    self.userDescriptionLabel.text = [userInfo valueForKey:@"description"];
    self.textLabel.text = [self.twitterStatusInfo valueForKey:@"text"];
    
    [self configureProfileThumbImageView:userInfo];
}

- (void)configureProfileThumbImageView:(NSDictionary *)userInfo
{
    NSString *profileImaeUrl = [userInfo valueForKey:@"profile_image_url"];
    
    NSURL *url = [NSURL URLWithString:profileImaeUrl];
    
    UIImage *placeholderImage = [UIImage imageNamed:@"TimelineFeedThumb"];
    
    __weak UIImageView *promoView = self.profileImageView;
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
}

@end
