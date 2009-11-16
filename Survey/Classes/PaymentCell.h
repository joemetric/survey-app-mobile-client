//
//  PaymentCell.h
//  Survey
//
//  Created by Ye Dingding on 09-11-16.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transfer.h"

@interface PaymentCell : UITableViewCell {
	UIButton *priceButton;
	UILabel *surveyLabel;
	UILabel *dateLabel;
	Transfer *transfer;
	
	NSDateFormatter *dateFormatter;
}

@property (nonatomic, retain) IBOutlet UIButton *priceButton;
@property (nonatomic, retain) IBOutlet UILabel *surveyLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) Transfer *transfer;

- (void)updateTransfer:(Transfer *)trans;

@end
