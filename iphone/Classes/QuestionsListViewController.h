//
//  QuestionsViewController.h
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QuestionsListViewController : UITableViewController {
  NSArray *questions;
}

@property (nonatomic, retain) NSArray *questions;

@end
