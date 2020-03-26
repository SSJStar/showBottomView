//
//  SSJShowView.h
//  获得系统相册路径沙盒机制
//
//  Created by 金汕汕 on 16/6/30.
//  Copyright © 2016年 ccs. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SSJShowViewDelegate<NSObject>
/**
 *  菜单按钮点击
 *
 *  @param indexValue 返回点击的按钮下标位置
 */
- (void)menuHandelPush:(NSInteger)indexValue;

/**
 *  取消按钮点击代理
 *
 */
- (void)cancelBtnClickDelegateMethod:(id)sender;
@end

@interface SSJShowView : UIView<UIScrollViewDelegate>

/** 动画时间  默认1.0秒 */
@property (nonatomic,assign) float animateWithDurationTime;

@property (weak, nonatomic) IBOutlet UIView *actionView;



@property (nonatomic, assign) id<SSJShowViewDelegate>delegate;

/**
 *   初始化方法
 */
+ (SSJShowView *)instanceSSJShowView;

/**
 *  创建视图
 *
 *  @param titleArray           标题数组
 *  @param imgArray             图片名字数组
 *  @param numberOfEveLineValue 每一页的个数
 *  @param senderVC             代理方法执行者
 */
- (void)buidliew:(NSMutableArray *)titleArray imgArray:(NSMutableArray *)imgArray numberOfEveLine:(int)numberOfEveLineValue  senderVC:(id)senderVC;




/**
 *  使用案例
 *
 
 - (void)createView{
     if (!self.bottomShowView) {
     self.bottomShowView = [SSJShowView instanceSSJShowView];
     self.bottomShowView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
     [self.view addSubview:self.bottomShowView];
     self.bottomShowView.delegate = self;
     [self.bottomShowView buidliew:[@[@"图片",@"视频",@"其它"] mutableCopy] imgArray:[@[@"p1",@"p3",@"p4"] mutableCopy] numberOfEveLine:2 senderVC:self];
     }
 }
 
 */
@end
