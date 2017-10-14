//
//  DiscoverSearchViewController.m
//  Class-Box
//
//  Created by Wrappers Zhang on 2017/10/6.
//  Copyright © 2017 sherlock. All rights reserved.
//

#import "DiscoverSearchViewController.h"

@interface  DiscoverSearchViewController()<UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource>


@end

@implementation DiscoverSearchViewController {
    UISearchController *_searchController;
    UITableView *_resultTableView;
}


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self setUpView];
}

#pragma mark - 初始化
- (void)setUpView {
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
}

- (void)setNavigationBar {
    [self setTitle:@"搜索"];

}
@end
