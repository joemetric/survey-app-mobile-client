//
//  SegmentedTableViewCell.m
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import "SegmentedTableViewCell.h"


@implementation SegmentedTableViewCell
@synthesize label, segControl;
@synthesize tableView;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


- (void)dealloc {
	[label release];
	[segControl release];
	[tableView release];
    [super dealloc];
}


@end
