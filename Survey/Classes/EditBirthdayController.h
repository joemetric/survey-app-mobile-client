//
//  EditBirthdayController.h
//  Survey
//
//  Created by Allerin on 09-10-15.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditBirthdayController : UIViewController {
	UIDatePicker *datePicker;
}

@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;

- (void)cancel;
- (void)save;

@end
