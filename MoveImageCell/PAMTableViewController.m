//
//  PAMTableViewController.m
//  MoveImageCell
//

#import "PAMTableViewController.h"
#import "PAMCell.h"

@interface PAMTableViewController ()

@end

@implementation PAMTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Cellにはnibを登録
    UINib *cellNib =[UINib nibWithNibName:NSStringFromClass([PAMCell class]) bundle:nil];
    [self.tableView registerNib: cellNib forCellReuseIdentifier:@"Cell"];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // スクロールの監視を始める
    [self.tableView addObserver:self
                     forKeyPath:@"contentOffset"
                        options:NSKeyValueObservingOptionNew
                        context:nil];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // スクロールの監視を終わる
    [self.tableView removeObserver:self
                        forKeyPath:@"contentOffset"];
}

// スクロールしたら呼び出される
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context
{
    // 表示されているCellに、写真の位置をずらす指示を出す
    NSArray *cells = [self.tableView visibleCells];
    for (PAMCell *cell in cells) {
        [cell movePhotoWithTableView:self.tableView];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    PAMCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // cellの写真位置を調整しておく。
    [cell movePhotoWithTableView:tableView];
    
    return cell;
}
@end
