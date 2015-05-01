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
    void (^_completionCallBackHandler)(id, NSError *);
}

- (void)validateUserAuthenticationWithCompletionHandler:(void (^)(BOOL))handler
{
    NSString *oauthToken = [DDDKeychainWrapper stringForKey:@"oauthToken"];
    NSString *oauthTokenSecret = [DDDKeychainWrapper stringForKey:@"oauthTokenSecret"];
    
    BOOL valid = NO;
    
    if (oauthToken.length > 0 && oauthTokenSecret.length > 0)
    {
        valid = YES;
    }
    
    handler(valid);
}

- (void)authenticateWithCompletionHandler:(void (^)(id, NSError *))handler
{
    _completionCallBackHandler = [handler copy];
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
                        _completionCallBackHandler(nil, error);
                    }];
}

- (void)setOAuthToken:(NSString *)token oauthVerifier:(NSString *)verifier
{
    [_twitter postAccessTokenRequestWithPIN:verifier successBlock:^(NSString *oauthToken, NSString *oauthTokenSecret, NSString *userID, NSString *screenName)
    {
        [DDDKeychainWrapper setString:oauthToken forKey:@"oauthToken"];
        [DDDKeychainWrapper setString:oauthTokenSecret forKey:@"oauthTokenSecret"];
        
        _completionCallBackHandler(nil, nil);
        
        /*
         At this point, the user can use the API and you can read his access tokens with:
         
         _twitter.oauthAccessToken;
         _twitter.oauthAccessTokenSecret;
         
         You can store these tokens (in user default, or in keychain) so that the user doesn't need to authenticate again on next launches.
         
         Next time, just instanciate STTwitter with the class method:
         
         +[STTwitterAPI twitterAPIWithOAuthConsumerKey:consumerSecret:oauthToken:oauthTokenSecret:]
         
         Don't forget to call the -[STTwitter verifyCredentialsWithSuccessBlock:errorBlock:] after that.
         */
    } errorBlock:^(NSError *error)
    {
        _completionCallBackHandler(nil, error);
    }];
}

@end
