//
//  LabelledTableViewCell.m
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import "LabelledTableViewCell.h"
#import "LoadsSingleObjectFromNib.h"
#import "NSObject+CleanUpProperties.h"
#import "DatePickerViewController.h"

@interface LabelledTableViewCell()
@property(nonatomic, retain) UITableViewController* datePickerController;
@end

@implementation LabelledTableViewCell
@synthesize label, textField;
@synthesize errorField, datePickerController;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
		// Initialization code
	}
	return self;
}

+(LabelledTableViewCell*) loadLabelledCell {
	return [LoadsSingleObjectFromNib loadFromNib:@"LabelledTableViewCell"];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	if (selected) [self activateEditing];
	[super setSelected:selected animated:animated];
}

-(LabelledTableViewCell*)withErrorField:(NSString*)text{
	self.errorField = text;
	return self;
}

-(LabelledTableViewCell*)withPlaceholder:(NSString*)text{
	self.textField.placeholder = text;
	return self;
}
-(LabelledTableViewCell*)withLabelText:(NSString*)text{
	label.text = text;
	return self;
}


-(BOOL)errorHighlighted{
	return label.textColor == [UIColor redColor];
}

-(LabelledTableViewCell*)makeSecure{
	textField.secureTextEntry = YES;
	return self;
}

-(LabelledTableViewCell*)withoutCorrections{
	textField.autocorrectionType = UITextAutocorrectionTypeNo;
	textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	return self;
}

-(LabelledTableViewCell*)makeDateUsingParent:(UIViewController*)parent atInitialDate:(NSDate*)date{
	self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	if (nil == self.datePickerController){
		self.datePickerController =  [DatePickerViewController datePickerViewControllerWithDate:date];
	}
	[parent presentModalViewController:self.datePickerController animated:YES];
	return self;
}


-(LabelledTableViewCell*)makeEmail{
	return [[self withoutCorrections] withKeyboardType:UIKeyboardTypeEmailAddress];
}

-(LabelledTableViewCell*)withKeyboardType:(UIKeyboardType)keyboardType{
	textField.keyboardType = UIKeyboardTypeEmailAddress;
	return self;
}


-(void)setErrorHighlighted:(BOOL)highlighted{
	label.textColor = highlighted ? [UIColor redColor] : [UIColor blackColor];
}

-(void)activateEditing{
	[self.textField becomeFirstResponder];
}


- (void)dealloc {
	[self setEveryObjCObjectPropertyToNil];
	[super dealloc];
}


@end
