//
//  KGWelcomePageViewController.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/15.
//  Copyright (c) 2015年 slx. All rights reserved.
//

#import "KGWelcomePageViewController.h"
#import "KGHomePageViewController.h"

#define kStartButtonCenterYRadio 550.f/667.f
#define kPageControlCenterYRadio 630.f/667.f

@interface KGWelcomePageViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation KGWelcomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置scrollview，包括显示的图片，以及contentsize等
    [self setupScrollView];
    
    //scrollView填充屏幕
    _scrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //pageControl处于屏幕的637.f／667.f比例的位置
    _pageControl.center = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, [UIScreen mainScreen].bounds.size.height*kPageControlCenterYRadio);

    //设置pageControl的数量
    _pageControl.numberOfPages = 5;
}
#pragma mark 设置scrollview，包括显示的图片，以及contentsize等
- (void)setupScrollView{
    
    for (int i=0;i<5; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"introduction_%i",i+1]]];
        imageView.frame = CGRectMake(i*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        //添加开启音乐之旅的按钮
        if (i==4) {
            [self addStartButton:imageView];
            
        }
        
        [_scrollView addSubview:imageView];
    }
    _scrollView.contentSize = CGSizeMake(5*[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
}

#pragma mark 添加开启音乐之旅的按钮
- (void)addStartButton:(UIImageView *)imageView{
    imageView.userInteractionEnabled = YES;
    UIButton *startButton = [[UIButton alloc]init];
    startButton.bounds = CGRectMake(0, 0, 122, 32);
    startButton.center = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, [UIScreen mainScreen].bounds.size.height*kStartButtonCenterYRadio);
    [startButton setBackgroundImage:[UIImage imageNamed:@"introduction_enter_nomal"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"introduction_enter_press"] forState:UIControlStateHighlighted];
    [imageView addSubview:startButton];
    [startButton addTarget:self action:@selector(startKGplayer:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark 开启音乐之旅
- (void)startKGplayer:(UIButton *)sender{
    //直接将主页设置为window的rootViewController 这样就不会再回到欢迎页了
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KGHomePageViewController *homeVC = [storyBoard instantiateViewControllerWithIdentifier:@"HomePage"];
    [UIApplication sharedApplication].keyWindow.rootViewController = homeVC;
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger num = (NSUInteger)_scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    _pageControl.currentPage = num;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
