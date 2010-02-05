#import "Common.h"

NSData *generatePostDataForData(NSData *uploadData) {
	// Generate the post header:
	NSString *post = [NSString stringWithCString:"--AaB03x\r\nContent-Disposition: form-data; name=\"answer[answer]\"\r\n\r\nimage\r\n--AaB03x\r\nContent-Disposition: form-data; name=\"answer[image]\"; filename=\"answer_image.png\"\r\nContent-Type: image/png\r\nContent-Transfer-Encoding: binary\r\n\r\n" encoding:NSASCIIStringEncoding];
	// Get the post header int ASCII format:
	NSData *postHeaderData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	 
	// Generate the mutable data variable:
	NSMutableData *postData = [[[NSMutableData alloc] initWithLength:[postHeaderData length]] autorelease];
	[postData setData:postHeaderData];
	// Add the image:
	[postData appendData: uploadData];
	// Add the closing boundry:
	[postData appendData: [@"\r\n--AaB03x--" dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
	// Return the post data:
	return postData;
 }