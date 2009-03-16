//
//  LabelledTableViewCell.h
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LabelledTableViewCell : UITableViewCell <UITextFieldDelegate> {
	UILabel* label;
	UITextField* textField;
}

@property (nonatomic, retain) IBOutlet UILabel* label;
@property (nonatomic, retain) IBOutlet UITextField* textField;

@end
