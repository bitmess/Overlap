//
//  OverlapView.m
//  Overlap
//
//  Created by jv on 2017/8/6.
//  Copyright © 2017年 jv. All rights reserved.
//

#import "OverlapView.h"

static CGFloat const kAniTime = .25;
static NSString* const kAni = @"moveY";
static CGFloat const kContainerHeight = 50;

@interface OverlapView ()
{
    
    UITapGestureRecognizer *_tapTop;
    UITapGestureRecognizer *_tapBottom;
    
    float _move;
    float _minTop;
    
    int _flag;
}

@property (strong, nonatomic) UIView *lapTop;
@property (strong, nonatomic) UIView *lapBottom;

@end

@implementation OverlapView

- (void)dealloc {
    
#if DEBUG
    NSLog(@"%s",__FUNCTION__);
#endif
    
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    
    self.height = kContainerHeight * 2;

    _tapTop = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_topAction:)];
    _tapBottom = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_bottomAction:)];

    
    _lapBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, kContainerHeight)];
    _lapBottom.top = (self.height - _lapBottom.height) / 2 + _lapBottom.height / 3;
    _lapBottom.backgroundColor = [UIColor greenColor];
    [_lapBottom addGestureRecognizer:_tapBottom];
    [self addSubview:_lapBottom];

    
    _lapTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, kContainerHeight)];
    _lapTop.top = (self.height - _lapTop.height) / 2 - _lapTop.height / 3;
    _lapTop.backgroundColor = [UIColor blueColor];
    [_lapTop addGestureRecognizer:_tapTop];
    [self addSubview:_lapTop];
    
    
    _move = (_lapTop.height - (_lapBottom.top - _lapTop.top)) / 2;
    _minTop = _lapTop.top - _move;
    
}

#pragma mark - action

- (void)_topAction:(UITapGestureRecognizer *)ges {
   
    [self _justDoit];
    
}


- (void)_bottomAction:(UITapGestureRecognizer *)ges {
    
    [self _justDoit];
    
}

#pragma mark - method

- (void)_justDoit {
    
    if ([_lapTop pop_animationForKey:kAni]) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, kAniTime * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        __strong typeof (weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        
        [strongSelf exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
        
    });
    
    POPBasicAnimation *p = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    p.toValue = [NSValue valueWithCGRect:CGRectMake(0, _lapTop.top - _move, _lapTop.width, _lapTop.height)];
    p.autoreverses = YES;
    p.duration = kAniTime;
    p.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_lapTop pop_addAnimation:p forKey:kAni];

    p = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    p.toValue = [NSValue valueWithCGRect:CGRectMake(0, _lapBottom.top + _move, _lapBottom.width, _lapBottom.height)];
    p.autoreverses = YES;
    p.duration = kAniTime;
    p.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_lapBottom pop_addAnimation:p forKey:kAni];
    
}


@end
