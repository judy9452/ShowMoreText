//
//  TextEntity.m
//  JActivityList
//
//  Created by juanmao on 15/12/7.
//  Copyright © 2015年 juanmao. All rights reserved.
//

#import "TextEntity.h"

@implementation TextEntity
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        self.textId = [[dict objectForKey:@"textId"]intValue];
        self.textName = [dict objectForKey:@"textName"];
        self.textContent = [dict objectForKey:@"textContent"];
        self.isShowMoreText = NO;
    }
    return self;
}


@end
