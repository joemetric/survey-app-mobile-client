#import <Foundation/Foundation.h>

@protocol PictureUploaderObserver
- (void)pictureUploaded:(NSString *)data;
@end

@interface PictureUploader : NSObject {
    NSObject<PictureUploaderObserver> *observer;
    NSString *imageFile;

    NSString *host;
    NSInteger port;
    NSURLConnection *conn;
    NSMutableURLRequest *request;
	NSMutableData *buffer;
}

@property (nonatomic, retain) NSString *imageFile;
@property (nonatomic, retain) NSObject<PictureUploaderObserver>* observer;

- (void)upload;

- (id)initWithImage:(NSString *)anImageFile andObserver:(NSObject<PictureUploaderObserver> *)delegate;
@end
