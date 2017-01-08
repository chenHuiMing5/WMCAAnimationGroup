# WMCAAnimationGroup
最近研究了一下CAAnimationGroup 组动画,觉得很有意思 ,写了这个呆萌 ,大家一起探讨好玩的动画吧

#2017/01/8 关于layer 动画组的一些探讨
##这两天视觉这边要求做了个动画:事物在下降一定高度后,先放大,后变小,同时背后的背景开始旋转闪烁;
###这里主要用到了layer动画  , CAAnimationGroup 组合动画 和CABasicAnimation 来实现
#pragma mark - 开始动画
主要的代码如下  
'
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
'
##里面需要注意的
(1)我们可以给这个动画组设置在哪个时间点开始做什么东东 ,(根据beginTime 这个属性);
(2)做多久(根据.duration  这个属性)
(3)fillMode的作用就是决定当前对象过了非active时间段的行为. 比如动画开始之前,动画结束之后。如果是一个动画CAAnimation,则需要将其removedOnCompletion设置为NO,要不然fillMode不起作用.kCAFillModeRemoved 这个是默认值,也就是说当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态 
kCAFillModeForwards 当动画结束后,layer会一直保持着动画最后的状态 
kCAFillModeBackwards 这个和kCAFillModeForwards是相对的,就是在动画开始前,你只要将动画加入了一个layer,layer便立即进入动画的初始状态并等待动画开始.你可以这样设定测试代码,将一个动画加入一个layer的时候延迟5秒执行.然后就会发现在动画没有开始的时候,只要动画被加入了layer,layer便处于动画初始状态 
(4)

|  属性        | 说明           |
| ------------| :--------------|
|duration     | 动画的时长     |
|repeatCount  |重复的次数。不停重复设置为 HUGE_VALF  |
|beginTime  | 指定动画开始的时间。从开始延迟几秒的话|
|fromValue |所改变属性的起始值 |
|toValue  |所改变属性的结束时的值 |
|byValue  |所改变属性相同起始值的改变量  |

(5) 在组合动画中常用的animationWithKeyPath值的总结值 

| 常用的函数方法    | eg     |
| ----------| :----------|
|transform.scale  | 比例转化 	@(0.8)|
|transform.scale.x  |宽的比例 	@(0.8)|
|transform.scale.y |高的比例 	@(0.8)|
|transform.rotation.x  |围绕x轴旋转 	@(M_PI)|
|transform.rotation.y | 围绕y轴旋转 	@(M_PI)|
|transform.rotation.z |围绕z轴旋转 	@(M_PI)|
|position |置(中心点的改变) 	[NSValue valueWithCGPoint:CGPointMake(300, 300)];|
|contents | 内容|
|opacity | 这个很重要😀   透明度 	@(0.7)|
|contentsRect.size.width |横向拉伸缩放 	@(0.4)最好是0~1之间的|


