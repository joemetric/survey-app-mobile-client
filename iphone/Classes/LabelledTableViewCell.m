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
@property(nonatomic, retain) UIViewController* datePickerController;
@property(nonatomic, assign) UIViewController* parentController;
@end

@implementation LabelledTableViewCell
@synthesize label, textField;
@synthesize errorField, datePickerController, parentController;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
		// Initialization code
	}
	return self;
}

+(LabelledTableViewCell*) loadLabelledCell {
	return [LoadsSingleObjectFromNib loadFromNib:@"LabelledTableViewCell"];
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

-(LabelledTableViewCell*)makeDateUsingParent:(UIViewController*)_parent atInitialDate:(NSDate*)date{
	self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	self.datePickerController =  [DatePickerViewController datePickerViewControllerWithDate:date andTextField:textField];
	self.parentController = _parent;
	self.textField.enabled = NO;
	return self;
}


-(LabelledTableViewCell*)makeEmail{
	return [[self withoutCorrections] withKeyboardType:UIKeyboardTypeEmailAddress];
}

-(LabelledTableViewCell*)withKeyboardType:(UIKeyboardType)keyboardType{
	textField.keyboardType = UIKeyboardTypeEmailAddress;
	return self;
}

-(NSDateFormatter*)dateFormatter{
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
	dateFormatter.dateStyle = NSDateFormatterMediumStyle;
	return dateFormatter;
}

-(void)setDate:(NSDate*)date{
	textField.text = nil == date ? @"" : [[self dateFormatter] stringFromDate:date];
}

-(NSDate*)date{
	return [[self dateFormatter] dateFromString:textField.text];
}

-(void)setErrorHighlighted:(BOOL)highlighted{
	label.textColor = highlighted ? [UIColor redColor] : [UIColor blackColor];
}

-(void)activateEditing{
	if (self.parentController == nil){
		[self.textField becomeFirstResponder];
	}else{
		[self.parentController presentModalViewController:datePickerController animated:YES];
	}
}


- (void)dealloc {
	[self setEveryObjCObjectPropertyToNil];
	[super dealloc];
}


@end
