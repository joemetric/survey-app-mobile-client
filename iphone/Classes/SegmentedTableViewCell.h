//
//  SegmentedTableViewCell.h
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Labelled.h"

@interface SegmentedTableViewCell : UITableViewCell<Labelled> {
	UILabel* label;
	UISegmentedControl* segControl;
	UITableView* tableView;	
}

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) IBOutlet UISegmentedControl* segControl;

@end
