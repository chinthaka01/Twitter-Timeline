//
//  TwitterTimelineTableViewCell.h
//  Twitter Timeline
//
//  Created by Chinthaka Perera on 6/2/15.
//  Copyright (c) 2015 Chinthaka Perera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterTimelineTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *twitterStatusInfo;

@property (nonatomic, weak) IBOutlet UIImageView *profileImageView;
@property (nonatomic, weak) IBOutlet UILabel *twitterTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *screenNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *createdDateLabel;

@end
