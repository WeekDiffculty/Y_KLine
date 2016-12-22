//
//  EdtingTableViewController.m
//  BTC-Kline
//
//  Created by apple on 2016/11/11.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "EdtingTableViewController.h"
#import "SymbolModel.h"
#import "GoodsPath.h"
@interface EdtingTableViewController ()
@property (nonatomic , strong)NSMutableArray *arrayLIst;
@property (nonatomic, strong) NSMutableArray *arrayCurrent;
@property (nonatomic, strong)NSMutableArray *arrayEtc;
@end

@implementation EdtingTableViewController

- (NSMutableArray *)arrayLIst{
    if (!_arrayLIst) {
        NSArray *array  = [NSArray arrayWithContentsOfFile:[GoodsPath sharePath].currentGoodsPath];
        self.arrayCurrent = [array mutableCopy];
        self.arrayEtc = [NSMutableArray arrayWithContentsOfFile:[GoodsPath sharePath].etcPath];
        if (!self.arrayEtc) {
            self.arrayEtc = [NSMutableArray array];
        }
        NSInteger count = array.count;
        NSMutableArray *arraM = [NSMutableArray arrayWithCapacity:count];
        for (NSInteger index = 0; index < count; index ++) {
            NSDictionary *dict = array[index];
            SymbolModel *model = [SymbolModel returnModelWithDictionry:dict];
            [arraM addObject:model];
        }
        _arrayLIst = [arraM mutableCopy];
    }
    return  _arrayLIst;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

- (void) loadDefaultSetting{
    self.title = @"编辑列表";
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithTitle:@"全删" style:UIBarButtonItemStylePlain target:self action:@selector(tip)];
    self.navigationItem.rightBarButtonItem = buttonItem;
    [self.tableView setEditing:YES];
}

- (void)tip{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否要清空列表" preferredStyle:UIAlertControllerStyleAlert];
   UIAlertAction *yes = [UIAlertAction actionWithTitle:@"是的" style:0 handler:^(UIAlertAction * _Nonnull action) {
       [self allDelete];
   }];
    
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"不" style:0 handler:nil];
    [alertVC addAction:yes];
    [alertVC addAction:no];
    if (self.arrayLIst.count) {
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    
}

- (void)allDelete{
    [self.arrayLIst removeAllObjects];
    [self.arrayCurrent removeAllObjects];
    NSArray *array = [NSArray arrayWithContentsOfFile:[GoodsPath sharePath].goodsPath];
    self.arrayEtc = [[array mutableCopy] mutableCopy];
    [self.arrayCurrent writeToFile:[GoodsPath sharePath].currentGoodsPath atomically:YES];
    [self.arrayEtc writeToFile:[GoodsPath sharePath].etcPath atomically:YES];
    [self.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  UITableViewCellEditingStyleDelete;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrayLIst.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strId = @"symbolList";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strId];
    }
    SymbolModel *model = self.arrayLIst[indexPath.row];
    cell.textLabel.text = model.symbolName;
    cell.detailTextLabel.text = model.descriptions;
    return cell
    ;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSInteger index = indexPath.row;
        NSDictionary *dict = self.arrayCurrent[index];
        [self.arrayLIst removeObjectAtIndex:index];
        [self.arrayCurrent removeObjectAtIndex:index];
        [self.arrayCurrent writeToFile:[GoodsPath sharePath].currentGoodsPath atomically:YES];
        [self.arrayEtc addObject:dict];
        [self.arrayEtc writeToFile:[GoodsPath sharePath].etcPath atomically:YES];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }   
}
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    //1.取出数组中的元素(原来的位置)
    SymbolModel *model = [self.arrayLIst objectAtIndex:fromIndexPath.row];
    NSDictionary *dict = [self.arrayCurrent objectAtIndex:fromIndexPath.row];
    //2.从数组中移除要移动的元素
    [self.arrayLIst removeObject:model];
    [self.arrayCurrent removeObject:dict];
    //3.把要移动的元素添加到目的地的位置(在目的地插入数据)
    
    [self.arrayLIst insertObject:model atIndex:toIndexPath.row];
    [self.arrayCurrent insertObject:dict atIndex:toIndexPath.row];
    [self.arrayCurrent writeToFile:[GoodsPath sharePath].currentGoodsPath atomically:YES];

}

@end
