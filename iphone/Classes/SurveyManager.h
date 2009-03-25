//
//  SurveyManager.h
//  JoeMetric
//
//  Created by Scott Barron on 3/25/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SurveyManager : NSObject {
    NSString      *host;
    NSInteger      port;
    NSMutableData *buffer;
    NSMutableURLRequest *request;
    NSURLConnection *conn;
}

- (BOOL)loadSurveysFromNetwork;
+ (NSArray *)loadSurveysFromLocal;

@end
