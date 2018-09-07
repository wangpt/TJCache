//
//  YYCacheDemoController.m
//  TJCache
//
//  Created by tao on 2018/9/7.
//  Copyright © 2018年 王朋涛. All rights reserved.
//

#import "YYCacheDemoController.h"
#import "PersonModel.h"
#import "YYCache.h"
#import "YYCacheDemoManager.h"

@implementation YYCacheExample
static NSString *const TJExampleName = @"TJExampleName";
static NSString *const TJExampleData = @"TJExampleData";
+ (instancetype)exampleWithTitle:(NSString *)title selector:(NSString *)selector{
    YYCacheExample *example = [[self class] new];
    example.title = title;
    example.selector = NSSelectorFromString(selector);
    return example;
}
@end

@interface YYCacheDemoController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *titles;


@end

@implementation YYCacheDemoController
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableView *)tableView{
    if(_tableView)return _tableView;
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"YYKitDemo";
    self.titles = ({
        NSMutableArray *array = @[
                                  @{
                                      TJExampleName:@"同步",
                                      TJExampleData:@[
                                              [YYCacheExample exampleWithTitle:@"新增数据"
                                                                      selector:@"saveObjectExample:"],
                                              [YYCacheExample exampleWithTitle:@"删除数据"
                                                                      selector:@"removeObjectExample:"],
                                              [YYCacheExample exampleWithTitle:@"修改数据"
                                                                      selector:@"changeObjectExample:"],
                                              [YYCacheExample exampleWithTitle:@"查找数据"
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
    YYCacheExample *model = array[indexPath.row];
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
    YYCacheExample *example = array[indexPath.row];
    [self performSelector:example.selector withObject:nil];
#pragma clang diagnostic pop
}

#pragma mark - Sync
- (void)saveObjectExample:(id)sender{
    if ([YYCacheDemoManager checkPerson]) {
        alert(@"本地数据已存在");
        return;
    }
    PersonModel *cacheModel = [PersonModel new];
    cacheModel.id = [NSNumber numberWithInteger:100];
    cacheModel.infoModel = [PersonInfoModel new];;
    cacheModel.infoModel.sex = @"男";
    cacheModel.infoModel.age = 20;
    cacheModel.infoModel.name = @"小明";
    [[YYCacheDemoManager sharedManager] updataPersonObject:cacheModel];
    alert(@"保存成功");
}

- (void)removeObjectExample:(id)sender{
    if (![YYCacheDemoManager checkPerson]) {
        alert(@"本地数据不存在");
        return;
    }
    [[YYCacheDemoManager sharedManager] removePerson];
    alert(@"删除成功");
}

- (void)changeObjectExample:(id)sender{
    if (![YYCacheDemoManager checkPerson]) {
        alert(@"本地数据不存在");
        return;
    }
    PersonModel *cacheModel = [[YYCacheDemoManager sharedManager] readPerson];
    if ([cacheModel.infoModel.name isEqualToString:@"小明"]) {
        cacheModel.id = [NSNumber numberWithInteger:200];
        cacheModel.infoModel = [PersonInfoModel new];;
        cacheModel.infoModel.sex = @"女";
        cacheModel.infoModel.age = 18;
        cacheModel.infoModel.name = @"小红";
    }else{
        cacheModel.id = [NSNumber numberWithInteger:300];
        cacheModel.infoModel = [PersonInfoModel new];;
        cacheModel.infoModel.sex = @"男";
        cacheModel.infoModel.age = 20;
        cacheModel.infoModel.name = @"小明";
    }
    [[YYCacheDemoManager sharedManager] updataPersonObject:cacheModel];
    alert(@"修改成功");
}

- (void)readObjectExample:(id)sender{
    if (![YYCacheDemoManager checkPerson]) {
        alert(@"不存在本地数据");
        return;
    }
    PersonModel *model = [[YYCacheDemoManager sharedManager] readPerson];
    NSString *string = [NSString stringWithFormat:@"user_name:%@ user_id:%@ ",model.infoModel.name,model.id];
    alert(string);
}



@end



