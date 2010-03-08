//
//  RestRequest.h
//  funeral
//
//  Created by Allerin on 09-9-18.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestRequest : NSObject 
{
}


+ (NSData *)doGetWithUrl:(NSString *)baseUrl Error:(NSError **)error returningResponse:(NSURLResponse **)response;
+ (NSData *)doPostWithUrl:(NSString *)baseUrl Body:(NSString *)body Error:(NSError **)error returningResponse:(NSURLResponse **)response;
+ (NSData *)doPutWithUrl:(NSString *)baseUrl Body:(NSString *)body Error:(NSError **)error returningResponse:(NSURLResponse **)response;
+ (NSData *)failedResponse:(NSData *)result Error:(NSError **)error;

@end
