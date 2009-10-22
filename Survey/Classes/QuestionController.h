//
//  QuestionController.h
//  Survey
//
//  Created by Allerin on 09-10-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Survey, Question;

@interface QuestionController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
	UILabel *nameLabel;
	UILabel *descLabel;
	UITextField *answerField;
	UIButton *takeButton;
	UIPickerView *choicePicker;
	UIImageView *imageView;
	
	Survey *survey;
	Question *question;
	NSInteger questionIdx;
	
	QuestionController *nextQuestionController;
}

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *descLabel;
@property (nonatomic, retain) IBOutlet UITextField *answerField;
@property (nonatomic, retain) IBOutlet UIButton *takeButton;
@property (nonatomic, retain) IBOutlet UIPickerView *choicePicker;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) Survey *survey;
@property (nonatomic, assign) NSInteger questionIdx;
@property (nonatomic, retain, readonly) Question *question;
@property (nonatomic, retain) QuestionController *nextQuestionController;

- (IBAction)takePhoto;

@end
