//
//  SSJShowView.m
//  获得系统相册路径沙盒机制
//
//  Created by 金汕汕 on 16/6/30.
//  Copyright © 2016年 ccs. All rights reserved.
//


#define screen_width [UIScreen mainScreen].bounds.size.width

#import "SSJShowView.h"
#import "JZMTBtnView.h"

@interface SSJShowView()
@property (nonatomic, strong) UIView *backView1;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) id senderViewController;
@end

@implementation SSJShowView

+ (SSJShowView *)instanceSSJShowView{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SSJShowView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}


- (void)buidliew:(NSMutableArray *)titleArray imgArray:(NSMutableArray *)imgArray numberOfEveLine:(int)numberOfEveLineValue  senderVC:(id)senderVC{

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 180)];
    float scrollViewPageCount = titleArray.count%numberOfEveLineValue == 0?(titleArray.count/numberOfEveLineValue):(titleArray.count/numberOfEveLineValue+1);
    scrollView.contentSize = CGSizeMake(scrollViewPageCount*screen_width, 180);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    _backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrollViewPageCount*screen_width, 160)];
    
    _backView1.backgroundColor = [UIColor clearColor];
    scrollView.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:_backView1];
    [self.actionView addSubview:scrollView];
    
    //创建按钮
    for (int i = 0; i < titleArray.count; i++) {
        CGRect frame = CGRectMake(i*screen_width/numberOfEveLineValue, 20, screen_width/numberOfEveLineValue, 80);
        NSString *title = titleArray[i];
        NSString *imageStr = imgArray[i];
        JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
        btnView.tag = 10+i;
        btnView.frame = CGRectMake(i*screen_width/numberOfEveLineValue, 60, screen_width/numberOfEveLineValue, 0);
        btnView.backgroundColor = [UIColor clearColor];
        [_backView1 addSubview:btnView];
        //添加触摸事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
        [btnView addGestureRecognizer:tap];
        /**< 
         duration：动画的持续时间
         
         delay：动画延时几秒执行
         
         dampingRatio ：动画阻尼系数
         
         velocity：动画开始速度
         
         options：动画效果参数
         
         completion：动画执行完成的回调
         */
        /**< 透明度渐变 */
        btnView.alpha = 0.3;
        [UIView animateWithDuration:0.2 animations:^{
            btnView.alpha = 1.0;
        }];
        self.animateWithDurationTime = self.animateWithDurationTime > 0 ?(self.animateWithDurationTime):(1.0);
        /**< 位置渐变 + 弹簧效果 */
        [UIView animateWithDuration:self.animateWithDurationTime delay:0.1 usingSpringWithDamping:0.3 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            btnView.frame = CGRectMake(i*screen_width/numberOfEveLineValue, 20, screen_width/numberOfEveLineValue, 80);
        } completion:^(BOOL finished) {
            
        }];
    }
    self.senderViewController = senderVC;
    if (titleArray.count == numberOfEveLineValue) {
        scrollView.scrollEnabled = FALSE;
    }
}


/** 点击了背景 */
-(void)OnTapBtnView:(UITapGestureRecognizer *)sender{
    NSString *msg=[NSString stringWithFormat:@"%ld",(long)sender.view.tag];
    //    NSLog(@"tag:%d",(int)sender.view.tag);
    if ([self.senderViewController respondsToSelector:@selector(menuHandelPush:)]) {
        [self.delegate menuHandelPush:[msg integerValue]-10];
    }
}


- (IBAction)tapBackView:(UITapGestureRecognizer *)sender {
    [self cancelBtnClick:sender.view ];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollViewW/2)/scrollViewW;
    _pageControl.currentPage = page;
}



//取消上传
- (IBAction)cancelBtnClick:(id)sender {
    if ([self.senderViewController respondsToSelector:@selector(cancelBtnClickDelegateMethod:)]) {
        [self.delegate cancelBtnClickDelegateMethod:sender];
    }
}


@end
