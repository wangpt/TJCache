//
//  TJExampleViewController.m
//  TJCache
//
//  Created by 王朋涛 on 16/9/9.
//  Copyright © 2016年 王朋涛. All rights reserved.
//

#import "TJExampleViewController.h"
#import "TJFileManager.h"

static NSString *const TJButtonName = @"TJButtonName";
static NSString *const TJButtonInfo = @"TJButtonInfo";
static NSString *const TJButtonSelector = @"TJButtonSelector";

@interface TJExampleViewController ()
@property (nonatomic, strong) NSArray *data;

@end
@implementation TJExampleViewController
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"TJCache";
    self.data = @[@[@{TJButtonName:@"Show TJCache",
                      TJButtonInfo:@"based on NSCache",
                      TJButtonSelector:@"showOkayCancelActionSheet"},
                    @{TJButtonName:@"Show TJUserDefaults",
                      TJButtonInfo:@"based on NSUserDefaults",
                      TJButtonSelector:@"showOkayCancelActionSheet"},
                    @{TJButtonName:@"Show TJFileManager",
                      TJButtonInfo:@"based on NSFileManager",
                      TJButtonSelector:@"showOkayCancelActionSheet"},
                    @{TJButtonName:@"Show TJKeyedArchive",
                      TJButtonInfo:@"based on NSKeyedArchive",
                      TJButtonSelector:@"showOkayCancelActionSheet"}],
                  
                  @[@{TJButtonName:@"Show YYCacaeDemo",
                      TJButtonInfo:@"based on YYCache",
                      TJButtonSelector:@"showYYCacaeDemo"},
                    @{TJButtonName:@"Show PINCacaeDemo",
                      TJButtonInfo:@"based on PINCache",
                      TJButtonSelector:@"showPINCacaeDemo"}
                    ],
                  
                  @[@{TJButtonName:@"Show TJFMDBClien",
                      TJButtonInfo:@"based on FMDB",
                      TJButtonSelector:@""}],
                  
                  @[@{TJButtonName:@"Show MRCoreDataClient",
                      TJButtonInfo:@"based on MagicalRecord",
                      TJButtonSelector:@"showMRCoreDataClient"}]];
    
   //MRCoreDataController
}
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.data[section] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // create / dequeue cell
    static NSString* identifier = @"identifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11.0];
        cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
        
    }
    NSDictionary *data = self.data[indexPath.section][indexPath.row];
    cell.textLabel.text = data[TJButtonName];
    cell.detailTextLabel.text = data[TJButtonInfo];
    if (indexPath.section==0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    self.tableView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.95 alpha:1.0];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section <2 || indexPath.section == 3) {
        NSDictionary *data = self.data[indexPath.section][indexPath.row];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSString *selectorName = data[TJButtonSelector];
        [self performSelector:NSSelectorFromString(selectorName) withObject:nil];
#pragma clang diagnostic pop
    }
    
}

- (void)showYYCacaeDemo{
    UIViewController *vc = [[NSClassFromString(@"YYCacheDemoController") alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)showPINCacaeDemo{
    UIViewController *vc = [[NSClassFromString(@"PINCacheDemoController") alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showMRCoreDataClient{
    
    UIViewController *vc = [[NSClassFromString(@"MRCoreDataController") alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)showOkayCancelActionSheet {

}

- (BOOL)shouldAutorotate; { return YES; }
- (UIInterfaceOrientationMask)supportedInterfaceOrientations { return UIInterfaceOrientationMaskAll; }
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation; { return YES; }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
