//
//  WalletViewTableCell.h
//  JoeMetric
//
//  Created by Alan Francis on 31/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WalletViewTableCell : UITableViewCell {
	UILabel* surveyName;
	UILabel* surveyValue;
}

@property (nonatomic, retain) IBOutlet UILabel* surveyName;
@property (nonatomic, retain) IBOutlet UILabel* surveyValue;
@end
