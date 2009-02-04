//
//  SurveyListViewController.h
//  JoeMetric
//
//  Created by Jon Distad on 1/6/09.
//  Copyright 2009 EdgeCase LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SurveyListViewController : UITableViewController {
    NSArray *surveys;
}

@property (nonatomic, retain) NSArray *surveys;

@end
