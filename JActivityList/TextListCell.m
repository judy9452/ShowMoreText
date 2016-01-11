//
//  TextListCell.m
//  JActivityList
//
//  Created by juanmao on 15/12/7.
//  Copyright © 2015年 juanmao. All rights reserved.
//
#define kWidth            [UIScreen mainScreen].bounds.size.width
#import "TextListCell.h"
@interface TextListCell()
{
    UILabel      *_textTitle;
    UILabel      *_textContent;
    UIButton     *_moreTextBtn;
}
@end


@implementation TextListCell

+ (CGFloat)cellDefaultHeight:(TextEntity *)entity
{
        //默认cell高度
    return 85.0;
}

+ (CGFloat)cellMoreHeight:(TextEntity *)entity
{
        //展开后得高度(计算出文本内容的高度+固定控件的高度)
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
    CGSize size = [entity.textContent boundingRectWithSize:CGSizeMake(kWidth - 30, 100000) options:option attributes:attribute context:nil].size;;
    return size.height + 50;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _textTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 140, 20)];
        _textTitle.textColor = [UIColor blackColor];
        _textTitle.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_textTitle];
        
        _textContent = [[UILabel alloc]initWithFrame:CGRectMake(15, 30,kWidth - 30 , 20)];
        _textContent.textColor = [UIColor blackColor];
        _textContent.font = [UIFont systemFontOfSize:16];
        _textContent.numberOfLines = 0;
        [self.contentView addSubview:_textContent];
        
        _moreTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreTextBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _moreTextBtn.frame = CGRectMake(kWidth - 50, 5, 40, 20);
        [self.contentView addSubview:_moreTextBtn];
        [_moreTextBtn addTarget:self action:@selector(showMoreText) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _textTitle.text = self.entity.textName;
    
    _textContent.text = self.entity.textContent;
    if (self.entity.isShowMoreText)
    {
            ///计算文本高度
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
        NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
        CGSize size = [self.entity.textContent boundingRectWithSize:CGSizeMake(kWidth - 30, 100000) options:option attributes:attribute context:nil].size;
        [_textContent setFrame:CGRectMake(15, 30, kWidth - 30, size.height)];
        
        [_moreTextBtn setTitle:@"收起" forState:UIControlStateNormal];
    }
    else
    {
        [_moreTextBtn setTitle:@"展开" forState:UIControlStateNormal];
        [_textContent setFrame:CGRectMake(15, 30, kWidth - 30, 35)];
    }
    
}

- (void)showMoreText
{
        //将当前对象的isShowMoreText属性设为相反值
    self.entity.isShowMoreText = !self.entity.isShowMoreText;
    if (self.showMoreTextBlock)
    {
        self.showMoreTextBlock(self);
    }
}
@end
