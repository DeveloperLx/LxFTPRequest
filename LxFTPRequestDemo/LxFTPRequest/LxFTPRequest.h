//
//  LxFTPRequest.h
//  FTPDemo
//
//  Created by Gener-health-li.x on 14/12/23.
//  Copyright (c) 2014年 Gener-health-li.x. All rights reserved.
//

/*
 Need to improve：
 
    1.Recursive delete server directory which is not empty.
    2.Can't identify illegal IP FTP address
    3.Demo  instructions
    4.CocoaPods
 */

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

#define RESOURCE_LIST_BUFFER_SIZE   1024
#define DOWNLOAD_BUFFER_SIZE        1024
#define UPLOAD_BUFFER_SIZE          1024

@interface LxFTPRequest : NSObject
{
    CFStreamClientContext _streamClientContext;
}

/**
    Return whether the request was stated successful.
 */
- (BOOL)start;
- (void)stop;

@property (nonatomic,copy) NSURL * serverURL;
@property (nonatomic,copy) NSURL * localFileURL;
@property (nonatomic,copy) NSString * username;
@property (nonatomic,copy) NSString * password;
@property (nonatomic,readonly) NSString * scheme;
@property (nonatomic,readonly) NSString * host;
@property (nonatomic,readonly) NSURL * fullURL;

@property (nonatomic,assign) NSInteger finishedSize;
@property (nonatomic,assign) NSInteger fileTotalSize;

@property (nonatomic,copy) void (^progressAction)(NSInteger totalSize, NSInteger finishedSize, CGFloat finishedPercent);
@property (nonatomic,copy) void (^successAction)(Class resultClass, id result);
@property (nonatomic,copy) void (^failAction)(CFStreamErrorDomain domain, NSInteger error);

@end

@interface LxFTPRequest (Create)

+ (LxFTPRequest *)resourceListRequest;
+ (LxFTPRequest *)downloadRequest;
+ (LxFTPRequest *)uploadRequest;
+ (LxFTPRequest *)createDirectoryRequest;
+ (LxFTPRequest *)destoryFileRequest;

@end

@interface NSString (ftp)

@property (nonatomic,readonly) BOOL isValidateFTPURLString;
@property (nonatomic,readonly) BOOL isValidateFileURLString;
- (NSString *)stringByDeletingScheme;

@end
