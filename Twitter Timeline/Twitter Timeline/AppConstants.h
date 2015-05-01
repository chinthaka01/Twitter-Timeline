//
//  AppConstants.h
//  Twitter Timeline
//
//  Created by Chinthaka Perera on 5/1/15.
//  Copyright (c) 2015 Chinthaka Perera. All rights reserved.
//
//  App constants that use by the application should be declaired here.

#import <Foundation/Foundation.h>

@interface AppConstants : NSObject

/**
 *  Returns a singleton instance of AppConstance.
 */
//+ (AppConstants *)sharedInstance;

/** The consumer key of the twitter developer account. */
@property (nonatomic, readonly, getter=getTwitterConsumerKey) NSString *consumerKey;

/** The consumer secret key of the twitter developer account. */
@property (nonatomic, readonly, getter=getTwitterConsumerSecret) NSString *consumerSecret;

/** callback URL for twitter user authentication. */
@property (nonatomic, readonly, getter=getTwitterCallbackUrl) NSString *callbackUrl;

@end
