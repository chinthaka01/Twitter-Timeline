//
//  AppConstants.m
//  Twitter Timeline
//
//  Created by Chinthaka Perera on 5/1/15.
//  Copyright (c) 2015 Chinthaka Perera. All rights reserved.
//

#import "AppConstants.h"

@implementation AppConstants

@synthesize consumerKey = _consumerKey;
@synthesize consumerSecret = _consumerSecret;
@synthesize callbackUrl = _callbackUrl;

//+ (AppConstants *)sharedInstance
//{
//    static AppConstants *_sharedInstance = nil;
//    static dispatch_once_t oncePredicate;
//    
//    dispatch_once(&oncePredicate, ^{
//        _sharedInstance = [[AppConstants alloc] init];
//    });
//    
//    return _sharedInstance;
//}

- (NSString *)getTwitterConsumerKey
{
    if (!_consumerKey)
    {
        _consumerKey = @"glXmwhrXxYj1RjE7GG9NonmZi";
    }
    
    return _consumerKey;
}

- (NSString *)getTwitterConsumerSecret
{
    if (!_consumerSecret)
    {
        _consumerSecret = @"DeoMKBC03PSeuiUo3gYccLLrTanUDFMKdrTkbA338hXCDtUOPU";
    }
    
    return _consumerSecret;
}

- (NSString *)getTwitterCallbackUrl
{
    if (!_callbackUrl)
    {
        _callbackUrl = @"twittertimeline://twitter_access_tokens/";
    }
    
    return _callbackUrl;
}

@end
