//
//  EditOccupationController.h
//  Survey
//
//  Created by Allerin on 09-10-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EditOccupationController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	UIPickerView *occupationPicker;
	NSMutableArray *occupationArray;
}

@property (nonatomic, retain) IBOutlet UIPickerView *occupationPicker;
@property (nonatomic, retain) NSMutableArray *occupationArray;

- (void)cancel;
- (void)save;

@end
