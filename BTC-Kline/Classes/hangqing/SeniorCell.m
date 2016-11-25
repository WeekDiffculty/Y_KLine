//
//  SeniorCell.m
//  BTC-Kline
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "SeniorCell.h"
#import "Glob.h"
#import "HangQing.h"
@interface SeniorCell ()
@property (weak, nonatomic) IBOutlet UILabel *symbolName;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *diancha;
@property (weak, nonatomic) IBOutlet UILabel *lowMost;
@property (weak, nonatomic) IBOutlet UILabel *hightMost;
//low
@property (weak, nonatomic) IBOutlet UILabel *gewei;
@property (weak, nonatomic) IBOutlet UILabel *fenshu;
@property (weak, nonatomic) IBOutlet UILabel *lifang;
//hight
@property (weak, nonatomic) IBOutlet UILabel *hGewei;
@property (weak, nonatomic) IBOutlet UILabel *hFenshu;
@property (weak, nonatomic) IBOutlet UILabel *hLifang;

@end
@implementation SeniorCell

+ (instancetype) seniorCellWithTableView:(UITableView *)tableView{
    static NSString *strID = @"seniorCell";
    SeniorCell *seniorCell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (!seniorCell) {
        seniorCell = [[[NSBundle mainBundle]loadNibNamed:@"SeniorCell" owner:nil options:nil] firstObject];
    }
    return seniorCell;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadDefaultSetting];
    }
    return self;
}
- (void)setSymbol:(NSString *)symbol{
    _symbol = symbol;
    NSDictionary *dict =  @{@"type":@"singlequote",@"symbol":symbol};
    NSString *url = [HQJK stringByAppendingString:symbol];
    [NetWorking requestHQWithApi:url param:dict success:^(HangQing *responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.symbolName.text = responseObject.symble;
            NSString *str = responseObject.price;
            NSInteger length = str.length;
            self.gewei.text = [str substringToIndex:(length -3)];
            self.fenshu.text = [str substringWithRange:NSMakeRange(length -3, 2)];
            self.lifang.text = [str substringFromIndex:(length -1)];
            //
            self.hGewei.text = [str substringToIndex:(length -3)];
            self.hFenshu.text = [str substringWithRange:NSMakeRange(length-3, 2)];
            self.time.text = responseObject.time;
            self.hLifang.text = [str substringFromIndex:(length -1)];
            NSArray *array = @[self.gewei,self.fenshu,self.lifang,self.hGewei,self.hFenshu,self.hLifang];
            [self changeColor:[responseObject.price substringFromIndex:(length -1)].integerValue labelArray:array];
        });
        
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)changeColor:(NSInteger )length labelArray:(NSArray *)labelArray{
    
        for (NSInteger index = 0; index < labelArray.count -1; index ++) {
            UILabel *label = labelArray[index];
            if (length%2==0) {
                label.textColor = [UIColor redColor];
            }else{
                label.textColor = [UIColor blueColor];
            }
    }
}
- (void)loadDefaultSetting{
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

@end
