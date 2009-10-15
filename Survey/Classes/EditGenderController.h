//
//  EditGenderController.h
//  Survey
//
//  Created by Allerin on 09-10-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditGenderController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
	UIPickerView *genderPicker;
	NSString *gender;
}

@property (nonatomic, retain) IBOutlet UIPickerView *genderPicker;
@property (nonatomic, retain) NSString *gender;

- (void)cancel;
- (void)save;

@end
