//
//  TwitterDetailViewController.m
//  Twitter Timeline
//
//  Created by Chinthaka Perera on 6/2/15.
//  Copyright (c) 2015 Chinthaka Perera. All rights reserved.
//

#import "TwitterDetailViewController.h"

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

@end
