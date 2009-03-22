//
//  AccountCredentials.h
//  JoeMetric
//
//  Created by Paul Wilson on 22/03/2009.
//  Copyright 2009 Mere Complexities Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RestConfiguration : NSObject {

}

+(NSString*) host;
+(NSInteger) port;
+(NSString*) username;
+(NSString*) password;
+(void) setUsername:(NSString*)username;
+(void) setPassword:(NSString*)password;
+(NSURLCredential*) urlCredential;


@end
