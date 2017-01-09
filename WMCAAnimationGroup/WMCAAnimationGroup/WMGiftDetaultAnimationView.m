//
//  WMGiftDetaultAnimationView.m
//  52hz
//
//  Created by 从来 on 17/1/2.
//  Copyright © 2017年 sgy. All rights reserved.
//

#import "WMGiftDetaultAnimationView.h"

#define sphereWidth 15
#define sphereHeight 15
#define CurrentWidth ([UIScreen mainScreen].bounds.size.width)
#define CurrentHeight ([UIScreen mainScreen].bounds.size.height)
#define WS(wSelf)           __weak typeof(self) wSelf = self
#define kColor_BGColor_blackColor  [UIColor colorWithHex:000000]




@interface WMGiftDetaultAnimationView ()
@property (nonatomic, strong)UIView *bgAllView;
@property (nonatomic, strong)UIImageView *gifImageView;
@property (nonatomic, strong)UILabel *labCharmValue;   //魅力值 +20 !
@property (nonatomic, strong)UILabel *labName;
@property (nonatomic, strong)UIButton *btnFlowerLanguage; //花语
@property (nonatomic, strong)UIImageView  *bgImageView;
@property (nonatomic, strong)UIButton *btnDismiss;
@property (nonatomic, strong)UIButton *btnStart;


@end


@implementation WMGiftDetaultAnimationView

+(instancetype)sharedDefaultAnimationView
{
    static WMGiftDetaultAnimationView *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[WMGiftDetaultAnimationView alloc] init];
    });
    return sharedManager;

}

-(instancetype)init
{
    if ([super init]) {
        
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.frame = CGRectMake(0, 0, CurrentWidth, CurrentHeight);

    [self addSubview:self.bgAllView];
    [self.bgAllView addSubview:self.labName];
    [self.bgAllView addSubview:self.labCharmValue];
    [self.bgAllView addSubview:self.btnFlowerLanguage];
    [self.bgAllView addSubview:self.bgImageView];
    [self.bgAllView addSubview:self.gifImageView];
   
 
//    [self.labCharmValue mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.gifImageView.mas_top).offset(-40);
//        make.centerX.equalTo(self.bgAllView.mas_centerX);
//    }];
//    [self.labName mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.bgAllView.mas_centerX);
//        make.centerY.equalTo(self.bgAllView.mas_centerY).offset(80);
//        
//    }];
//    [self.btnFlowerLanguage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.labName.mas_bottom).offset(12);
//        make.centerX.equalTo(self.bgAllView.mas_centerX);
//
//    }];
//    
//    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.gifImageView);
//        
//        
//    }];
//    
//    [self.btnDismiss mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.bgAllView).offset(100);
//        make.left.equalTo(self.bgAllView.mas_left).offset(15);
//        make.height.width.mas_equalTo(100);
//    }];

    [UIView animateWithDuration:1.5 animations:^{
          [self showAnimation];
        
        self.bgImageView.alpha = 1.0;
        self.labCharmValue.alpha = 1.0;
    } completion:^(BOOL finished) {

    }];

}


#pragma mark - 开始动画
-(void) showAnimation {
    
    self.gifImageView.hidden = NO;
    self.bgImageView.hidden = NO;
    //组动画+基本动画
    CABasicAnimation* moveAnimation = [[CABasicAnimation alloc] init];
    moveAnimation.keyPath = @"position";
    moveAnimation.beginTime =  0.0;

    moveAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, 0)];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, CurrentHeight * 0.5 - 80)];
        moveAnimation.duration = 0.5;
    moveAnimation.repeatCount = 1;
    moveAnimation.removedOnCompletion = NO;
    moveAnimation.fillMode = kCAFillModeForwards;
    
