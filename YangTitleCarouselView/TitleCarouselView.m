//
//  TitleCarouselView.m
//  TitleCarouselView
//
//  Created by yanghuang on 2017/11/25.
//  Copyright © 2017年 com.yang. All rights reserved.
//

#import "TitleCarouselView.h"

@interface TitleCarouselView()

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *labels;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UILabel *lastLabel;
@property (nonatomic, strong) UIControl *actionControl;
@end

@implementation TitleCarouselView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.clipsToBounds = YES;
    self.backgroundColor = UIColor.clearColor;
}

- (void)updateWithArray:(NSArray *)array {
    
    [self stopTimer];
    
    if (!array || array.count < 1) {
        return;
    }
    
    self.titles = [NSMutableArray arrayWithArray:array];
    if (array.count == 1) {
        [self.titles addObject:self.titles[0]];
    }
    
    for (int i = 0; i< self.titles.count; i++) {
        UILabel * label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:15.0];
        label.tag = i;
        label.textColor = [UIColor whiteColor];
        label.attributedText = [self attributedStringWithHTMLString:self.titles[i]];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor whiteColor];

        [self addSubview:label];
        [label sizeToFit];
        
        CGFloat x = self.lastLabel? self.lastLabel.frame.origin.x + self.lastLabel.frame.size.width : 0;
        CGFloat width = label.frame.size.width > self.frame.size.width ? label.frame.size.width : self.frame.size.width;
        
        label.frame = CGRectMake(x, 0, width, self.frame.size.height);
        self.lastLabel = label;
        [self.labels addObject:label];
    }
    
    self.timer = [NSTimer timerWithTimeInterval:0.01 repeats:YES block:^(NSTimer * _Nonnull timer) {
        for (UILabel *label in self.labels) {
            //判断是否有label到头了,有就挂起计时器任务,终止循环
            if (label.frame.origin.x + label.frame.size.width < 0) {
                label.frame = CGRectMake(self.lastLabel.frame.origin.x + self.lastLabel.frame.size.width, 0, label.frame.size.width, self.frame.size.height);
                self.lastLabel = label;
                [self pauseTimer];
                break;
            }
            label.frame = CGRectMake(label.frame.origin.x - 0.5, 0, label.frame.size.width, self.frame.size.height);
        }
    }];
    
    [self startTimer];
}


- (void)startTimer {
    if (self.timer) {
        [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
        [self.timer fire];
    }
}

- (void)pauseTimer {
    if (self.timer) {
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:5]];
    }
}

- (void)stopTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.lastLabel = nil;
    [self.labels removeAllObjects];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

-(NSMutableArray *)labels {
    if (!_labels) {
        _labels = [NSMutableArray array];
    }
    return _labels;
}

-(NSMutableArray *)titles {
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

- (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString

{
    
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
    
}
@end
