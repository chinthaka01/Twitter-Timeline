//
//  TwitterAuthenticateHandler.h
//  Twitter Timeline
//
//  Created by Chinthaka Perera on 5/1/15.
//  Copyright (c) 2015 Chinthaka Perera. All rights reserved.
//  Helper class for handle the twitter authentication.

#import <Foundation/Foundation.h>

@interface TwitterAuthenticateHandler : NSObject

/**
 *  Validate whether already signed in to the app.
 */
- (void)validateUserAuthenticationWithCompletionHandler:(void (^)(BOOL))handler;

/**
 *  Perform user sign in.
 */
- (void)authenticateWithCompletionHandler:(void (^)(id, NSError *))handler;

/**
 *  Save the OAuth parameters and notify to the view controller about the status.
 */
- (void)setOAuthToken:(NSString *)token oauthVerifier:(NSString *)verifier;

@end
