//
//  ViewController.m
//  CellAutoHeight
//
//  Created by lijinyang on 16/8/2.
//  Copyright © 2016年 noveleven. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "AutoCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UITableViewCell *cellKeeper;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UINib *cellNib = [UINib nibWithNibName:@"AutoCell" bundle:nil];
    [_tableView registerNib:cellNib forCellReuseIdentifier:@"AutoCell"];
    _cellKeeper  = [self.tableView dequeueReusableCellWithIdentifier:@"AutoCell"];
    
    _dataSource = @[@{@"image":@"https://upload.wikimedia.org/wikipedia/en/3/37/Calabashbrothers.jpg",
                      @"title":@"Calabash Brothers",
                      @"sub":@"1080P",
                      @"content":@"Calabash Brothers is a Chinese animation TV series produced by Shanghai Animation Film Studio. It is also referred to as Bottle Gourd Brothers, Hulu Brothers, Seven Brothers and Pumpkin Brothers. In China, the series is popularly known as Huluwa."},
                    
                    @{@"image":@"http://images.china.cn/attachement/jpg/site1000/20131016/d02788e9b6cd13c89d2223.jpg",
                      @"title":@"Journey to the West.",
                      @"sub":@"1080P",
                      @"content":@"Journey to the West is a Chinese novel published in the 16th century during the Ming dynasty and attributed to Wu Cheng'en. It is one of the Four Great Classical Novels of Chinese literature. In English-speaking countries, the work is widely known as Monkey, the title of Arthur Waley's popular abridged translation."}];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AutoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AutoCell"];
    NSDictionary *dict = _dataSource[indexPath.row];
    [cell.itemImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    cell.titleLabel.text = dict[@"title"];
    cell.subTitleLabel.text = dict[@"sub"];
    cell.contentLabel.text = dict[@"content"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AutoCell *cell = (AutoCell *)self.cellKeeper;
    NSDictionary *dict = _dataSource[indexPath.row];
    cell.contentLabel.text = dict[@"content"];

    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));/* get corrent size, important to `systemLayoutSizeFittingSize:` */
    [cell layoutIfNeeded];/* important */
    
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return 1  + size.height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

@end
