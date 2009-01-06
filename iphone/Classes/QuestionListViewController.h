//
//  QuestionsViewController.h
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionList.h"


@interface QuestionListViewController : UITableViewController {
  QuestionList *questions;
}

@property (nonatomic, retain) QuestionList *questions;

@end
