#import "GTMSenTestCase.h"
#import "DatePickerViewController.h"
#import "NSObject+CleanUpProperties.h"

@interface DatePickerViewControllerTest : GTMTestCase{
    DatePickerViewController* testee;
    NSDate* initialDate;
}
@property(nonatomic, retain) DatePickerViewController* testee;
@property(nonatomic, retain) NSDate* initialDate;
@end


@implementation DatePickerViewControllerTest
@synthesize testee, initialDate;

-(void)setUp{
    self.initialDate = [NSDate dateWithNaturalLanguageString:@"3 March 1982"];
    self.testee = [DatePickerViewController datePickerViewControllerWithDate:initialDate];
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

@end
