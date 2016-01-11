//
//  TextListCell.h
//  JActivityList
//
//  Created by juanmao on 15/12/7.
//  Copyright © 2015年 juanmao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextEntity.h"
@interface TextListCell : UITableViewCell
@property(nonatomic, strong)TextEntity *entity;
    ///展开多个活动信息
@property(nonatomic, copy) void (^showMoreTextBlock)(UITableViewCell  *currentCell);

    ///未展开时的高度
+ (CGFloat)cellDefaultHeight:(TextEntity *)entity;
    ///展开后的高度
+(CGFloat)cellMoreHeight:(TextEntity *)entity;
@end
