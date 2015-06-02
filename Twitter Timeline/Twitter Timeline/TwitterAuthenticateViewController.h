//
//  TwitterAuthenticateViewController.h
//  Twitter Timeline
//
//  Created by Chinthaka Perera on 6/2/15.
//  Copyright (c) 2015 Chinthaka Perera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterAuthenticateViewController : UIViewController

/**
 *  Send the received OAuth parameters to the handler.
 */
- (void)setOAuthToken:(NSString *)token
        oauthVerifier:(NSString *)verifier;

@end
