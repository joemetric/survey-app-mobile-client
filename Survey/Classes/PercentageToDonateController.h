//
//  PercentageToDonateController .h
//  Survey
//
//  Created by mobile06 on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PercentageToDonateController : UIViewController {
	UIPickerView	*percentageToDonatePicker;
	NSString		*percentageToDonate;
	NSString		*percentage;
	NSInteger		selectedRow;
}

@property (nonatomic, retain) NSString *percentageToDonate;
@property (nonatomic, retain) NSString *percentage;

@property (nonatomic, retain) IBOutlet UIPickerView *percentageToDonatePicker;

- (void)doneButtonClicked;

@end