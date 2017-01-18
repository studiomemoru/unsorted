//
//  BaseListViewController (Objective-C)
//
//  [studio memoru]
//

#import "MEMBaseListViewController.h"


@interface MEMBaseListViewController ()
{
    UIActivityIndicatorView *m_indicator;

    UIView *m_indicatorBase;
    UILabel *m_noDataLabel;
    BOOL m_dispIndicator;
    NSString *m_noDataString;
    BOOL m_dispNoData;

}
@end


@implementation MEMBaseListViewController

//--------
@dynamic noDataText;

- (NSString*)noDataText
{
    return m_noDataString;
}

- (void)setNoDataText:(NSString *)noDataText
{
    m_noDataString= noDataText;
    if (m_noDataLabel) {
        m_noDataLabel.attributedText= [self attributedStringForNoData:noDataText];
    }
}

//--------

- (NSAttributedString*)attributedStringForNoData:(NSString*)text
{
    return [[NSAttributedString alloc] initWithString:text
                                           attributes: @{ NSForegroundColorAttributeName : [UIColor grayColor], NSFontAttributeName : [UIFont systemFontOfSize:14.0f] }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init]; //--不要な区切り線を消す

    m_indicatorBase= [[UIView alloc] initWithFrame:self.view.frame];
    
    m_indicator= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    m_indicator.color= [UIColor darkGrayColor];
    [m_indicatorBase addSubview:m_indicator];
    m_indicatorBase.exclusiveTouch= YES;
    
    m_noDataLabel= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 120)];
    m_noDataLabel.textAlignment= NSTextAlignmentCenter;
    m_noDataLabel.numberOfLines= 0;
    if (m_noDataString) {
        m_noDataLabel.attributedText= [self attributedStringForNoData:m_noDataString];
    }
    else {
		m_noDataLabel.attributedText= [self attributedStringForNoData:@"No Data"];
    }
    [m_indicatorBase addSubview:m_noDataLabel];
    
    [self registerCellInfo];
}

- (void)registerCellInfo
{
    //-- Should be overridden.

    self.cellReuseId= @"BaseListViewController_cell";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:self.cellReuseId];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    m_indicatorBase.frame = self.view.frame;

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self numberOfRows];
}

- (NSInteger)numberOfRows
{
    //-- Should be overridden.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSInteger const row= indexPath.row;
    
    if ([self numberOfRows] > row)
    {
        cell= [tableView dequeueReusableCellWithIdentifier:self.cellReuseId forIndexPath:indexPath];
        cell= [self configureCell:cell atRow:row];
    }
    else if (self.outsideCellReuseId)
    {
        cell= [tableView dequeueReusableCellWithIdentifier:self.outsideCellReuseId forIndexPath:indexPath];
        cell= [self configureOutsideCell:cell atRow:row];
    }
    return cell;
}

- (UITableViewCell *)configureCell:(UITableViewCell *)cell atRow:(NSInteger)row
{
    //-- Should be overridden.

    cell.textLabel.text= @"Cell";
    
    return cell;
}

- (UITableViewCell *)configureOutsideCell:(UITableViewCell *)cell atRow:(NSInteger)row
{
    //-- Should be overridden.
    
    cell.textLabel.text= @"More...";

    return nil;
}

#pragma mark - UITableViewDelegate

#if 0
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#endif

#pragma mark - Activity Indicator View

- (void)showActivityIndicator
{
    m_dispNoData= NO;
    if (!m_dispIndicator)
    {
        [self.view.superview addSubview:m_indicatorBase];
        
        CGRect r = m_indicatorBase.frame;
        CGPoint c= CGPointMake(r.size.width/2, r.size.height/2);
        m_indicator.center= c;
        m_indicator.hidden= NO;
        [m_indicator startAnimating];

        self.tableView.scrollEnabled= NO;
        m_noDataLabel.hidden= YES;

        m_dispIndicator= YES;
    }
}

- (void)hideActivityIndicator
{
    if (m_dispIndicator)
    {
        [m_indicator stopAnimating];

        [m_indicatorBase removeFromSuperview];
        self.tableView.scrollEnabled= YES;
        m_dispIndicator= NO;
    }
}

#pragma mark - No-Data Label

- (void)showNoData
{
    m_dispIndicator= NO;
    if (!m_dispNoData)
    {
        CGRect r = m_indicatorBase.frame;
        
        CGPoint c= CGPointMake(r.size.width/2, r.size.height/2.1);
        m_noDataLabel.center= c;
        m_noDataLabel.hidden= NO;
        m_indicator.hidden= YES;
        
        [self.view.superview addSubview:m_indicatorBase];

        m_dispNoData= YES;
    }
}

- (void)hideNoData
{
    if (m_dispNoData)
    {
        [m_indicatorBase removeFromSuperview];
        m_dispNoData= NO;
    }
}

@end
