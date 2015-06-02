//
//  TwitterAuthenticateHandler.m
//  Twitter Timeline
//
//  Created by Chinthaka Perera on 5/1/15.
//  Copyright (c) 2015 Chinthaka Perera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterAuthenticateHandler.h"
#import "DDDKeychainWrapper.h"
#import "AppConstants.h"
#import "STTwitterAPI.h"

@implementation TwitterAuthenticateHandler
{
    STTwitterAPI *_twitter;
    
    /** Completion block for perform tasks after user validation. */
    void (^_authenticationCompletionCallBackHandler)(id, NSError *);
   
    /** Completion block for perform tasks after retreive timeline statuses. */
    void (^_timelineCompletionCallBackHandler)(id, NSError *);
}

- (void)validateUserAuthenticationWithCompletionHandler:(void (^)(BOOL))handler
{
    NSString *oauthToken = [DDDKeychainWrapper stringForKey:@"oauthToken"];
    NSString *oauthTokenSecret = [DDDKeychainWrapper stringForKey:@"oauthTokenSecret"];
    
    BOOL valid = NO;
    
    AppConstants *appConstants = [[AppConstants alloc] init];
    
    if (oauthToken.length > 0 && oauthTokenSecret.length > 0)
    {
        valid = YES;
        
        _twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:[appConstants getTwitterConsumerKey]
                                                 consumerSecret:[appConstants getTwitterConsumerSecret]
                                                     oauthToken:[DDDKeychainWrapper stringForKey:@"oauthToken"]
                                               oauthTokenSecret:[DDDKeychainWrapper stringForKey:@"oauthTokenSecret"]];
    }
    else
    {
        _twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:[appConstants getTwitterConsumerKey]
                                                 consumerSecret:[appConstants getTwitterConsumerSecret]];
    }
    
    handler(valid);
}

- (void)authenticateWithCompletionHandler:(void (^)(id, NSError *))handler
{
    _authenticationCompletionCallBackHandler = [handler copy];
    [self signIn];
}

- (void)signIn
{
    AppConstants *appConstants = [[AppConstants alloc] init];
    
    _twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:[appConstants getTwitterConsumerKey]
                                                 consumerSecret:[appConstants getTwitterConsumerSecret]];
    
    [_twitter postTokenRequest:^(NSURL *url, NSString *oauthToken)
    {
        [[UIApplication sharedApplication] openURL:url];
    } authenticateInsteadOfAuthorize:NO
                    forceLogin:@(YES)
                    screenName:nil
                 oauthCallback:[appConstants getTwitterCallbackUrl]
                    errorBlock:^(NSError *error)
    {
                        _authenticationCompletionCallBackHandler(nil, error);
                    }];
}

- (void)setOAuthToken:(NSString *)token oauthVerifier:(NSString *)verifier
{
    [_twitter postAccessTokenRequestWithPIN:verifier successBlock:^(NSString *oauthToken, NSString *oauthTokenSecret, NSString *userID, NSString *screenName)
    {
        [DDDKeychainWrapper setString:oauthToken forKey:@"oauthToken"];
        [DDDKeychainWrapper setString:oauthTokenSecret forKey:@"oauthTokenSecret"];
        
        _authenticationCompletionCallBackHandler(nil, nil);
    } errorBlock:^(NSError *error)
    {
        _authenticationCompletionCallBackHandler(nil, error);
    }];
}

- (void)requestTwitterTimelineWithCompletionHandler:(void (^)(id, NSError *))handler
{
    _timelineCompletionCallBackHandler = [handler copy];
    
    [_twitter getHomeTimelineSinceID:nil
                               count:20
                        successBlock:^(NSArray *statuses) {
                            NSArray *visibleTweets = [self storeTweets:statuses];
                            _timelineCompletionCallBackHandler(visibleTweets, nil);
                        } errorBlock:^(NSError *error) {
                            _timelineCompletionCallBackHandler(nil, error);
                        }];
}

- (NSArray *)storeTweets:(NSArray *)tweets
{
    // ~~ Here we need to store the received tweets in the DB ~~~ //
    
    
//    int rowLimitation = 10;
//    
//    NSArray *visibleTweets;
//    
//    if (tweets.count > rowLimitation)
//    {
//        visibleTweets = [tweets subarrayWithRange:NSMakeRange(0, rowLimitation)];
//    }
//    else
//    {
//        visibleTweets = [NSArray arrayWithArray:tweets];
//    }
//    
//    return visibleTweets;
    return tweets;
}

@end
