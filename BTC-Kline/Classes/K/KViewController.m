//
//  KViewController.m
//  BTC-Kline
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "KViewController.h"
#import "Glob.h"
#import "SymbolModel.h"
#import "Y_StockChartViewController.h"
#import "AppDelegate.h"
@interface KViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong)UIPickerView *symbolPicker;
@property (nonatomic, copy) NSArray *arrayData;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *symbol;
@property (nonatomic, weak) UIView *chatView;

@end

@implementation KViewController

- (NSArray *)arrayData{
    if (!_arrayData) {
        NSArray *array  = [NSArray arrayWithContentsOfFile:[GoodsPath sharePath].currentGoodsPath];
        NSInteger count = array.count;
        NSMutableArray *arraM = [NSMutableArray arrayWithCapacity:count];
        for (NSInteger index = 0; index < count; index ++) {
            NSDictionary *dict = array[index];
            SymbolModel *model = [SymbolModel returnModelWithDictionry:dict];
            [arraM addObject:model];
        }
        _arrayData = [arraM copy];
    }
    return  _arrayData;
}

- (UIPickerView *)symbolPicker{
    if (!_symbolPicker) {
        _symbolPicker = [[UIPickerView alloc]init];
        _symbolPicker.backgroundColor = [UIColor whiteColor];
        _symbolPicker.delegate = self;
        _symbolPicker.dataSource = self;
    }
    return _symbolPicker;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return  1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.arrayData.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    SymbolModel *model = self.arrayData[row];
    label.text = model.symbolName;
    return label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDefaultSetting];
}
- (void)loadDefaultSetting{
    Y_StockChartViewController *srockChartViewController = [[Y_StockChartViewController alloc]init];
    [self addChildViewController:srockChartViewController];
    [self.view addSubview: srockChartViewController.view];
    self.chatView = srockChartViewController.view;
    [srockChartViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.bottom.equalTo(self.view).offset(-44);
    }];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    SymbolModel *model = self.arrayData[row];
    self.symbol.title = model.symbolName;
    Y_StockChartViewController *stockVC = self.childViewControllers[0];
    stockVC.symbolName = model.symbolName;
    [stockVC reloadData];
    [self.symbolPicker removeFromSuperview];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.symbolPicker removeFromSuperview];
}
- (IBAction)changeSymbol:(UIBarButtonItem *)sender {
    
    [self.chatView addSubview:self.symbolPicker];
    [self.symbolPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(self.chatView);
        make.width.equalTo(@80);
        make.height.equalTo(@300);
    }];
}
- (IBAction)canshu:(UIButton *)sender {
    Y_StockChartViewController *vc = (Y_StockChartViewController *) self.chatView.nextResponder;
    [vc changeCanshu];
}

@end
