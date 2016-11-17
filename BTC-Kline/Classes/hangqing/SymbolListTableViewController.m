//
//  SymbolListTableViewController.m
//  BTC-Kline
//
//  Created by apple on 2016/11/11.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "SymbolListTableViewController.h"
#import "SymbolModel.h"
#import "GoodsPath.h"
@interface SymbolListTableViewController ()
@property (nonatomic , strong)NSMutableArray *arrayLIst;
@property (nonatomic, strong) NSMutableArray *arrayEtc;
@property (nonatomic, strong) NSMutableArray *arrayCurrent;
@end

@implementation SymbolListTableViewController
- (NSMutableArray *)arrayLIst{
    if (!_arrayLIst) {
        NSMutableArray *array  = [NSMutableArray arrayWithContentsOfFile:[GoodsPath sharePath].etcPath];
        self.arrayEtc = [array mutableCopy];
        NSArray *arrayss = [NSArray arrayWithContentsOfFile:[GoodsPath sharePath].currentGoodsPath];
        self.arrayCurrent = [arrayss mutableCopy];
        if (!self.arrayCurrent) {
            self.arrayCurrent = [NSMutableArray array];
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
    self.title = @"添加交易品种";
    [self.tableView setEditing:YES];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"全部添加" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  UITableViewCellEditingStyleInsert;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        NSInteger index = indexPath.row;
        NSDictionary *dict = self.arrayEtc[index];
        [self.arrayLIst removeObjectAtIndex:index];
        [self.arrayEtc removeObjectAtIndex:index];
        [self.arrayEtc writeToFile:[GoodsPath sharePath].etcPath atomically:YES];
        [self.arrayCurrent addObject:dict];
        [self.arrayCurrent writeToFile:[GoodsPath sharePath].currentGoodsPath atomically:YES];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)back{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是全部添加至列表吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"是的" style:0 handler:^(UIAlertAction * _Nonnull action) {
        [self allAdd];
    }];
    
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"不" style:0 handler:nil];
    [alertVC addAction:yes];
    [alertVC addAction:no];
    if (self.arrayLIst.count) {
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    

}
- (void)allAdd{
    [self.arrayLIst removeAllObjects];
    [self.arrayEtc removeAllObjects];
    NSArray *array = [NSArray arrayWithContentsOfFile:[GoodsPath sharePath].goodsPath];
    self.arrayCurrent = [[array mutableCopy] mutableCopy];
    [self.arrayCurrent writeToFile:[GoodsPath sharePath].currentGoodsPath atomically:YES];
    [self.arrayEtc writeToFile:[GoodsPath sharePath].etcPath atomically:YES];
    [self.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrayLIst.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
