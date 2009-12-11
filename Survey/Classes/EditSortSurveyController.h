//
//  EditSortSurveyController.h
//  Survey
//
//  Created by Ye Dingding on 09-12-11.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EditSortSurveyController : UIViewController {
	UIPickerView *sortPicker;
	NSMutableArray *sortArray;
}

@property (nonatomic, retain) IBOutlet UIPickerView *sortPicker;
@property (nonatomic, retain) NSMutableArray *sortArray;

- (void)cancel;
- (void)save;

@end
