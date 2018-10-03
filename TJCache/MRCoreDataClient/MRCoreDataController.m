//
//  MRCoreDataController.m
//  TJCache
//
//  Created by tao on 2018/9/25.
//  Copyright © 2018年 王朋涛. All rights reserved.
//

#import "MRCoreDataController.h"
#import "AppDelegate.h"
#import "PersonEntity+CoreDataClass.h"
#import "PersonInfoEntity+CoreDataClass.h"
#import "MRCoreDataClient.h"

@implementation MRCacheExample
+ (instancetype)exampleWithTitle:(NSString *)title selector:(NSString *)selector{
    MRCacheExample *example = [[self class] new];
    example.title = title;
    example.selector = NSSelectorFromString(selector);
    return example;
}
@end

@interface MRCoreDataController ()<UITableViewDelegate, UITableViewDataSource>
{
    AppDelegate *app;
    
}

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *titles;


@end

@implementation MRCoreDataController
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
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;

    
    self.title = @"YYCacheDemo";
    self.titles = ({
        NSMutableArray *array = @[
                                  @{
                                      TJExampleName:@"同步方法",
                                      TJExampleData:@[
                                              [MRCacheExample exampleWithTitle:@"新增数据"
                                                                      selector:@"saveObjectExample:"],
                                              [MRCacheExample exampleWithTitle:@"删除数据"
                                                                      selector:@"removeObjectExample:"],
                                              [MRCacheExample exampleWithTitle:@"修改数据"
                                                                      selector:@"changeObjectExample:"],
                                              [MRCacheExample exampleWithTitle:@"查找数据"
                                                                      selector:@"readObjectExample:"],
                                              ]
                                      },
//                                  // 这里不能正确存储，还没找到具体原因
//                                  @{
//                                      TJExampleName:@"异步",
//                                      TJExampleData:@[
//                                              [MRCacheExample exampleWithTitle:@"新增数据"
//                                                                      selector:@"saveAsynObjectExample:"],
//                                              [MRCacheExample exampleWithTitle:@"删除数据"
//                                                                      selector:@"removeAsynObjectExample:"],
//                                              [MRCacheExample exampleWithTitle:@"修改数据"
//                                                                      selector:@"changeAsynObjectExample:"],
//                                              [MRCacheExample exampleWithTitle:@"查找数据"
//                                                                      selector:@"readAsynObjectExample:"],
//                                              ]
//                                      },
                                  
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
    MRCacheExample *model = array[indexPath.row];
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
    MRCacheExample *example = array[indexPath.row];
    [self performSelector:example.selector withObject:nil];
#pragma clang diagnostic pop
}

#pragma mark - Sync
- (void)saveObjectExample:(id)sender{
    for (int i = 0; i<10; i++) {
        [MRCoreDataClient savePersonId:[NSString stringWithFormat:@"%d",i] name:@"小明" sex:@"1"];
    }
    alert(@"保存成功");
}

- (void)removeObjectExample:(id)sender{
    [MRCoreDataClient removeAllObjects];
    alert(@"删除成功");
}

- (void)changeObjectExample:(id)sender{
    [MRCoreDataClient updataPersonId:@"1" name:@"小红" sex:@"0"];
    alert(@"修改成功");
}

- (void)readObjectExample:(id)sender{
    PersonEntity *entity = [MRCoreDataClient readPersonId:@"1"];
    if (entity) {
        alert(entity.name);
    }else{
        alert(@"暂无数据");
    }
}



@end


