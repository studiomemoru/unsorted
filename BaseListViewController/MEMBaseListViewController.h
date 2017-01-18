//
//  BaseListViewController (Objective-C)
//
//  [studio memoru]
//

#import <UIKit/UIKit.h>

@interface MEMBaseListViewController : UITableViewController

@property(strong,nonatomic) NSString *cellReuseId;
@property(strong,nonatomic) NSString *outsideCellReuseId;
@property(nonatomic) NSString *noDataText;

- (void)registerCellInfo;
- (NSInteger)numberOfRows;
- (UITableViewCell *)configureCell:(UITableViewCell *)cell atRow:(NSInteger)row;
- (UITableViewCell *)configureOutsideCell:(UITableViewCell *)cell atRow:(NSInteger)row;
- (void)showActivityIndicator;
- (void)hideActivityIndicator;
- (void)showNoData;
- (void)hideNoData;

@end
