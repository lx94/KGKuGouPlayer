//
//  KGHomePageViewController.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/15.
//  Copyright (c) 2015年 slx. All rights reserved.
//

#import "KGHomePageViewController.h"
#import "KGHomePageMusicTableViewCell.h"

//用enum来区分三个不同的选项 自定义enum类型
typedef enum {
    eMyMusic = 0,
    eNetMusic,
    eMoreFounction
}eMusicSel;

@interface KGHomePageViewController ()
@property (weak, nonatomic) IBOutlet UIButton *icon;
- (IBAction)logon:(UIButton *)sender;
- (IBAction)signin:(UIButton *)sender;
- (IBAction)switchButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)myMusic:(UIButton *)sender;
- (IBAction)netMusic:(UIButton *)sender;
- (IBAction)moreFunction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;
@property (weak, nonatomic) IBOutlet UIButton *myMusicButton;
@property (weak, nonatomic) IBOutlet UIButton *netMusicButton;
@property (weak, nonatomic) IBOutlet UIButton *moreFunctionButton;


@property (assign,nonatomic) NSInteger curSelectedRow;
@property (strong,nonatomic) NSMutableArray *cellStatus;
@property (strong,nonatomic) NSArray *cellContents;
//用enum区分三个不同值
@property (assign,nonatomic) eMusicSel musicSel;
@end

@implementation KGHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.backgroundColor = [UIColor clearColor];
    //设置footerView为空，则没有文字的cell下边就不会有分割线
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    //默认选中的是我的音乐
    [self myMusic:_myMusicButton];
    
    _curSelectedRow = -1;
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (NSMutableArray *)cellStatus{
    if (_cellStatus ==nil) {
        _cellStatus = [NSMutableArray array];
        NSString *fileName = @"MyMusicSelList.plist";
        switch (_musicSel) {
            case eMyMusic:
            {
                fileName = @"MyMusicSelList.plist";
            }
                break;
            case eNetMusic:
            {
                fileName = @"webMusicList.plist";
            }
                break;
            case eMoreFounction:
            {
                fileName = @"MoreList.plist";
            }
                break;
            default:
                break;
        }
        _cellContents = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:fileName ofType:nil]];
        for (int i=0; i<_cellContents.count; i++) {
            NSDictionary *dict = @{@"selected":@0};
            KGMusicCellStatus *status = [KGMusicCellStatus musicCellStatusWithDict:dict];
            [_cellStatus addObject:status];
        }
    }
    return _cellStatus;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellStatus.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KGHomePageMusicTableViewCell *cell = [KGHomePageMusicTableViewCell homePageMusicTableViewCellWithTableView:tableView];
    cell.status = self.cellStatus[indexPath.row];
    if (_cellContents !=nil) {
        cell.textLabel.text = _cellContents[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (_curSelectedCell !=nil) {
//        _curSelectedCell.textLabel.textColor = [UIColor whiteColor];
//    }
//    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
//    selectedCell.textLabel.textColor = [UIColor orangeColor];
//    
//    _curSelectedCell = selectedCell;
    if (_curSelectedRow>=0) {
        KGMusicCellStatus *oldstatus = self.cellStatus[_curSelectedRow];
        oldstatus.selected = NO;
    }
    KGMusicCellStatus *status = self.cellStatus[indexPath.row];
    status.selected = YES;
    
    _curSelectedRow = indexPath.row;
    [self.tableView reloadData];
    
    [self performSegueWithIdentifier:@"toLocalMusic" sender:nil];
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 登录
- (IBAction)logon:(UIButton *)sender {
}
#pragma mark 注册
- (IBAction)signin:(UIButton *)sender {
}
#pragma mark 切换开关
- (IBAction)switchButton:(UIButton *)sender {
    sender.selected = !sender.selected;
}
#pragma mark 我的音乐
- (IBAction)myMusic:(UIButton *)sender {
    _myMusicButton.selected = YES;
    _netMusicButton.selected = NO;
    _moreFunctionButton.selected = NO;
    
    _musicSel = eMyMusic;
    _cellStatus = nil;
    _curSelectedRow = -1;
    [self.tableView reloadData];
    _arrow.center = CGPointMake(_arrow.center.x, sender.center.y);
}
#pragma mark 网络音乐
- (IBAction)netMusic:(UIButton *)sender {
    _myMusicButton.selected = NO;
    _netMusicButton.selected = YES;
    _moreFunctionButton.selected = NO;
    
    _musicSel = eNetMusic;
    _cellStatus = nil;
    _curSelectedRow = -1;
    [self.tableView reloadData];
    _arrow.center = CGPointMake(_arrow.center.x, sender.center.y);
}
#pragma mark 更多功能
- (IBAction)moreFunction:(UIButton *)sender {
    _myMusicButton.selected = NO;
    _netMusicButton.selected = NO;
    _moreFunctionButton.selected = YES;
    
    _musicSel = eMoreFounction;
    _cellStatus = nil;
    _curSelectedRow = -1;
    [self.tableView reloadData];
    _arrow.center = CGPointMake(_arrow.center.x, sender.center.y);
}
@end
