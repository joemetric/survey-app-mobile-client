//
//  PaymentCell.m
//  Survey
//
//  Created by Allerin on 09-11-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "PaymentCell.h"


@implementation PaymentCell
@synthesize priceButton, surveyLabel, dateLabel;
@synthesize transfer;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
	dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterShortStyle];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
	[priceButton release];
	[surveyLabel release];
	[dateLabel release];
	[transfer release];
	[dateFormatter release];
	
    [super dealloc];
}

- (void)updateTransfer:(Transfer *)trans {
	self.transfer = trans;
	[priceButton setTitle:[self.transfer.survey pricing] forState:UIControlStateNormal];
	surveyLabel.text = self.transfer.survey.name;
	dateLabel.text = [dateFormatter stringFromDate:[self.transfer approvalDate]];
}


@end
