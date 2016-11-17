//
//  SimpleCell.m
//  BTC-Kline
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "SimpleCell.h"
#import "Glob.h"
#import "HangQing.h"
#import "NetWorking.h"

@implementation SimpleCell
+ (instancetype)simpleCellWithTableView:(UITableView *)tableView{
  static NSString *strID = @"simpleCell";
    SimpleCell *simpleCell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (!simpleCell) {
        simpleCell = [[[NSBundle mainBundle]loadNibNamed:@"SimpleCell" owner:nil options:nil] firstObject];
    }
    return simpleCell;
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
    NSLog(@"%@",responseObject.price);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.name.text = responseObject.symble;
            self.mostLow.text = responseObject.price;
            self.mostHight.text = responseObject.price;
            
            NSArray *aray = @[self.mostLow,self.mostHight];
            [self changeColor:[responseObject.price substringFromIndex:(responseObject.price.length -1)].integerValue labelArray:aray];
        });
       
} fail:^(NSError *error) {
    NSLog(@"%@",error);
}];

}

- (void)changeColor:(NSInteger )length labelArray:(NSArray *)labelArray{
    
    for (NSInteger index = 0; index < 2; index ++) {
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
