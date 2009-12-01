//
//  EditMartialController.h
//  Survey
//
//  Created by Allerin on 09-10-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EditMartialController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	UIPickerView *martialPicker;
	NSMutableArray *martialArray;
}

@property (nonatomic, retain) IBOutlet UIPickerView *martialPicker;
@property (nonatomic, retain) NSMutableArray *martialArray;

- (void)cancel;
- (void)save;

@end
