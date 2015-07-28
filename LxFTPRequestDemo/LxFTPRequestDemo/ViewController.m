//
//  ViewController.m
//  LxFTPRequestDemo
//

#import "ViewController.h"
#import "LxFTPRequest.h"
#import "JGProgressHUD/JGProgressHUD.h"
#import "JGProgressHUD/JGProgressHUDPieIndicatorView.h"

#error ------   Configurate your Ftp address、uesrname、password  ------

static NSString * const FTP_ADDRESS = @"ftp://";
static NSString * const USERNAME = @"anonymous";
static NSString * const PASSWORD = @"";

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    JGProgressHUD * _progressHUD;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectInset(self.view.bounds, 0, 20)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
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
    typeof(self) __weak weakSelf = self;
    
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
                
                _progressHUD.progress = (CGFloat)finishedSize / (CGFloat)totalSize;
            };
            request.successAction = ^(Class resultClass, id result) {
                
                [_progressHUD dismissAnimated:YES];
                
                NSArray * resultArray = (NSArray *)result;
                
                typeof(weakSelf) __strong strongSelf = weakSelf;
                
                [strongSelf showMessage:[NSString stringWithFormat:@"%@", resultArray]];
            };
            request.failAction = ^(CFStreamErrorDomain domain, NSInteger error, NSString * errorMessage) {
                
                [_progressHUD dismissAnimated:YES];
                NSLog(@"domain = %ld, error = %ld, errorMessage = %@", domain, error, errorMessage);    //
            };
            [request start];
            
            _progressHUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
            _progressHUD.indicatorView = [[JGProgressHUDPieIndicatorView alloc]init];
            _progressHUD.progress = 0;
            
            typeof(weakSelf) __strong strongSelf = weakSelf;
            [_progressHUD showInView:strongSelf.view animated:YES];
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
                
                _progressHUD.progress = (CGFloat)finishedSize / (CGFloat)totalSize;
            };
            request.successAction = ^(Class resultClass, id result) {
                
                [_progressHUD dismissAnimated:YES];
                
                typeof(weakSelf) __strong strongSelf = weakSelf;
                [strongSelf showMessage:result];
            };
            request.failAction = ^(CFStreamErrorDomain domain, NSInteger error, NSString * errorMessage) {
                
                [_progressHUD dismissAnimated:YES];
                NSLog(@"domain = %ld, error = %ld, errorMessage = %@", domain, error, errorMessage);    //
            };
            [request start];
            
            _progressHUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
            _progressHUD.indicatorView = [[JGProgressHUDPieIndicatorView alloc]init];
            _progressHUD.progress = 0;
            
            typeof(weakSelf) __strong strongSelf = weakSelf;
            [_progressHUD showInView:strongSelf.view animated:YES];
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
                
                _progressHUD.progress = (CGFloat)finishedSize / (CGFloat)totalSize;
            };
            request.successAction = ^(Class resultClass, id result) {
                
                [_progressHUD dismissAnimated:YES];
                
                typeof(weakSelf) __strong strongSelf = weakSelf;
                [strongSelf showMessage:result];
            };
            request.failAction = ^(CFStreamErrorDomain domain, NSInteger error, NSString * errorMessage) {
                
                [_progressHUD dismissAnimated:YES];
                NSLog(@"domain = %ld, error = %ld, errorMessage = %@", domain, error, errorMessage);    //
            };
            [request start];
            
            _progressHUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
            _progressHUD.indicatorView = [[JGProgressHUDPieIndicatorView alloc]init];
            _progressHUD.progress = 0;
            
            typeof(weakSelf) __strong strongSelf = weakSelf;
            [_progressHUD showInView:strongSelf.view animated:YES];
        }
            break;
        case 3:
        {
            LxFTPRequest * request = [LxFTPRequest createResourceRequest];
            request.serverURL = [[NSURL URLWithString:FTP_ADDRESS]URLByAppendingPathComponent:@"newDir/"];
            request.username = USERNAME;
            request.password = PASSWORD;
            request.successAction = ^(Class resultClass, id result) {
                
                typeof(weakSelf) __strong strongSelf = weakSelf;
                [strongSelf showMessage:result];
            };
            request.failAction = ^(CFStreamErrorDomain domain, NSInteger error, NSString * errorMessage) {
                
                NSLog(@"domain = %ld, error = %ld, errorMessage = %@", domain, error, errorMessage);    //
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
                
                typeof(weakSelf) __strong strongSelf = weakSelf;
                [strongSelf showMessage:result];
            };
            request.failAction = ^(CFStreamErrorDomain domain, NSInteger error, NSString * errorMessage) {
                
                NSLog(@"domain = %ld, error = %ld, errorMessage = %@", domain, error, errorMessage);    //
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

@end
