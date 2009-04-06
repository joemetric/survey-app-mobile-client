//
//  DateHelper.h
//  JoeMetric
//
//  Created by Paul Wilson on 01/04/2009.
//  Copyright 2009 Mere Complexities Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DateHelper : NSObject {

}
+(NSDateFormatter*)formatter;
+(NSDate*) dateFromString:(NSString*)str;
+(NSString*) stringFromDate:(NSDate*)date;
+(NSString*)localDateFormatFromDateString:(NSString*)dateString;

@end
