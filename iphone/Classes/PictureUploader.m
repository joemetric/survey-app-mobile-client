#import "PictureUploader.h"
#import "RestConfiguration.h"

@implementation PictureUploader

@synthesize imageFile;
@synthesize observer;

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	[buffer appendData:data];
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
	[buffer setLength:0];	
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSString *strbuffer = [[[NSString alloc] initWithData:buffer encoding:NSUTF8StringEncoding] autorelease];
    
    [self.observer pictureUploaded:strbuffer];
	[buffer setLength:0];
}

- (void)upload {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%d/pictures", host, port]];
    
    NSData *data = [NSData dataWithContentsOfFile:self.imageFile];
    
	NSString *stringBoundary = [NSString stringWithString:@"0xJoeMetricBoundary"];
    
	NSMutableDictionary *headers = [[[NSMutableDictionary alloc] init] autorelease];
	[headers setValue:@"no-cache" forKey:@"Cache-Control"];
	[headers setValue:@"no-cache" forKey:@"Pragma"];
	[headers setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", stringBoundary]
               forKey:@"Content-Type"];
    
	request = [NSMutableURLRequest requestWithURL:url
                                      cachePolicy:NSURLRequestUseProtocolCachePolicy
                                  timeoutInterval:60.0];
	[request setHTTPMethod:@"POST"];
	[request setAllHTTPHeaderFields:headers];
    
	NSMutableData *postData = [NSMutableData dataWithCapacity:[data length] + 512];
	[postData appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary]
                          dataUsingEncoding:NSUTF8StringEncoding]];
	[postData appendData:[@"Content-Disposition: form-data; name=\"image\"; filename=\"file.png\"\r\n\r\n" 
                          dataUsingEncoding:NSUTF8StringEncoding]];
	[postData appendData:data];
	[postData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", stringBoundary]
                          dataUsingEncoding:NSUTF8StringEncoding]];
    
	[request setHTTPBody:postData];
    
    
    conn = [[NSURLConnection alloc] initWithRequest:request
                                           delegate:self
                                   startImmediately:YES];
    
    

}

- (id)initWithImage:(NSString *)anImageFile andObserver:(NSObject<PictureUploaderObserver> *)delegate {
    if (self = [super init]) {
        self.imageFile = anImageFile;
        self.observer = delegate;
        
        host = [RestConfiguration host];
        port = [RestConfiguration port];
        
        NSMutableDictionary* headers = [[[NSMutableDictionary alloc] init] autorelease];
        [headers setValue:@"application/json" forKey:@"Content-Type"];
        [headers setValue:@"text/json" forKey:@"Accept"];
        [headers setValue:@"no-cache" forKey:@"Cache-Control"];
        [headers setValue:@"no-cache" forKey:@"Pragma"];
        [headers setValue:@"close" forKey:@"Connection"]; // Avoid HTTP 1.1 "keep alive" for the connection
        
        request = [NSMutableURLRequest requestWithURL:nil
                                          cachePolicy:NSURLRequestUseProtocolCachePolicy
                                      timeoutInterval:60.0];
        [request retain]; 
        [request setAllHTTPHeaderFields:headers];
        
        buffer = [[NSMutableData alloc] init];
    }
    return self;
}

- (void)dealloc {
    [imageFile release];
    [observer release];
    [super dealloc];
}
@end
