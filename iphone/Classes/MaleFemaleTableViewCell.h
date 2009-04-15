//
//  SegmentedTableViewCell.h
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Labelled.h"

@interface MaleFemaleTableViewCell : UITableViewCell<Labelled> {
	UILabel* label;
	UISegmentedControl* segControl;
	UITableView* tableView;	
}


+(id)loadMaleFemaleTableViewCell;
@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) IBOutlet UISegmentedControl* segControl;
@property (nonatomic, retain) IBOutlet UILabel* label;
@property (nonatomic, assign) NSString* gender;
@end
