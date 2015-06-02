//
//  TwitterTimelineViewController.h
//  Twitter Timeline
//
//  Created by Chinthaka Perera on 5/1/15.
//  Copyright (c) 2015 Chinthaka Perera. All rights reserved.
//
//  View Controller for view twitter timeline.

#import <UIKit/UIKit.h>
#import "TwitterAuthenticateHandler.h"

@interface TwitterTimelineViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) TwitterAuthenticateHandler *twitterAuthenticateHandler;

@end
