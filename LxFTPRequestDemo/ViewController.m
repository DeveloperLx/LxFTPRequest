//
//  ViewController.m
//  LxFTPRequestDemo
//
//  Created by Gener-health-li.x on 14/12/30.
//  Copyright (c) 2014年 Gener-health-li.x. All rights reserved.
//

#import "ViewController.h"
#import "LxFTPRequest.h"
#import <JGProgressHUD/JGProgressHUD.h>
#import <JGProgressHUD/JGProgressHUDPieIndicatorView.h>

#error ------   Configurate your Ftp address、uesrname、password  ------

#define FTP_ADDRESS    @"ftp://"
#define USERNAME       @"anonymous"
#define PASSWORD       @""

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) JGProgressHUD * processingHUD;

@end

@implementation ViewController 

#define PRINT_INT(i)    printf("%s = %d\n", #i, (int)i)

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
        
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellReuseId = @"cellReuseId";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellReuseId];
    }
    
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"Get resource list";
            cell.detailTextLabel.text = @"";
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"Download";
            cell.detailTextLabel.text = @"";
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"Upload";
            cell.detailTextLabel.text = @"";
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"Create resource";
            cell.detailTextLabel.text = @"";
        }
            break;
        case 4:
        {
            cell.textLabel.text = @"Destory resource";
            cell.detailTextLabel.text = @"";
        }
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            LxFTPRequest * request = [LxFTPRequest resourceListRequest];
            request.serverURL = [[NSURL URLWithString:FTP_ADDRESS]URLByAppendingPathComponent:@""];
            request.username = USERNAME;
            request.password = PASSWORD;
            request.progressAction = ^(NSInteger totalSize, NSInteger finishedSize, CGFloat finishedPercent) {
            
                NSLog(@"totalSize = %ld, finishedSize = %ld, finishedPercent = %f", totalSize, finishedSize, finishedPercent);  //
                
                totalSize = MAX(totalSize, finishedSize);
                
                self.processingHUD.progress = (CGFloat)finishedSize / (CGFloat)totalSize;
            };
            request.successAction = ^(Class resultClass, id result) {
                
                [self.processingHUD dismissAnimated:YES];
                
                NSArray * resultArray = (NSArray *)result;
                
                [self showMessage:[NSString stringWithFormat:@"%@", resultArray]];
            };
            request.failAction = ^(CFStreamErrorDomain domain, NSInteger error) {
            
                [self.processingHUD dismissAnimated:YES];
                NSLog(@"domain = %ld, error = %ld", domain, error);
            };
            [request start];
            
            self.processingHUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
            self.processingHUD.indicatorView = [[JGProgressHUDPieIndicatorView alloc]init];
            self.processingHUD.progress = 0;
            [self.processingHUD showInView:self.view animated:YES];
        }
            break;
        case 1:
        {
            LxFTPRequest * request = [LxFTPRequest downloadRequest];
            request.serverURL = [[NSURL URLWithString:FTP_ADDRESS]URLByAppendingPathComponent:@"xxx.zip"];
            request.localFileURL = [[NSURL fileURLWithPath:NSHomeDirectory()]URLByAppendingPathComponent:@"Documents/downloadedFTPFile"];
            request.username = USERNAME;
            request.password = PASSWORD;
            request.progressAction = ^(NSInteger totalSize, NSInteger finishedSize, CGFloat finishedPercent) {
                
                NSLog(@"totalSize = %ld, finishedSize = %ld, finishedPercent = %f", totalSize, finishedSize, finishedPercent);  //
                
                totalSize = MAX(totalSize, finishedSize);
                
                self.processingHUD.progress = (CGFloat)finishedSize / (CGFloat)totalSize;
            };
            request.successAction = ^(Class resultClass, id result) {
                
                [self.processingHUD dismissAnimated:YES];
                [self showMessage:result];
            };
            request.failAction = ^(CFStreamErrorDomain domain, NSInteger error) {
                
                [self.processingHUD dismissAnimated:YES];
                NSLog(@"domain = %ld, error = %ld", domain, error);
            };
            [request start];
            
            self.processingHUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
            self.processingHUD.indicatorView = [[JGProgressHUDPieIndicatorView alloc]init];
            self.processingHUD.progress = 0;
            [self.processingHUD showInView:self.view animated:YES];
        }
            break;
        case 2:
        {
            LxFTPRequest * request = [LxFTPRequest uploadRequest];
            request.serverURL = [[NSURL URLWithString:FTP_ADDRESS]URLByAppendingPathComponent:@"Little dragon female.jpg"];
            NSString * localFilePath = [[NSBundle mainBundle]pathForResource:@"Little dragon female" ofType:@"jpg"];
            request.localFileURL = [NSURL fileURLWithPath:localFilePath];
            request.username = USERNAME;
            request.password = PASSWORD;
            request.progressAction = ^(NSInteger totalSize, NSInteger finishedSize, CGFloat finishedPercent) {
                
                NSLog(@"totalSize = %ld, finishedSize = %ld, finishedPercent = %f", totalSize, finishedSize, finishedPercent);  //
                
                totalSize = MAX(totalSize, finishedSize);
                
                self.processingHUD.progress = (CGFloat)finishedSize / (CGFloat)totalSize;
            };
            request.successAction = ^(Class resultClass, id result) {
                
                [self.processingHUD dismissAnimated:YES];
                [self showMessage:result];
            };
            request.failAction = ^(CFStreamErrorDomain domain, NSInteger error) {
                
                [self.processingHUD dismissAnimated:YES];
                NSLog(@"domain = %ld, error = %ld", domain, error);
            };
            [request start];
            
            self.processingHUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
            self.processingHUD.indicatorView = [[JGProgressHUDPieIndicatorView alloc]init];
            self.processingHUD.progress = 0;
            [self.processingHUD showInView:self.view animated:YES];
        }
            break;
        case 3:
        {
            LxFTPRequest * request = [LxFTPRequest createResourceRequest];
            request.serverURL = [[NSURL URLWithString:FTP_ADDRESS]URLByAppendingPathComponent:@"newDir/"];
            request.username = USERNAME;
            request.password = PASSWORD;
            request.successAction = ^(Class resultClass, id result) {
                
                [self showMessage:result];
            };
            request.failAction = ^(CFStreamErrorDomain domain, NSInteger error) {
                
                NSLog(@"domain = %ld, error = %ld", domain, error);
            };
            [request start];
        }
            break;
        case 4:
        {
            LxFTPRequest * request = [LxFTPRequest destoryResourceRequest];
            request.serverURL = [[NSURL URLWithString:FTP_ADDRESS]URLByAppendingPathComponent:@"newDir/"];
            request.username = USERNAME;
            request.password = PASSWORD;
            request.successAction = ^(Class resultClass, id result) {
                
                [self showMessage:result];
            };
            request.failAction = ^(CFStreamErrorDomain domain, NSInteger error) {
                
                NSLog(@"domain = %ld, error = %ld", domain, error);
            };
            [request start];
        }
            break;
        default:
            break;
    }
}

- (void)showMessage:(NSString *)message
{
    NSLog(@"message = %@", message);//
    
    JGProgressHUD * hud = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    hud.indicatorView = nil;
    hud.textLabel.text = message;
    [hud showInView:self.view];
    [hud dismissAfterDelay:7];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
