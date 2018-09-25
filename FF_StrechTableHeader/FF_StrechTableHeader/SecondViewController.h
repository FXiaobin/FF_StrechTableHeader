//
//  SecondViewController.h
//  FF_StrechTableHeader
//
//  Created by mac on 2018/9/25.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,SecondViewControllerType) {
    SecondViewControllerTypeFirst = 0,
    SecondViewControllerTypeSecond
};

@interface SecondViewController : UIViewController

@property (nonatomic,assign) SecondViewControllerType type;

@end

NS_ASSUME_NONNULL_END
