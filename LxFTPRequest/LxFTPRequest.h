//
//  LxFTPRequest.h
//  LxFTPRequestDemo
//

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

@interface LxFTPRequest : NSObject

@property (nonatomic,copy) NSURL * serverURL;
@property (nonatomic,copy) NSURL * localFileURL;
@property (nonatomic,copy) NSString * username;
@property (nonatomic,copy) NSString * password;

@property (nonatomic,assign) NSInteger finishedSize;
@property (nonatomic,assign) NSInteger totalSize;

@property (nonatomic,copy) void (^progressAction)(NSInteger totalSize, NSInteger finishedSize, CGFloat finishedPercent);
@property (nonatomic,copy) void (^successAction)(Class resultClass, id result);
@property (nonatomic,copy) void (^failAction)(CFStreamErrorDomain errorDomain, NSInteger error, NSString * errorDescription);

/**
 *  Return whether the request started successful.
 */
- (BOOL)start;
- (void)stop;

@end

@interface LxFTPRequest (Create)

+ (LxFTPRequest *)resourceListRequest;
+ (LxFTPRequest *)downloadRequest;
+ (LxFTPRequest *)uploadRequest;
+ (LxFTPRequest *)createResourceRequest;
+ (LxFTPRequest *)destoryResourceRequest;

- (instancetype)init __attribute__((unavailable("LxFTPRequest: Forbidden use!")));

@end

@interface NSString (ftp)

@property (nonatomic,readonly) BOOL isValidateFTPURLString;
@property (nonatomic,readonly) BOOL isValidateFileURLString;
- (NSString *)stringByDeletingScheme;
- (NSString *)stringDecorateWithUsername:(NSString *)username password:(NSString *)password;

@end
