//
//  ViewController.m
//  NestScroll
//
//  Created by 黄文鸿 on 2019/11/19.
//  Copyright © 2019 黄文鸿. All rights reserved.
//

#import "ViewController.h"
#import <VTMagic.h>
#import "SubScrollViewController.h"
#import "GKScrollView.h"
#import "UIView+Extension.h"

@interface ViewController ()<VTMagicViewDataSource, VTMagicViewDelegate>

@property (nonatomic, strong) UILabel *header;
@property (nonatomic, strong) GKScrollView *contentView;
@property (nonatomic, strong) VTMagicController *magicController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    [self setupSubview];
    [self.magicController.magicView reloadData];
}

//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    [self layout];
//}

- (void)setupSubview {
    self.contentView = ({
        GKScrollView *contentV = [GKScrollView new];
        [self.view addSubview:contentV];
        contentV;
    });
    
    self.header = ({
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"This is header";
        label.font = [UIFont boldSystemFontOfSize:20];
        label.textColor = [UIColor blackColor];
        [self.contentView addSubview:label];
        label;
    });
    
    [self addChildViewController:self.magicController];
    [self.contentView addSubview:self.magicController.view];
    [self.magicController didMoveToParentViewController:self];
    
    [self layout];
}

- (void)layout {
    self.contentView.frame = self.view.bounds;
    self.header.frame = CGRectMake(0, UIApplication.sharedApplication.statusBarFrame.origin.y, self.view.width, self.view.width*(9.0/16.0));
    self.magicController.view.frame = CGRectMake(0, self.header.maxY, self.view.width, self.view.height);
    self.contentView.contentSize = CGSizeMake(self.view.width, self.magicController.view.maxY - 44);
}

#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    return @[@"界面1", @"界面2"];
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier1";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        menuItem.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    [menuItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [menuItem setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    return menuItem;
}
- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    SubScrollViewController *sub = [[SubScrollViewController alloc] initWithStyle:UITableViewStylePlain];
    sub.tag = pageIndex;
    return sub;
}

- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    self.contentView.currentSubScrollView = [(SubScrollViewController *)viewController tableView];
}

#pragma mark - getter
- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.view.translatesAutoresizingMaskIntoConstraints = NO;
        _magicController.magicView.navigationColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
        _magicController.magicView.layoutStyle = VTLayoutStyleDivide;
        _magicController.magicView.separatorHidden = YES;
        _magicController.magicView.sliderWidth = 20.0f;
        _magicController.magicView.sliderHeight = 3;
        _magicController.magicView.itemScale = 1.1;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
    }
    return _magicController;
}
@end
