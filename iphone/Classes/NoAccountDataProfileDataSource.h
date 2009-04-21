//
//  NoAccountDataProfileDataSource.h
//  JoeMetric
//
//  Created by Paul Wilson on 23/03/2009.
//  Copyright 2009 Mere Complexities Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StaticTable.h"


@interface NoAccountDataProfileDataSource : StaticTable  {
}

+(id)noAccountDataProfileDataSourceWithMessages:(NSArray*)messages andTableView:(UITableView*)tableView;

@end
 