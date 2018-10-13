//
//  RealmController.h
//  TJCache
//
//  Created by tao on 2018/10/13.
//  Copyright © 2018年 王朋涛. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define alert(msg) [[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show]

@interface RealmExample : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) SEL selector;

@end
@interface RealmController : UIViewController

@end

NS_ASSUME_NONNULL_END
