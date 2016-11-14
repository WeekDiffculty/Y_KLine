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
        });
       
} fail:^(NSError *error) {
    NSLog(@"%@",error);
}];

}
- (void)loadDefaultSetting{
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
}
//- (void)drawRect:(CGRect)rect {
//    
//    CGContextRefcontext =UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [UIColorclearColor].CGColor);
//    
//    CGContextFillRect(context, rect);
//    
//    //绘制分割线,其实就是在cell内画一条线
//    
//    CGContextSetStrokeColorWithColor(context, [UIColorgrayColor].CGColor);
//    
//    //设置所画线的frame
//    
//    CGContextStrokeRect(context,CGRectMake(5, rect.size.height, rect.size.width-10,1));
//    
//}


@end