//    moveAnimation.
    //放大图片动画
    CABasicAnimation* enlargeAnimation = [[CABasicAnimation alloc] init];
    enlargeAnimation.keyPath = @"transform.scale";
    enlargeAnimation.beginTime = 0.4;
    enlargeAnimation.byValue = [NSNumber numberWithFloat:1];
    enlargeAnimation.toValue = [NSNumber numberWithFloat:1.8];
    enlargeAnimation.repeatCount = 1;
    enlargeAnimation.duration = 0.5;
    enlargeAnimation.removedOnCompletion = NO;
    enlargeAnimation.fillMode = kCAFillModeForwards;
    
    //缩小图片的动画
    CABasicAnimation* narrowAnimation = [[CABasicAnimation alloc] init];
    narrowAnimation.keyPath = @"transform.scale";
    narrowAnimation.beginTime = 0.9;
    narrowAnimation.repeatCount = 1;
    narrowAnimation.duration =0.3;
    narrowAnimation.fromValue = [NSNumber numberWithFloat:1.8];
    narrowAnimation.toValue = [NSNumber numberWithFloat:1];
    //背景旋转
    CABasicAnimation *bgImageViewTransformAnima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    bgImageViewTransformAnima.beginTime = 0.5 ;

    bgImageViewTransformAnima.duration = 1.5; // 持续时间
    bgImageViewTransformAnima.repeatCount =5 ; // 重复次数
    bgImageViewTransformAnima.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
    bgImageViewTransformAnima.toValue = [NSNumber numberWithFloat: M_PI]; // 终止角度

    [self.bgImageView.layer addAnimation:bgImageViewTransformAnima forKey:@"rotate-layer"];
    
    //1.创建组动画对象
    CAAnimationGroup* animationGroup = [[CAAnimationGroup alloc] init];
    animationGroup.animations = @[moveAnimation,enlargeAnimation,narrowAnimation];
//    animationGroup.repeatCount = CGFLOAT_MAX;
    animationGroup.repeatCount = 1;
    animationGroup.duration = 1.2;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    
//    2.
    CAAnimationGroup *animatonGroup2 = [[CAAnimationGroup alloc] init];
    animatonGroup2.animations = @[bgImageViewTransformAnima];
    animatonGroup2.duration = 1.5;
    animatonGroup2.repeatCount = 4;
    animatonGroup2.repeatCount = 1;
    animatonGroup2.removedOnCompletion = NO;
    animatonGroup2.fillMode = kCAFillModeForwards;
    [self.bgImageView.layer addAnimation:animatonGroup2 forKey:@"ratate_layer.2"];
    [self.gifImageView.layer addAnimation:animationGroup forKey:@"testAnimation"];
}



-(UIView *)bgAllView
{
    if (!_bgAllView) {
        _bgAllView = [[UIView alloc] init];
        _bgAllView.frame = CGRectMake(0, 0, CurrentWidth, CurrentHeight);
        _bgAllView.userInteractionEnabled = YES;
    }
    return _bgAllView;
}

-(UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = [UIImage imageNamed:@"gift_bgImage"];
        _bgImageView.alpha = 0.0;
    }
    return _bgImageView;
}

-(UIImageView *)gifImageView
{
    if (!_gifImageView) {
        _gifImageView = [[UIImageView alloc] init];
        _gifImageView.image = [UIImage imageNamed:@"gift_flower_one"];
        _gifImageView.frame = CGRectMake(0, 0, 61, 52);
        _gifImageView.center = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5,CurrentHeight *0.5 -80);
    }
    return _gifImageView;
}


-(UILabel *)labName
{
    if (!_labName) {
        _labName = [[UILabel alloc]init];
        _labName.textColor = [UIColor redColor];
        _labName.font = [UIFont systemFontOfSize:18];
        _labName.text = @"哈喽大家好";
    }
    
    return _labName;
}


- (void)hiden
{
    [self removeFromSuperview];
    [_gifImageView.layer removeAnimationForKey:@"testAnimation"];
    [_bgImageView.layer removeAnimationForKey:@"rotate-layer"];
    [_gifImageView setHidden:YES];
    _bgImageView.alpha = 0.0;
    _labCharmValue.alpha = 0.0 ;
    
}
- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:1.5 animations:^{
        [self showAnimation];
        
        self.bgImageView.alpha = 1.0;
        self.labCharmValue.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
