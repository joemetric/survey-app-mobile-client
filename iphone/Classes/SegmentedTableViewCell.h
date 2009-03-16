//
//  SegmentedTableViewCell.h
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SegmentedTableViewCell : UITableViewCell {
	UILabel* label;
	UISegmentedControl* segControl;
	UITableView* tableView;	
}

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) IBOutlet UILabel* label;
@property (nonatomic, retain) IBOutlet UISegmentedControl* segControl;

@end
