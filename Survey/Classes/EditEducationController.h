//
//  EditIncomingController.h
//  Survey
//
//  Created by Allerin on 09-10-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EditEducationController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	UIPickerView *educationPicker;
	NSMutableArray *educationArray;
}

@property (nonatomic, retain) IBOutlet UIPickerView *educationPicker;
@property (nonatomic, retain) NSMutableArray *educationArray;

- (void)cancel;
- (void)save;

@end
