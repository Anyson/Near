//
//  WelcomeViewController.m
//  Near
//
//  Created by ADC on 14-12-11.
//  Copyright (c) 2014年 ANY. All rights reserved.
//

#import "WelcomeViewController.h"
#import "RegisterViewController.h"
#import "PrivacyViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setupSubviews {
    UIImageView *bgView = [Common generateImageViewWithImage:IMAGE(@"welcome-bg")];
    [self.view addSubview:bgView];
    
    UIButton *privacyBtn = [Common generateButtonWithTarget:self
                                                     action:@selector(privacyBtnPress)];
    [privacyBtn setTitle:@"隐私政策与用户协议" forState:UIControlStateNormal];
    [privacyBtn setTitleColor:RGB_TEXT_COLOR_2 forState:UIControlStateNormal];
    [[privacyBtn titleLabel] setFont:FONT(11)];
    [privacyBtn sizeToFit];//
    [self.view addSubview:privacyBtn];
    
    UIView *line = [Common generateViewWithBackgroundColor:RGB_TEXT_COLOR_2];
    [self.view addSubview:line];
    
    
    UIButton *startBtn = [Common generateButtonWithTarget:self action:@selector(startBtnPress)];
    [startBtn setTitle:@"开始使用" forState:UIControlStateNormal];
    [startBtn setTitleColor:RGB_TEXT_COLOR_2 forState:UIControlStateNormal];
    //[[startBtn titleLabel] setFont:FONT(11)];
    startBtn.layer.cornerRadius = 8.0f;
    startBtn.layer.borderColor = RGB_TEXT_COLOR_2.CGColor;
    startBtn.layer.borderWidth = 1.0f;
    [self.view addSubview:startBtn];
    
    UIView *textContentView = [Common generateViewWithBackgroundColor:nil];
    [self.view addSubview:textContentView];
    
    
    [self setupTextView:textContentView];
    
    NSDictionary *viewDict = NSDictionaryOfVariableBindings(bgView, privacyBtn, line, startBtn, textContentView);
   
    //bgview
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bgView]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewDict]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[bgView]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewDict]];
    
    
    // privacybtn, line
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[privacyBtn(==12)]-0.5-[line(==0.5)]-22-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewDict]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[line(==privacyBtn)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewDict]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:line
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0]];//
   
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:privacyBtn
                                                          attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX multiplier:1.0
                                                           constant:0]];//
    
    //start btn
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[startBtn(==44)]-55-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewDict]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-31-[startBtn]-31-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewDict]];
    
    //textContentView
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[textContentView]-0-[startBtn]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewDict]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[textContentView]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewDict]];
    

//    [Common addConstraintWithSuperView:self.view
//                         visualFormats:@[@"H:|-0-[bgView]-0-|",
//                                         @"V:|-0-[bgView]-0-|"]
//                                 views:viewDict];

}

- (void)setupTextView:(UIView *)superView {
    UIView *contentView = [Common generateViewWithBackgroundColor:nil];
    [superView addSubview:contentView];
    
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                          attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:superView
                                                          attribute:NSLayoutAttributeCenterX multiplier:1.0
                                                           constant:0]];
    
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual toItem:superView
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0]];
    
    UILabel *titleLabel = [Common generateLabelWithText:@"Near"
                                          textAlignment:NSTextAlignmentCenter
                                                   font:FONT(41)
                                              textColor:RGB_TEXT_COLOR_2];
    [contentView addSubview:titleLabel];
    
    UILabel *titleLabel2 = [Common generateLabelWithText:@"邂逅看得见的人"
                                          textAlignment:NSTextAlignmentCenter
                                                   font:FONT(22)
                                              textColor:RGB_TEXT_COLOR_2];
    [contentView addSubview:titleLabel2];
    
    UILabel *titleLabel3 = [Common generateLabelWithText:@"当你和TA之间的距离不超过50米，打开面对面，锁定心动频率。"
                                          textAlignment:NSTextAlignmentCenter
                                                   font:FONT(15)
                                              textColor:RGB_TEXT_COLOR_2];
    titleLabel3.numberOfLines = 2;
    [contentView addSubview:titleLabel3];
    
    CGSize size = CGSizeMake(SCREEN_WIDTH, 53);
    
    size.height += [titleLabel sizeThatFits:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)].height;
    size.height += [titleLabel2 sizeThatFits:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)].height;
    size.height += [titleLabel3 sizeThatFits:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)].height;
    
    NSDictionary *viewDict = NSDictionaryOfVariableBindings(contentView, titleLabel, titleLabel2, titleLabel3);
    
    [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[contentView(==%f)]", size.height]
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewDict]];
    
    [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[contentView]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewDict]];
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[titleLabel]-0-|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewDict]];
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[titleLabel2]-0-|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewDict]];
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[titleLabel3]-20-|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewDict]];
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[titleLabel]-22-[titleLabel2]-33-[titleLabel3]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewDict]];
}

#pragma mark - action 
- (void)privacyBtnPress {
    [self.navigationController pushViewController:[[PrivacyViewController  alloc] init] animated:YES];
}

- (void)startBtnPress {
    [self.navigationController pushViewController:[[RegisterViewController alloc] init] animated:YES];
}
 
 

@end
