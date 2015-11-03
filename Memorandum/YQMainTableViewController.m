//
//  YQMainTableViewController.m
//  Memorandum
//
//  Created by YoKing on 15/11/1.
//  Copyright © 2015年 YQ. All rights reserved.
//

#import "YQMainTableViewController.h"
#import "YQDetailsViewController.h"
static BOOL flag = YES;
@interface YQMainTableViewController ()

@end

@implementation YQMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initItemData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    self.itemArr = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    //    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    NSLog(@"%@",self.itemArr);
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
//    cell.textLabel.text = [NSString stringWithFormat:@"test-message-%ld", (long)indexPath.row];
    cell.textLabel.text = [[self.itemArr objectAtIndex:indexPath.row] valueForKey:@"title"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)UITableViewCellEditingStyleDelete);
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //从数据源中删除该行
        
        //删除图片
        NSString *filePath = [[self.itemArr objectAtIndex:indexPath.row] valueForKey:@"image"];
        NSLog(@"%@",filePath);
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
        
        [self.itemArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        //创建相应类的实例，插入到数组中，并且向表中增加一行
    }
}

#pragma mark - UITableViewDelegate 
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YQDetailsViewController *index = [[YQDetailsViewController alloc]init];
    index.index = indexPath.row;
    
    //取消被选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
