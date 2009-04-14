#import "GTMSenTestCase.h"
#import "DatePickerViewController.h"
#import "NSObject+CleanUpProperties.h"

@interface DatePickerViewControllerTest : GTMTestCase{
    DatePickerViewController* testee;
    NSDate* initialDate;
	UITextField* textField;
}
@property(nonatomic, retain) DatePickerViewController* testee;
@property(nonatomic, retain) NSDate* initialDate;
@property(nonatomic, retain) UITextField* textField;
@end


@implementation DatePickerViewControllerTest
@synthesize testee, initialDate, textField;

-(void)setUp{
    self.initialDate = [NSDate dateWithNaturalLanguageString:@"3 March 1982"];
	self.textField = [[[UITextField alloc] init] autorelease];
    self.testee = [DatePickerViewController datePickerViewControllerWithDate:initialDate andTextField:textField];
    [[NSBundle mainBundle] loadNibNamed:@"DatePickerView" owner:testee options:nil]; // Force loading of nib
    [testee viewDidLoad];

}

-(void)tearDown{
    [self setEveryObjCObjectPropertyToNil];
}

-(void)testInitialisedWithCorrectDate{
    STAssertNotNil(testee, nil);
    STAssertNotNil(testee.datePicker, nil);
    STAssertEqualObjects(self.initialDate, testee.datePicker.date, nil);
}

-(void)testDatePickerLablesAndTextFieldsInitiallySet{
	NSString* expectedFormattedDate = [testee.formatter stringFromDate:initialDate];
	STAssertEqualStrings(expectedFormattedDate, testee.cell.text, @"cell text");
	STAssertEqualStrings(expectedFormattedDate, textField.text, @"text field text");
	
}

-(void)testWhenDatePickerChangesLabelAndTextFieldAreUpdated{
	NSDate* date = [NSDate dateWithTimeIntervalSince1970:6839494];
	NSString* expectedFormatted = [testee.formatter stringFromDate:date];
	STAssertNotNil(expectedFormatted, nil);
	testee.datePicker.date = date;
	[testee valueChanged:testee.datePicker];
	STAssertEqualStrings(expectedFormatted, testee.cell.text, @"cell text");
	STAssertEqualStrings(expectedFormatted, textField.text, @"text field text");
	
}

@end
