//
//  WMGiftDetaultAnimationView.h
//  52hz
//
//  Created by 从来 on 17/1/2.
//  Copyright © 2017年 sgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMGiftDetaultAnimationView : UIView


+(instancetype)sharedDefaultAnimationView;


@property (nonatomic, strong)NSString *gifUrlStr;




-(void)show;
-(void)hiden;
@end
