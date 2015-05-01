//
//  ViewController.m
//  Twitter Timeline
//
//  Created by Chinthaka Perera on 5/1/15.
//  Copyright (c) 2015 Chinthaka Perera. All rights reserved.
//

#import "ViewController.h"
#import "STTwitterAPI.h"
#import "AppConstants.h"

@interface ViewController ()

//@property (nonatomic, strong) STTwitterAPI *twitter;

@end

@implementation ViewController
{
    
}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//}
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    [self loginOnTheWebAction:nil];
//}
//
//- (void)setOAuthToken:(NSString *)token oauthVerifier:(NSString *)verifier
//{
//    [_twitter postAccessTokenRequestWithPIN:verifier successBlock:^(NSString *oauthToken, NSString *oauthTokenSecret, NSString *userID, NSString *screenName) {
//        NSLog(@"-- screenName: %@", screenName);
//        
//        /*
//         At this point, the user can use the API and you can read his access tokens with:
//         
//         _twitter.oauthAccessToken;
//         _twitter.oauthAccessTokenSecret;
//         
//         You can store these tokens (in user default, or in keychain) so that the user doesn't need to authenticate again on next launches.
//         
//         Next time, just instanciate STTwitter with the class method:
//         
//         +[STTwitterAPI twitterAPIWithOAuthConsumerKey:consumerSecret:oauthToken:oauthTokenSecret:]
//         
//         Don't forget to call the -[STTwitter verifyCredentialsWithSuccessBlock:errorBlock:] after that.
//         */
//        
//    } errorBlock:^(NSError *error) {
//        NSLog(@"-- %@", [error localizedDescription]);
//    }];
//}
//
//- (IBAction)loginOnTheWebAction:(id)sender
//{
//    AppConstants *appConstants = [[AppConstants alloc] init];
//    
//    self.twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:[appConstants getTwitterConsumerKey]
//                                                 consumerSecret:[appConstants getTwitterConsumerSecret]];
//    
//    [_twitter postTokenRequest:^(NSURL *url, NSString *oauthToken) {
//        [[UIApplication sharedApplication] openURL:url];
//    } authenticateInsteadOfAuthorize:NO
//                    forceLogin:@(YES)
//                    screenName:nil
//                 oauthCallback:[appConstants getTwitterCallbackUrl]
//                    errorBlock:^(NSError *error) {
//                        NSLog(@"-- error: %@", error);
////                        _loginStatusLabel.text = [error localizedDescription];
//                    }];
//    
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}

@end
