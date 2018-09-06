//
//  ExampleController.m
//  TJCache
//
//  Created by tao on 2018/9/5.
//  Copyright © 2018年 tao. All rights reserved.
//

#import "ExampleController.h"
#import "PersonModel.h"
#import "TJCacheManager.h"
@implementation TJExample
+ (instancetype)exampleWithTitle:(NSString *)title selector:(NSString *)selector{
    TJExample *example = [[self class] new];
    example.title = title;
    example.selector = NSSelectorFromString(selector);
    return example;
}
@end

@interface ExampleController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *titles;

@end

@implementation ExampleController
+ (void)load
{
    NSLog(@"加载中ExampleController");
}

- (UITableView *)tableView{
    if(_tableView)return _tableView;
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"YYKitDemo";
    self.titles = ({
        NSMutableArray *array = @[
                                  [TJExample exampleWithTitle:@"存储自定义对象" selector:@"saveObjectExample:"],
                                  [TJExample exampleWithTitle:@"读取自定义对象" selector:@"readObjectExample:"],
                                  ].mutableCopy;
        array;
    });
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    TJExample *model =self.titles[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    TJExample *example = self.titles[indexPath.row];
    [self performSelector:example.selector withObject:nil];
#pragma clang diagnostic pop
}

#pragma mark - click
- (void)saveObjectExample:(id)sender{
    PersonModel *cacheModel = [PersonModel new];
    cacheModel.id = [NSNumber numberWithInteger:100];
    cacheModel.infoModel = [PersonInfoModel new];;
    cacheModel.infoModel.sex = @"男";
    cacheModel.infoModel.age = 18;
    cacheModel.infoModel.name = @"小明";
    [[TJCacheManager sharedManager] updataPersonObj:cacheModel];
}
- (void)readObjectExample:(id)sender{
    PersonModel *model = [[TJCacheManager sharedManager] readPerson];
    NSLog(@"%@",model.id);
    NSLog(@"%@",model.infoModel.sex);

}

@end

