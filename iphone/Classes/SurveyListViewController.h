//
//  SurveyListViewController.h
//  JoeMetric
//
//  Created by Jon Distad on 1/6/09.
//  Copyright 2009 EdgeCase LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SurveyList.h"


@interface SurveyListViewController : UITableViewController {
	SurveyList *surveys;
}

@property (nonatomic, retain) SurveyList *surveys;

@end
