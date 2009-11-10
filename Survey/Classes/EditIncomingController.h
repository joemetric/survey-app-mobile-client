//
//  EditIncomingController.h
//  Survey
//
//  Created by Allerin on 09-10-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EditIncomingController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	UIPickerView *incomePicker;
	NSMutableArray *incomeArray;
}

@property (nonatomic, retain) IBOutlet UIPickerView *incomePicker;
@property (nonatomic, retain) NSMutableArray *incomeArray;

- (void)cancel;
- (void)save;

@end
