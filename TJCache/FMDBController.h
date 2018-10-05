//
//  FMDBController.h
//  TJCache
//
//  Created by tao on 2018/10/4.
//  Copyright © 2018年 王朋涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#define alert(msg) [[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show]

NS_ASSUME_NONNULL_BEGIN
@interface FMCacheExample : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) SEL selector;

@end
@interface FMDBController : UIViewController

@end

NS_ASSUME_NONNULL_END
