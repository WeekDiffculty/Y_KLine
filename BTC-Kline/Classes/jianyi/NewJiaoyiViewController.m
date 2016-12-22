//
//  NewJiaoyiViewController.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/16.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "NewJiaoyiViewController.h"
#import "Glob.h"
#import "SymbolModel.h"
#import "NextJiaoyiViewController.h"
#import "orderEdting.h"
@interface NewJiaoyiViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *cmd;
@property (weak, nonatomic) IBOutlet UILabel *volum;
@property (weak, nonatomic) IBOutlet UITextField *volumValue;
@property (weak, nonatomic) IBOutlet UIButton *back;
@property (weak, nonatomic) IBOutlet UIButton *forword;
@property (weak, nonatomic) IBOutlet UIButton *fastBack;
@property (weak, nonatomic) IBOutlet UIButton *fastForword;
@property (weak, nonatomic) IBOutlet UITextField *symBol;
@property (weak, nonatomic) IBOutlet UITextField *CmdtextField;
@property (nonatomic) CGFloat volums;
@property (nonatomic, weak) UIPickerView *pickView;
@property (nonatomic, copy) NSArray *arrayCMD;
@property (nonatomic, copy) NSArray *arrayData;
@property (nonatomic) BOOL isCMD;
@property (weak, nonatomic) IBOutlet UIButton *nextStep;
@property (nonatomic, strong) SymbolModel *model;
@end

@implementation NewJiaoyiViewController
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

- (NSArray *)arrayCMD{
    if (!_arrayCMD) {
        _arrayCMD = @[@"即时买入",@"即时卖出",@"买入限价",@"卖出限价",@"买入止损",@"卖出止损"];
    }
    return _arrayCMD;
}

- (CGFloat)volums{
    if(!_volums){
        _volums = self.volumValue.text.floatValue;
    }
    return  _volums;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

- (instancetype)init{
    if (self = [super init]) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Jiaoyi" bundle:nil];
        self = [storyBoard instantiateViewControllerWithIdentifier:@"NewJiaoyiViewController.h"];
    }
    return self;
}
- (void) loadDefaultSetting{
    UIPickerView *pickView = [[UIPickerView alloc]init];
    self.pickView = pickView;
    pickView.delegate = self;
    self.symBol.inputView = pickView;
    self.symBol.delegate = self;
    self.CmdtextField.inputView = pickView;
    self.CmdtextField.delegate = self;
    self.CmdtextField.enabled = YES;
    self.title = @"新交易";
    self.volumValue.delegate = self;
    self.symBol.text = self.symbol;
    self.symbolAndDescriptions.text = self.symbol;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 99) {
        self.volums = [textField.text floatValue];
        self.volum.text = textField.text;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.symBol resignFirstResponder];
    [self.CmdtextField resignFirstResponder];
}
#pragma pickviewdelegate >>>>>>>>>>>>>>>>>>>>>.

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.isCMD) {
        return  self.arrayCMD.count;
    }else{
        return self.arrayData.count;
    }
   
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    SymbolModel *model = self.arrayData[row];
    if (self.isCMD) {
     
        label.text = self.arrayCMD[row];
    }else{
       label.text = model.symbolName;
    }
    
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.isCMD) {
        if (row==0||row==1) {
            self.nextStep.enabled  = YES;
        }else{
            self.nextStep.enabled = NO;
            [self tip:@"目前仅支持即时买入及卖出"];
        }
        self.CmdtextField.text = self.arrayCMD[row];
        self.cmd.text = self.arrayCMD[row];
    }else{
       SymbolModel *model = self.arrayData[row];
        self.model = model;
        self.symBol.text = model.symbolName;
        self.symbolAndDescriptions.text = [NSString stringWithFormat:@"%@-%@",model.symbolName, model.descriptions];
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == 66) {
        self.isCMD = NO;
    }else if(textField.tag ==77){
        self.isCMD = YES;
    }
    [self.pickView reloadAllComponents];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//快减
- (IBAction)fastBack:(UIButton *)sender {
    self.volums -= 0.1;
    if (self.volums<0.01) {
        [self tip:@"数量最小为0.01"];
        return;
    }
    NSString *str = [NSString stringWithFormat:@"%g",self.volums];
    self.volumValue.text = str;
    self.volum.text = str;
}
//减
- (IBAction)back:(UIButton *)sender {
    self.volums -= 0.01;
    if (self.volums<0.01) {
        [self tip:@"数量最小为0.01"];
        return;
    }
    NSString *str = [NSString stringWithFormat:@"%g",self.volums];
    self.volumValue.text = str;
    self.volum.text = str;
}
//加
- (IBAction)forword:(UIButton *)sender {
    self.volums += 0.01;
   
    NSString *str = [NSString stringWithFormat:@"%g",self.volums];
    self.volumValue.text = str;
    self.volum.text = str;
}
//快加
- (IBAction)fastForword:(UIButton *)sender {
    self.volums += 0.1;
    NSString *str = [NSString stringWithFormat:@"%g",self.volums];
    self.volumValue.text = str;
    self.volum.text = str;
}
- (IBAction)next:(id)sender {
    if (self.volums<0.01) {
        [self tip:@"数量最小为0.01,请核对"];
        return;
    }
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Jiaoyi" bundle:nil];
    NextJiaoyiViewController *nextVC = [storyBoard instantiateViewControllerWithIdentifier:@"NextJiaoyiViewController"];
    if ((self.model||self.symbol)&&self.volums&&self.cmd) {
        nextVC.model = self.model;
        nextVC.symbol = self.symbol;
        nextVC.volums = self.volums;
        nextVC.cmd = self.cmd.text;
        [self.navigationController pushViewController:nextVC animated:YES];

    }else{
        [self tip:@"请核对所选的参数"];
    }   
}
- (void)tip:(NSString *)str{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"知道了" style:0 handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:yes];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
