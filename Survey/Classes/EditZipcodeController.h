//
//  EditZipcodeController.h
//  Survey
//
//  Created by Ye Dingding on 09-10-30.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EditZipcodeController : UIViewController {
	UITextField *zipcodeField;
}

@property (nonatomic, retain) IBOutlet UITextField *zipcodeField;

- (void)cancel;
- (void)save;

@end
