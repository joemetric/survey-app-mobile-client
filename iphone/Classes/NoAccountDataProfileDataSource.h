//
//  NoAccountDataProfileDataSource.h
//  JoeMetric
//
//  Created by Paul Wilson on 23/03/2009.
//  Copyright 2009 Mere Complexities Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NoAccountDataProfileDataSource :  NSObject <UITableViewDataSource, UITableViewDelegate>  {
    NSString* message;
}

@property(nonatomic,retain) NSString* message;

@end
 