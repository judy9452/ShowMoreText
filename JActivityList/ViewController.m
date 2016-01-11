//
//  ViewController.m
//  JActivityList
//
//  Created by juanmao on 15/12/6.
//  Copyright © 2015年 juanmao. All rights reserved.
//

#import "ViewController.h"
#import "TextEntity.h"
#import "TextListCell.h"
#define kWidth            [UIScreen mainScreen].bounds.size.width
#define kHeight           [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)UITableView      *mTabelView;
@property(nonatomic, strong)NSMutableArray   *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"举个🌰";
    self.dataArr = [NSMutableArray array];
    [self initData];
    [self addSubView];
    
}

- (void)addSubView
{
    self.mTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,kWidth,kHeight) style:UITableViewStylePlain];
    self.mTabelView.delegate = self;
    self.mTabelView.dataSource = self;
    self.mTabelView.tableFooterView  = [UIView new];
    [self.view addSubview:self.mTabelView];
}

/*!
 *    解析本地json数据
 */
- (void)initData
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"TextInfo" ofType:@"json"];
    NSString *jsonContent=[[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    if (jsonContent != nil)
    {
        NSData *jsonData = [jsonContent dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:&err];
        NSArray *textList = [dic objectForKey:@"textList"];
        for (NSDictionary *dict in textList)
        {
            TextEntity *entity = [[TextEntity alloc]initWithDict:dict];
            if (entity)
            {
                [self.dataArr addObject:entity];
            }
        }
        if(err)
        {
            NSLog(@"json解析失败：%@",err);
        }
    }
}

#pragma  mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    TextListCell *cell = (TextListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[TextListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if ([self.dataArr count] > indexPath.row)
    {
            //这里的判断是为了防止数组越界
         cell.entity = [self.dataArr objectAtIndex:indexPath.row];
    }
        //自定义cell的回调，获取要展开/收起的cell。刷新点击的cell
    cell.showMoreTextBlock = ^(UITableViewCell *currentCell){
        NSIndexPath *indexRow = [_mTabelView indexPathForCell:currentCell];
        [self.mTabelView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexRow, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    };

    return cell;

}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextEntity *entity = nil;
    if ([self.dataArr count] > indexPath.row)
    {
        entity = [self.dataArr objectAtIndex:indexPath.row];
    }
    
        //根据isShowMoreText属性判断cell的高度
    if (entity.isShowMoreText)
    {
        return [TextListCell cellMoreHeight:entity];
    }
    else
    {
        return [TextListCell cellDefaultHeight:entity];
    }
    return 0;
}
@end
