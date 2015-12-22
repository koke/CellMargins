#import "EmbeddedTableView.h"

@interface EmbeddedTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) UITableViewStyle tableStyle;
@property (nonatomic, strong) UITableView *tableView;
@end

static UIScrollView *FindViewOfClass(UIView *inView, Class viewClass) {
    for (UIView *view in [inView subviews]) {
        if ([view isKindOfClass:viewClass]) {
            return (UIScrollView *)view;
        }
    }
    return nil;
}

@interface UITableView ()
- (void)_setSectionContentInset:(UIEdgeInsets)inset;
@end

@implementation EmbeddedTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.tableStyle = style;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    return self;
}

- (void)viewDidLoad {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:self.tableStyle];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    self.tableView.cellLayoutMarginsFollowReadableWidth = NO;
    self.view.backgroundColor = self.tableView.backgroundColor;
    [self.view addSubview:tableView];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    UIScrollView *viewToInset = FindViewOfClass(self.tableView, [UIScrollView class]);
    CGRect tableFrame = self.view.bounds;
    CGFloat inset = 0;
    if (tableFrame.size.width > 600) {
        inset = (tableFrame.size.width - 600) / 2;
    }
    tableFrame = CGRectInset(tableFrame, inset, 0);
//    NSLog(@"Found wrapper: %@", viewToInset);
//    NSLog(@"Setting frame: %@", NSStringFromCGRect(tableFrame));
//    viewToInset.frame = tableFrame;
//    CGSize contentSize = self.tableView.intrinsicContentSize;
//    contentSize.width = MIN(600, contentSize.width);
//    self.tableView.contentSize = contentSize;
    NSLog(@"setting inset %f", inset);
    [self.tableView _setSectionContentInset:UIEdgeInsetsMake(0, inset, 0, inset)];
//    self.tableView.contentInset = UIEdgeInsetsMake(0, -inset, 0, -inset);
    viewToInset.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, - inset);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = @"Example Text";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:@"sample"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Delete";
}


@end
