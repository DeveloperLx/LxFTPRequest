LxFTPRequest
============

Installation
------------
Only need add LxFTPRequest.h and LxFTPRequest.m to your project.

Introduction
------------
        A convenient FTP Request library. Support progress tracking, Breakpoint continuingly etc.
        Support FTP get resource list, download file, update file, 
        create directory or file, delete directory or file etc.
        Support progress tracking, Breakpoint continuingly, 
        auto check legitimacy of ftp address and local file path functions and so on.
Support
------------
        Both support iOS and Mac OS X platforms.
        Minimum support iOS version: iOS 5.0
        Minimum support OS X version: Mac OS X 10.7

Podfile
------------
        pod 'LxFTPRequest', '~> 1.1.2'

How to use
-----------
        #import "LxFTPRequest.h"
### Get resource list:

        LxFTPRequest *request = [LxFTPRequest resourceListRequest];
        request.serverURL = [[NSURL URLWithString:FTP_SCHEME_HOST]URLByAppendingPathComponent:SUB_DIRECTORY];
        request.username = USERNAME;
        request.password = PASSWORD;
        request.progressAction = ^(NSInteger totalSize, NSInteger finishedSize, CGFloat finishedPercent) {
            NSLog(@"totalSize = %ld, finishedSize = %ld, finishedPercent = %f", totalSize, finishedSize, finishedPercent); 
        };
        request.successAction = ^(Class resultClass, id result) {
            NSArray *resultArray = (NSArray *)result;
            NSLog(@"resultArray = %@", resultArray);  
        };
        request.failAction = ^(CFStreamErrorDomain domain, NSInteger error, NSString *errorMessage) {
            NSLog(@"domain = %ld, error = %ld", domain, error);
        };
        [request start];

### Download resource:

        /**
            To implement breakpoint continuingly, you only need to guarantee
            the file downloaded part has not been modified in any way, 
            the ftp server support breakpoint continuingly
            and the file on server not change. 
            The download will continue from the last time progress.
            If you want to download resource from begin, you should delete the local downloaded part.
            [[NSFileManager defaultManager]removeItemAtPath:LOCAL_FILE_PATH error:&error];
        */

        LxFTPRequest *request = [LxFTPRequest downloadRequest];
        request.serverURL = [NSURL URLWithString:FTP_RESOURCE_ADDRESS];
        request.localFileURL = [NSURL fileURLWithPath:LOCAL_FILE_PATH];
        request.username = USERNAME;
        request.password = PASSWORD;
        request.progressAction = ^(NSInteger totalSize, NSInteger finishedSize, CGFloat finishedPercent) {
            NSLog(@"totalSize = %ld, finishedSize = %ld, finishedPercent = %f", totalSize, finishedSize, finishedPercent); 
        };
        request.successAction = ^(Class resultClass, id result) {
            NSLog(@"resultClass = %@, result = %@", resultClass, result);  
        };
        request.failAction = ^(CFStreamErrorDomain domain, NSInteger error, NSString *errorMessage) {
            NSLog(@"domain = %ld, error = %ld", domain, error);
        };
        [request start];
            
### Upload resource:

        LxFTPRequest *request = [LxFTPRequest uploadRequest];
        request.serverURL = [NSURL URLWithString:FTP_SCHEME_HOST]URLByAppendingPathComponent:FILE_PATH];
        request.localFileURL = [NSURL fileURLWithPath:LOCAL_FILE_SAVE_PATH];
        request.username = USERNAME;
        request.password = PASSWORD;
        request.progressAction = ^(NSInteger totalSize, NSInteger finishedSize, CGFloat finishedPercent) {
            NSLog(@"totalSize = %ld, finishedSize = %ld, finishedPercent = %f", totalSize, finishedSize, finishedPercent); 
        };
        request.successAction = ^(Class resultClass, id result) {
            NSLog(@"resultClass = %@, result = %@", resultClass, result);
        };
        request.failAction = ^(CFStreamErrorDomain domain, NSInteger error, NSString *errorMessage) {
            NSLog(@"domain = %ld, error = %ld", domain, error);
        };
        [request start];
            
### Create file or directory on ftp server:

        LxFTPRequest *request = [LxFTPRequest createResourceRequest];
        request.serverURL = [NSURL URLWithString:FTP_RESOURCE_PATH];    // directory path should be end up with '/'
        request.username = USERNAME;
        request.password = PASSWORD;
        request.successAction = ^(Class resultClass, id result) {
            NSLog(@"resultClass = %@, result = %@", resultClass, result);
        };
        request.failAction = ^(CFStreamErrorDomain domain, NSInteger error, NSString *errorMessage) {
            NSLog(@"domain = %ld, error = %ld", domain, error);
        };
        [request start];

### Delete file or directory on ftp server:

        /**
            CANNOT DELETE EMPTY DIRECTORY!!!
        */
        LxFTPRequest *request = [LxFTPRequest destoryResourceRequest];
        request.serverURL = [NSURL URLWithString:FTP_RESOURCE_PATH];
        request.username = USERNAME;
        request.password = PASSWORD;
        request.successAction = ^(Class resultClass, id result) {
            NSLog(@"resultClass = %@, result = %@", resultClass, result);
        };
        request.failAction = ^(CFStreamErrorDomain domain, NSInteger error, NSString *errorMessage) {
            NSLog(@"domain = %ld, error = %ld", domain, error);
        };
        [request start];
        
Be careful            
-----------
Demo must config FTP address, username, password correctly.

License
-----------
LxFTPRequest is available under the Apache License 2.0. See the LICENSE file for more info.

