//
//  TextEntity.h
//  JActivityList
//
//  Created by juanmao on 15/12/7.
//  Copyright © 2015年 juanmao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextEntity : NSObject
@property(nonatomic, assign)int       textId;
@property(nonatomic, strong)NSString  *textName;
@property(nonatomic, strong)NSString  *textContent;
    ///是否展开状态，默认No
@property(nonatomic, assign)BOOL      isShowMoreText;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
