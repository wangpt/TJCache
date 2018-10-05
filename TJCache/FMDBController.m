//
//  FMDBController.m
//  TJCache
//
//  Created by tao on 2018/10/4.
//  Copyright © 2018年 王朋涛. All rights reserved.
//

#import "FMDBController.h"
#import "FMDBClient.h"
#import "PersonModel.h"
@implementation FMCacheExample
+ (instancetype)exampleWithTitle:(NSString *)title selector:(NSString *)selector{
    FMCacheExample *example = [[self class] new];
    example.title = title;
    example.selector = NSSelectorFromString(selector);
    return example;
}
@end

@interface FMDBController ()<UITableViewDelegate, UITableViewDataSource>


@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *titles;

@end

@implementation FMDBController

static NSString *const TJExampleName = @"TJExampleName";
static NSString *const TJExampleData = @"TJExampleData";
- (UITableView *)tableView{
    if(_tableView)return _tableView;
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FMDBClient";
    self.titles = ({
        NSMutableArray *array = @[
                                  @{
                                      TJExampleName:@"同步方法",
                                      TJExampleData:@[
                                              [FMCacheExample exampleWithTitle:@"新增数据"
                                                                      selector:@"saveObjectExample:"],
                                              [FMCacheExample exampleWithTitle:@"删除数据"
                                                                      selector:@"removeObjectExample:"],
                                              [FMCacheExample exampleWithTitle:@"修改数据"
                                                                      selector:@"changeObjectExample:"],
                                              [FMCacheExample exampleWithTitle:@"查找数据"
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
    FMCacheExample *model = array[indexPath.row];
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
    FMCacheExample *example = array[indexPath.row];
    [self performSelector:example.selector withObject:nil];
#pragma clang diagnostic pop
}

#pragma mark - Sync
- (void)saveObjectExample:(id)sender{
    PersonModel *model = [PersonModel new];
    model.id = [NSNumber numberWithInteger:1];
    PersonInfoModel *infoModel = [PersonInfoModel new];
    infoModel.name = @"小红";
    infoModel.sex = @"1";
    infoModel.age = 18;
    model.infoModel = infoModel;
    [FMDBClient qunueInsertPeople:model];
    alert(@"保存成功");
}

- (void)removeObjectExample:(id)sender{
    [FMDBClient qunueDeleteAllData];
    alert(@"删除成功");
}

- (void)changeObjectExample:(id)sender{
    PersonModel *model = [PersonModel new];
    model.id = [NSNumber numberWithInteger:1];
    PersonInfoModel *infoModel = [PersonInfoModel new];
    infoModel.name = @"小明";
    infoModel.sex = @"0";
    infoModel.age = 20;
    model.infoModel = infoModel;
    [FMDBClient qunueUpdatePeople:model];
    alert(@"修改成功");
}

- (void)readObjectExample:(id)sender{
    NSArray *dataArray = [FMDBClient qunueGetPeople];
    PersonModel *model = dataArray.firstObject;
    if (model) {
        NSLog(@"%@___%@",model.id,model.infoModel.name);
        alert(model.infoModel.name);

    }else{
        alert(@"暂无数据");

    }
}

@end
