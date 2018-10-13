//
//  RealmController.m
//  TJCache
//
//  Created by tao on 2018/10/13.
//  Copyright © 2018年 王朋涛. All rights reserved.
//

#import "RealmController.h"
@implementation RealmExample
static NSString *const TJExampleName = @"TJExampleName";
static NSString *const TJExampleData = @"TJExampleData";
+ (instancetype)exampleWithTitle:(NSString *)title selector:(NSString *)selector{
    RealmExample *example = [[self class] new];
    example.title = title;
    example.selector = NSSelectorFromString(selector);
    return example;
}
@end
@interface RealmController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *titles;


@end

@implementation RealmController

- (UITableView *)tableView{
    if(_tableView)return _tableView;
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RealmClient";
    self.titles = ({
        NSMutableArray *array = @[
                                  @{
                                      TJExampleName:@"同步方法",
                                      TJExampleData:@[
                                              [RealmExample exampleWithTitle:@"新增数据"
                                                                      selector:@"saveObjectExample:"],
                                              [RealmExample exampleWithTitle:@"删除数据"
                                                                      selector:@"removeObjectExample:"],
                                              [RealmExample exampleWithTitle:@"修改数据"
                                                                      selector:@"changeObjectExample:"],
                                              [RealmExample exampleWithTitle:@"查找数据"
                                                                      selector:@"readObjectExample:"],
                                              ]
                                      },
                                  ].mutableCopy;
        array;
    });
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    // Do any additional setup after loading the view.
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dic = (NSDictionary *)self.titles[section];
    NSArray *array = dic[TJExampleData];
    return array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *dic = (NSDictionary *)self.titles[indexPath.section];
    NSArray *array = dic[TJExampleData];
    RealmExample *model = array[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *dic = (NSDictionary *)self.titles[section];
    return dic[TJExampleName];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    NSDictionary *dic = (NSDictionary *)self.titles[indexPath.section];
    NSArray *array = dic[TJExampleData];
    RealmExample *example = array[indexPath.row];
    [self performSelector:example.selector withObject:nil];
#pragma clang diagnostic pop
}

#pragma mark - Sync
- (void)saveObjectExample:(id)sender{

}

- (void)removeObjectExample:(id)sender{

}

- (void)changeObjectExample:(id)sender{

}

- (void)readObjectExample:(id)sender{

}

@end
