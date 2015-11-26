//
//  YQMainTableViewController.m
//  Memorandum
//
//  Created by YoKing on 15/11/1.
//  Copyright © 2015年 YQ. All rights reserved.
//  显示所有备忘录的主页面

#import "YQMainTableViewController.h"
#import "YQDetailsViewController.h"


static BOOL flag = YES;
@interface YQMainTableViewController ()
@property (nonatomic,strong)UIButton *btn;
@end

@implementation YQMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)editingRows:(id)sender {
    
    if (flag) {
        [self.tableView setEditing:YES animated:YES];
        flag = NO;
    }else{
        [self.tableView setEditing:NO animated:YES];
        flag = YES;
    }
    
    
}

-(void)initItemData{
    
    self.itemArr = [NSMutableArray arrayWithContentsOfFile:dataFilePath];
    NSMutableDictionary *dic;
    for (int i = 0; i < self.itemArr.count; i++) {
        dic = [self.itemArr objectAtIndex:i];
    }
//    NSLog(@"%@",self.itemArr);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.itemArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cells"];
    }

    cell.textLabel.text = [[self.itemArr objectAtIndex:indexPath.row] valueForKey:@"title"];
    
    cell.detailTextLabel.text = [[self.itemArr objectAtIndex:indexPath.row] valueForKey:@"currentTime"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UITableViewCellEditingStyleDelete)
    {
        //从数据源中删除该行
        [self.itemArr removeObjectAtIndex:indexPath.row];
        [self.itemArr writeToFile:dataFilePath atomically:YES];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
}

#pragma mark - UITableViewDelegate 
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    YQDetailsViewController *index = [storyBoard instantiateViewControllerWithIdentifier:@"DetailsViewC"];
    
    //为详情页面传所选中的行号
    index.index = indexPath.row;
    
    
    [self.navigationController pushViewController:index animated:YES];

    //取消被选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self initItemData];
    [self.tableView reloadData];
}

@end
