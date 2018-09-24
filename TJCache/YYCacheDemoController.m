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
#import "YYCacheClient.h"
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
    self.title = @"YYCacheDemo";
    self.titles = ({
        NSMutableArray *array = @[
                                  @{
                                      TJExampleName:@"同步方法",
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
                                  // 这里不能正确存储，还没找到具体原因
                                  @{
                                      TJExampleName:@"异步",
                                      TJExampleData:@[
                                              [YYCacheExample exampleWithTitle:@"新增数据"
                                                                       selector:@"saveAsynObjectExample:"],
                                              [YYCacheExample exampleWithTitle:@"删除数据"
                                                                       selector:@"removeAsynObjectExample:"],
                                              [YYCacheExample exampleWithTitle:@"修改数据"
                                                                       selector:@"changeAsynObjectExample:"],
                                              [YYCacheExample exampleWithTitle:@"查找数据"
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
    if ([YYCacheClient checkPerson]) {
        alert(@"本地数据已存在");
        return;
    }
    PersonModel *cacheModel = [PersonModel new];
    cacheModel.id = [NSNumber numberWithInteger:100];
    cacheModel.infoModel = [PersonInfoModel new];;
    cacheModel.infoModel.sex = @"男";
    cacheModel.infoModel.age = 20;
    cacheModel.infoModel.name = @"小明";
    [YYCacheClient updataPersonObject:cacheModel];
    alert(@"保存成功");
}

- (void)removeObjectExample:(id)sender{
    if (![YYCacheClient checkPerson]) {
        alert(@"本地数据不存在");
        return;
    }
    [YYCacheClient removePerson];
    alert(@"删除成功");
}

- (void)changeObjectExample:(id)sender{
    if (![YYCacheClient checkPerson]) {
        alert(@"本地数据不存在");
        return;
    }
    PersonModel *cacheModel = [YYCacheClient readPerson];
    cacheModel.id = [NSNumber numberWithInteger:200];
    cacheModel.infoModel = [PersonInfoModel new];;
    cacheModel.infoModel.sex = @"女";
    cacheModel.infoModel.age = 18;
    cacheModel.infoModel.name = @"小红";
    [YYCacheClient updataPersonObject:cacheModel];
    alert(@"修改成功");
}

- (void)readObjectExample:(id)sender{
    if (![YYCacheClient checkPerson]) {
        alert(@"本地数据不存在");
        return;
    }
    PersonModel *cacheModel = [YYCacheClient readPerson];
    NSString *string = [NSString stringWithFormat:@"user_name:%@ user_id:%@ ",cacheModel.infoModel.name,cacheModel.id];
    alert(string);
}

#pragma mark - Asyn
- (void)saveAsynObjectExample:(id)sender{
    [YYCacheClient checkAsynPersonWithBlock:^(NSString *key, BOOL contains) {
        if (contains) {
            dispatch_async(dispatch_get_main_queue(), ^{
                alert(@"本地数据已存在");
            });
        }else{
            PersonModel *cacheModel = [PersonModel new];
            cacheModel.id = [NSNumber numberWithInteger:100];
            cacheModel.infoModel = [PersonInfoModel new];;
            cacheModel.infoModel.sex = @"男";
            cacheModel.infoModel.age = 20;
            cacheModel.infoModel.name = @"小明";
            [YYCacheClient updataAsynPersonObject:cacheModel withBlock:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    alert(@"保存成功");
                });
            }];
        }
    }];
}
- (void)removeAsynObjectExample:(id)sender{
    [YYCacheClient checkAsynPersonWithBlock:^(NSString *key, BOOL contains) {
        if (!contains) {
            dispatch_async(dispatch_get_main_queue(), ^{
                alert(@"本地数据不存在");
            });
        }else{
            [YYCacheClient removeAsynPersonWithBlock:^(NSString *key) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    alert(@"删除成功");
                });
            }];
        }
    }];

}

- (void)changeAsynObjectExample:(id)sender{
    [YYCacheClient checkAsynPersonWithBlock:^(NSString *key, BOOL contains) {
        if (!contains) {
            dispatch_async(dispatch_get_main_queue(), ^{
                alert(@"本地数据不存在");
            });
        }else{
            PersonModel *cacheModel = [PersonModel new];
            cacheModel.id = [NSNumber numberWithInteger:200];
            cacheModel.infoModel = [PersonInfoModel new];;
            cacheModel.infoModel.sex = @"女";
            cacheModel.infoModel.age = 18;
            cacheModel.infoModel.name = @"小红";
            [YYCacheClient updataAsynPersonObject:cacheModel withBlock:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    alert(@"修改成功");
                });
            }];
            
        }
    }];
   
}

- (void)readAsynObjectExample:(id)sender{
    [YYCacheClient checkAsynPersonWithBlock:^(NSString *key, BOOL contains) {
        if (!contains) {
            dispatch_async(dispatch_get_main_queue(), ^{
                alert(@"本地数据不存在");
            });
        }else{
            [YYCacheClient readAsynPersonWithBlock:^(NSString *key, id<NSCoding> object) {
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



