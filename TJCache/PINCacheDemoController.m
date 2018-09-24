//
//  PINCacheDemoController.m
//  TJCache
//
//  Created by tao on 2018/9/7.
//  Copyright © 2018年 王朋涛. All rights reserved.
//

#import "PINCacheDemoController.h"
#import "PersonModel.h"
#import "PINCacheDemoManager.h"
@implementation PINCacheExample
static NSString *const TJExampleName = @"TJExampleName";
static NSString *const TJExampleData = @"TJExampleData";
+ (instancetype)exampleWithTitle:(NSString *)title selector:(NSString *)selector{
    PINCacheExample *example = [[self class] new];
    example.title = title;
    example.selector = NSSelectorFromString(selector);
    return example;
}
@end

@interface PINCacheDemoController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *titles;

@end

@implementation PINCacheDemoController

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
    self.title = @"PINCacheDemo";
    self.titles = ({
        NSMutableArray *array = @[
                                  @{
                                      TJExampleName:@"同步方法",
                                      TJExampleData:@[
                                              [PINCacheExample exampleWithTitle:@"新增数据"
                                                                      selector:@"saveObjectExample:"],
                                              [PINCacheExample exampleWithTitle:@"删除数据"
                                                                      selector:@"removeObjectExample:"],
                                              [PINCacheExample exampleWithTitle:@"修改数据"
                                                                      selector:@"changeObjectExample:"],
                                              [PINCacheExample exampleWithTitle:@"查找数据"
                                                                      selector:@"readObjectExample:"],
                                              ]
                                      },
                                  @{
                                      TJExampleName:@"异步方法",
                                      TJExampleData:@[
                                              [PINCacheExample exampleWithTitle:@"新增数据"
                                                                       selector:@"saveAsynObjectExample:"],
                                              [PINCacheExample exampleWithTitle:@"删除数据"
                                                                       selector:@"removeAsynObjectExample:"],
                                              [PINCacheExample exampleWithTitle:@"修改数据"
                                                                       selector:@"changeAsynObjectExample:"],
                                              [PINCacheExample exampleWithTitle:@"查找数据"
                                                                       selector:@"readAsynObjectExample:"],
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
    PINCacheExample *model = array[indexPath.row];
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
    PINCacheExample *example = array[indexPath.row];
    [self performSelector:example.selector withObject:nil];
#pragma clang diagnostic pop
}

#pragma mark - Sync
- (void)saveObjectExample:(id)sender{
    if ([PINCacheDemoManager checkPerson]) {
        alert(@"本地数据已存在");
        return;
    }
    PersonModel *cacheModel = [PersonModel new];
    cacheModel.id = [NSNumber numberWithInteger:100];
    cacheModel.infoModel = [PersonInfoModel new];;
    cacheModel.infoModel.sex = @"男";
    cacheModel.infoModel.age = 20;
    cacheModel.infoModel.name = @"小A";
    [[PINCacheDemoManager sharedManager] updataPersonObject:cacheModel];
    alert(@"保存成功");
}

- (void)removeObjectExample:(id)sender{
    if (![PINCacheDemoManager checkPerson]) {
        alert(@"本地数据不存在");
        return;
    }
    [[PINCacheDemoManager sharedManager] removePerson];
    alert(@"删除成功");
}

- (void)changeObjectExample:(id)sender{
    if (![PINCacheDemoManager checkPerson]) {
        alert(@"本地数据不存在");
        return;
    }
    PersonModel *cacheModel = [[PINCacheDemoManager sharedManager] readPerson];
    if ([cacheModel.infoModel.name isEqualToString:@"小A"]) {
        cacheModel.id = [NSNumber numberWithInteger:200];
        cacheModel.infoModel = [PersonInfoModel new];;
        cacheModel.infoModel.sex = @"女";
        cacheModel.infoModel.age = 18;
        cacheModel.infoModel.name = @"小C";
    }else{
        cacheModel.id = [NSNumber numberWithInteger:300];
        cacheModel.infoModel = [PersonInfoModel new];;
        cacheModel.infoModel.sex = @"男";
        cacheModel.infoModel.age = 20;
        cacheModel.infoModel.name = @"小A";
    }
    [[PINCacheDemoManager sharedManager] updataPersonObject:cacheModel];
    alert(@"修改成功");
}

- (void)readObjectExample:(id)sender{
    if (![PINCacheDemoManager checkPerson]) {
        alert(@"不存在本地数据");
        return;
    }
    PersonModel *model = [[PINCacheDemoManager sharedManager] readPerson];
    NSString *string = [NSString stringWithFormat:@"user_name:%@ user_id:%@ ",model.infoModel.name,model.id];
    alert(string);
}
#pragma mark -
- (void)saveAsynObjectExample:(id)sender{
    
    if ([PINCacheDemoManager checkPerson]) {
        alert(@"本地数据已存在");
        return;
    }
    PersonModel *cacheModel = [PersonModel new];
    cacheModel.id = [NSNumber numberWithInteger:100];
    cacheModel.infoModel = [PersonInfoModel new];;
    cacheModel.infoModel.sex = @"男";
    cacheModel.infoModel.age = 20;
    cacheModel.infoModel.name = @"小A";
    [[PINCacheDemoManager sharedManager] updataAsynPersonObject:cacheModel withBlock:^(PINCache * _Nonnull cache, NSString * _Nonnull key, id  _Nullable object) {
        dispatch_async(dispatch_get_main_queue(), ^{
            alert(@"保存成功");
        });

    }];
}
- (void)removeAsynObjectExample:(id)sender{
    [PINCacheDemoManager checkAsynPersonWithBlock:^(BOOL containsObject) {
        if (!containsObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                alert(@"本地数据不存在");
            });
        }else{
            [[PINCacheDemoManager sharedManager] removeAsynPersonWithBlock:^(PINCache * _Nonnull cache, NSString * _Nonnull key, id  _Nullable object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    alert(@"删除成功");
                });
                
            }];
        }
    }];
}
- (void)changeAsynObjectExample:(id)sender{
    [PINCacheDemoManager checkAsynPersonWithBlock:^(BOOL containsObject) {
        if (!containsObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                alert(@"本地数据不存在");
            });
        }else{
            PersonModel *cacheModel = [[PINCacheDemoManager sharedManager] readPerson];
            if ([cacheModel.infoModel.name isEqualToString:@"小A"]) {
                cacheModel.id = [NSNumber numberWithInteger:200];
                cacheModel.infoModel = [PersonInfoModel new];;
                cacheModel.infoModel.sex = @"女";
                cacheModel.infoModel.age = 18;
                cacheModel.infoModel.name = @"小C";
            }else{
                cacheModel.id = [NSNumber numberWithInteger:300];
                cacheModel.infoModel = [PersonInfoModel new];;
                cacheModel.infoModel.sex = @"男";
                cacheModel.infoModel.age = 20;
                cacheModel.infoModel.name = @"小A";
            }
            [[PINCacheDemoManager sharedManager] updataAsynPersonObject:cacheModel withBlock:^(PINCache * _Nonnull cache, NSString * _Nonnull key, id  _Nullable object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    alert(@"修改成功");
                });
            }];
        }
    }];

}
- (void)readAsynObjectExample:(id)sender{
    [PINCacheDemoManager checkAsynPersonWithBlock:^(BOOL containsObject) {
        if (!containsObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                alert(@"本地数据不存在");
            });
        }else{
            [[PINCacheDemoManager sharedManager]readAsynPersonWithBlock:^(PINCache * _Nonnull cache, NSString * _Nonnull key, id  _Nullable object) {
                PersonModel *model = (PersonModel *)object;
                NSString *string = [NSString stringWithFormat:@"user_name:%@ user_id:%@ ",model.infoModel.name,model.id];
                dispatch_async(dispatch_get_main_queue(), ^{
                    alert(string);
                });
            }];
        }
    }];
}
@end
