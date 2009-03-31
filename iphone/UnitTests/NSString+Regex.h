//
//  NSString+Regex.h
//  JoeMetric
//
//  Created by Paul Wilson on 31/03/2009.
//  Copyright 2009 Mere Complexities Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegexMatch : NSObject{
}
@end

@interface NSString(Regex)
-(RegexMatch*) matchRegex:(NSString*)regex;
@end
