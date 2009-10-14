//
//  EditBirthdayController.h
//  Survey
//
//  Created by Allerin on 09-10-15.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProfileController;

@interface EditBirthdayController : UIViewController {
	UIDatePicker *datePicker;
	ProfileController *profileController;
}

@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, retain) ProfileController *profileController;

- (void)cancel;
- (void)save;

@end
