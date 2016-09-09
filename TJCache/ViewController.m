//
//  ViewController.m
//  TJCache
//
//  Created by 王朋涛 on 16/9/8.
//  Copyright © 2016年 王朋涛. All rights reserved.
//

#import "ViewController.h"
#import "TJFileManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@",[TJFileManager pathForDocumentsDirectory]);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
