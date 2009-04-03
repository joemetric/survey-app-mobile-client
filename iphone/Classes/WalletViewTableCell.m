//
//  WalletViewTableCell.m
//  JoeMetric
//
//  Created by Alan Francis on 31/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import "WalletViewTableCell.h"


@implementation WalletViewTableCell

@synthesize surveyName, surveyValue, lozengeView;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}

- (void) setupAsDebit {
	lozengeView.image = [UIImage imageNamed:@"red_lozenge.png"];
	surveyValue.textColor = [UIColor whiteColor];
}

- (void) setupAsCredit {
	lozengeView.image = [UIImage imageNamed:@"green_lozenge.png"];
	surveyValue.textColor = [UIColor blackColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
