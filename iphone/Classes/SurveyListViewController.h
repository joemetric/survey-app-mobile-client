//
//  SurveyListViewController.h
//  JoeMetric
//
//  Created by Jon Distad on 1/6/09.
//  Copyright 2009 EdgeCase LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResourceDelegate.h"

@interface SurveyListViewController : UITableViewController<ResourceDelegate> {
    NSArray *surveys;
}

@property (nonatomic, retain) NSArray *surveys;

@end
