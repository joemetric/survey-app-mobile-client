//
//  EditRaceController.h
//  Survey
//
//  Created by Allerin on 09-10-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EditRaceController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	UIPickerView *racePicker;
	NSMutableArray *raceArray;
}

@property (nonatomic, retain) IBOutlet UIPickerView *racePicker;
@property (nonatomic, retain) NSMutableArray *raceArray;

- (void)cancel;
- (void)save;

@end
