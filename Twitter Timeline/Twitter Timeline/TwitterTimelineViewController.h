//
//  TwitterTimelineViewController.h
//  Twitter Timeline
//
//  Created by Chinthaka Perera on 5/1/15.
//  Copyright (c) 2015 Chinthaka Perera. All rights reserved.
//
//  View Controller for view twitter timeline.

#import <UIKit/UIKit.h>

@interface TwitterTimelineViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

/**
 *  Send the received OAuth parameters to the handler. 
 */
- (void)setOAuthToken:(NSString *)token
        oauthVerifier:(NSString *)verifier;

@end
