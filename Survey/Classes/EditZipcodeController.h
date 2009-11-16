//
//  EditZipcodeController.h
//  Survey
//
//  Created by Allerin on 09-10-30.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EditZipcodeController : UIViewController {
	UITextField *zipcodeField;
}

@property (nonatomic, retain) IBOutlet UITextField *zipcodeField;

- (void)cancel;
- (void)save;

@end
