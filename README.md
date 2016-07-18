# GPHand
简
  100    
100 作者  我是小菜鸟 2016.07.18 15:19
写了17835字，被120人关注，获得了247个喜欢
iOS---精仿手工课~(Objective-C)
字数6133 阅读0 评论0 喜欢0
前言
手工课是利用业余时间完成的一个项目,这个项目适合刚刚接触 iOS 开发的新手用来练手,首先,这个开源项目中用到了许多优秀的开源框架,感谢开源,好了,废话不多说.让我们先来看一下这个项目中涉及到的知识点:

利用 UICollectionView 实现常见界面的搭建,以及自定义布局
转场动画的实现
利用 FMDB 实现数据储存
简单动画的实现
利用 Block实现封装一个常用的控件
如何封装一个常用的控制器
如何更好的使用三方类库,比如(AFN...)
我本来就是菜鸟,(看我名字就可以看出来了),希望各大神在代码结构给予指导.......,最后说一句,开源万岁

效果预览

新版本.gif

首页-精选.gif

首页-精选-直播.gif

教程01.gif

市集.gif

手工圈.gif

首页-达人.gif

首页-关注.gif

首页-活动01.gif

我的.gif

教程02.gif

首页-活动02.gif

首页-精选-02.gif
代码结构

Snip20160717_1.png

代码结构我比较喜欢按照业务来区分,大概就是这样子了

新版本特性
思路和实现都比较简单,需要注意的一点是将判断是否有新版本的逻辑提取出来,直接上代码

AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

    self.window.rootViewController = [GPGuideTool chooseRootViewController];
    [self configApper];
    [self.window makeKeyAndVisible];
    return YES;
}
判断逻辑
// 加载哪个控制器
+ (UIViewController *)chooseRootViewController
{
    UIViewController *rootVc = nil;

    NSDictionary *dict =  [NSBundle mainBundle].infoDictionary;

    // 获取最新的版本号
    NSString *curVersion = dict[@"CFBundleShortVersionString"];

    // 获取上一次的版本号
    NSString *lastVersion = [GPUserDefaults objectForKey:GPVersionKey];

    // 之前的最新的版本号 lastVersion
    if ([curVersion isEqualToString:lastVersion]) {
        // 版本号相等
        rootVc = [[GPAdViewController alloc]init];
    }else{ // 有最新的版本号
        // 保存到偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:curVersion forKey:GPVersionKey];
        rootVc = [[GPNewFeatureController alloc]init];
    }
    return rootVc;
}
新特性界面实现
- (instancetype)init
{
    // 流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

    // 设置cell的尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;

    // 设置每一行的间距
    layout.minimumLineSpacing = 0;

    // 设置每个cell的间距
    layout.minimumInteritemSpacing = 0;

    // 设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpCollectionView];

}

// 初始化CollectionView
- (void)setUpCollectionView
{
    // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPNewFeatureCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    // 取消弹簧效果
    self.collectionView.bounces = NO;

    // 取消显示指示器
    self.collectionView.showsHorizontalScrollIndicator = NO;

    // 开启分页模式
    self.collectionView.pagingEnabled = YES;

}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    GPNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    NSString *imageName = [NSString stringWithFormat:@"newfeature_0%ld_736",indexPath.item + 1];
    cell.image = [UIImage imageNamed:imageName];

    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {

        // 切换窗口的根控制器进行跳转

        [UIApplication sharedApplication].keyWindow.rootViewController = [[GPAdViewController alloc]init];

        CATransition *anim = [CATransition animation];
        anim.type = @"rippleEffect";
        anim.duration = 1;
        [[UIApplication sharedApplication].keyWindow.layer addAnimation:anim forKey:nil];
    }
}
请求数据
方式一
直接在 AFN上面简单包装一下

+(void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

}

+(void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
方式二
在上面的基础上再次进行封装

+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = [param mj_keyValues];
    [GPHttpTool get:url params:params success:^(id responseObj) {
        if (success) {
            id result = [resultClass mj_objectWithKeyValues:responseObj[@"data"]];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)getMoreWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = [param mj_keyValues];
    [GPHttpTool get:url params:params success:^(id responseObj) {
        if (success) {
            id result = [resultClass mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = [param mj_keyValues];

    [GPHttpTool post:url params:params success:^(id responseObj) {
        if (success) {
            id result = [resultClass mj_objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
首页

Snip20160718_2.png

首页的整体布局是用 UICollection View 实现的, 这里只贴一下关键代码,具体代码可以下载源代码查看

首页可滚动标题栏在多个地方涉及到,所以可以自己进行简单封装,这里我简单封装一下,在开源项目中此处我用到了一个优秀的三方:

#pragma mark - 懒加载
- (NSMutableArray *)btnArray
{
    if (!_btnArray) {

        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}
- (instancetype)initWithChildControllerS:(NSArray *)titleArray
{
    if (self = [super init]) {
        self.titleArray = titleArray;
        [self layout];
    }
    return self;

}
- (void)layout
{
    UIButton *lastBtn = nil;
    for (int i = 0; i < self.titleArray.count; i ++) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.userInteractionEnabled = NO;
        [self.btnArray addObject:btn];

        [self addSubview:btn];
        if (lastBtn) {
            btn.sd_layout
            .leftSpaceToView(lastBtn,40)
            .topSpaceToView(lastBtn,0)
            .bottomSpaceToView(lastBtn,0)
            .widthIs(40);
        }else{
            btn.sd_layout
            .leftSpaceToView(self,0)
            .topSpaceToView(self,0)
            .bottomSpaceToView(self,0)
            .widthIs(40);
        }
        lastBtn = btn;
    }
    [self setupAutoWidthWithRightView:lastBtn rightMargin:0];
}
// 改变按钮状态
-(void)changeSelectBtn:(UIButton *)btn
{
    self.previousBtn = self.currentBtn;
    self.currentBtn = btn;
    self.previousBtn.selected = NO;
    self.currentBtn.selected = YES;
}
// 更新按钮状态
-(void)updateSelecterToolsIndex:(NSInteger )index
{
    UIButton *selectBtn = self.btnArray[index];
    [self changeSelectBtn:selectBtn];
}
可滚动视图

- (instancetype)initWithChildControllerS:(NSArray *)vcArray selectBlock:(selecBlock)selecB
{
    if (self = [super init]) {
        self.selecB = selecB;
        self.backgroundColor = [UIColor whiteColor];
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.childVcArray = vcArray;
        [self layout];
    }
        return self;
}
- (void)layout
{
    UIView *lastView = nil;
    for (UIViewController *viewVc in self.childVcArray) {
        [self addSubview:viewVc.view];
        if (lastView) {
            viewVc.view.sd_layout
            .widthIs(SCREEN_WIDTH)
            .heightIs(SCREEN_HEIGHT)
            .leftSpaceToView(lastView,0);
        }else{
            viewVc.view.sd_layout
            .widthIs(SCREEN_WIDTH)
            .heightIs(SCREEN_HEIGHT)
            .leftSpaceToView(self,0);
        }
        lastView = viewVc.view;
    }
    [self setupAutoContentSizeWithRightView:lastView rightMargin:0];
}
-(void)updateVCViewFromIndex:(NSInteger )index
{
    [self setContentOffset:CGPointMake(index*SCREEN_WIDTH, 0) animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (scrollView.contentOffset.x + SCREEN_WIDTH / 2) / SCREEN_WIDTH;
    self.selecB(page);
}
轮播图
无限滚动的简单思路就是,当滚动到最右边或最左边的时候,交换图片,具体贴代码

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;

    // 初始化scrollView
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(w * 3, 0);
    _scrollView.contentOffset = CGPointMake(w, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;

    // 创建可见的imageView
    UIImageView *visibleView = [[UIImageView alloc] init];
    _visibleView = visibleView;
    _visibleView.image = [UIImage imageNamed:@"00"];
    _visibleView.frame = CGRectMake(w, 0, w, h);
    _visibleView.tag = 0;
    [_scrollView addSubview:_visibleView];

    // 创建重复利用的imageView
    UIImageView *reuseView = [[UIImageView alloc] init];
    _reuseView = reuseView;
    _reuseView.frame = self.view.bounds;
    [_scrollView addSubview:_reuseView];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat w = scrollView.frame.size.width;

    // 1.设置 循环利用view 的位置
    CGRect f = _reuseView.frame;
    NSInteger index = 0;

    if (offsetX > _visibleView.frame.origin.x) { // 显示在最右边

        f.origin.x = scrollView.contentSize.width - w;

        index = _visibleView.tag + 1;
        if (index >= kCount) index = 0;
    } else { // 显示在最左边
        f.origin.x = 0;

        index = _visibleView.tag - 1;
        if (index < 0) index = kCount - 1;
    }

    // 设置重复利用的视图
    _reuseView.frame = f;
    _reuseView.tag = index;
    NSString *icon = [NSString stringWithFormat:@"0%ld", index];
    _reuseView.image = [UIImage imageNamed:icon];


    // 2.滚动到 最左 或者 最右 的图片
    if (offsetX <= 0 || offsetX >= w * 2) {
        // 2.1.交换 中间的 和 循环利用的指针
        UIImageView *temp = _visibleView;
        _visibleView = _reuseView;
        _reuseView = temp;

        // 2.2.交换显示位置
        _visibleView.frame = _reuseView.frame;

        // 2.3 初始化scrollView的偏移量
        scrollView.contentOffset = CGPointMake(w, 0);

    }

}
滑动动画

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    CATransform3D rotation;//3D旋转
//    rotation = CATransform3DMakeTranslation(0 ,50 ,20);
            rotation = CATransform3DMakeRotation( M_PI_4 , 0.0, 0.7, 0.4);
    //逆时针旋转

    rotation = CATransform3DScale(rotation, 0.8, 0.8, 1);

    rotation.m34 = 1.0/ 1000;

    cell.layer.shadowColor = [[UIColor redColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;

    cell.layer.transform = rotation;

    [UIView beginAnimations:@"rotation" context:NULL];
    //旋转时间
    [UIView setAnimationDuration:0.6];

    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];

}
转场动画
关于转场动画,网上有好多大神写的博客,这里我就直接贴一些地址,有兴趣的可以看看,喵神,
wr大神;
登录界面


Snip20160718_8.png

登录界面是Jake lin的一个swift课程,我用OC 重新实现了一遍

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupAnimtion];
    [self addEventBar];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self nextAnimtion];
}
#pragma mark - 初始化
- (void)setupView
{
    self.navigationController.navigationBarHidden = YES;
    UIActivityIndicatorView *acView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.acView = acView;

    UIImageView *snipImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Warning"]];
    snipImageView.hidden = YES;
    [self.view addSubview:snipImageView];
    self.snipImageView = snipImageView;
}
- (void)addEventBar
{
    GPEventBtn *eventBtn = [[GPEventBtn alloc]init];
    [eventBtn setImage:[UIImage imageNamed:@"activity_works_Btn"] forState:UIControlStateNormal];
    [eventBtn sizeToFit];
    eventBtn.transform = CGAffineTransformMakeScale(2, 2);
    [eventBtn showEventButCenter:CGPointMake(SCREEN_WIDTH * 0.5 , SCREEN_HEIGHT - GPEventScale * eventBtn.width)];
    eventBtn.transform = CGAffineTransformMakeScale(2, 2);
    [eventBtn addTarget:self action:@selector(dismissVc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eventBtn];
    [self.view bringSubviewToFront:eventBtn];
    eventBtn.hidden = YES;
    self.eventBtn = eventBtn;
}

#pragma mark - 动画
- (void)setupAnimtion
{
    self.buble1.transform = CGAffineTransformMakeScale(0, 0);
    self.buble2.transform = CGAffineTransformMakeScale(0, 0);
    self.buble3.transform = CGAffineTransformMakeScale(0, 0);
    self.buble4.transform = CGAffineTransformMakeScale(0, 0);
    self.buble5.transform = CGAffineTransformMakeScale(0, 0);
    self.logo.centerX-= self.view.width;
    self.dot.centerX -= self.view.width/2;

    UIView *paddingUserView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, self.userName.height)];
    self.userName.leftView = paddingUserView;
    self.userName.leftViewMode = UITextFieldViewModeAlways;

    UIView *paddingPassView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, self.password.height)];
    self.password.leftView = paddingPassView;
    self.password.leftViewMode = UITextFieldViewModeAlways;


    UIImageView *userImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"User"]];
    userImageView.x = 5;
    userImageView.y = 5;
    [self.userName addSubview:userImageView];

    UIImageView *passImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Key"]];
    passImageView.x = 5;
    passImageView.y = 5;
    [self.password addSubview:passImageView];

    self.userName.centerX -= self.view.width;
    self.password.centerX -= self.view.width;
    self.loginBtn.centerX -= self.view.width;


}

- (void)nextAnimtion
{
    [UIView animateWithDuration:0.3 delay:0.3 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.buble1.transform = CGAffineTransformMakeScale(1, 1);
        self.buble2.transform = CGAffineTransformMakeScale(1, 1);
        self.buble3.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];

    [UIView animateWithDuration:0.3 delay:0.4 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.buble4.transform = CGAffineTransformMakeScale(1, 1);
        self.buble5.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];

    [UIView animateWithDuration:0.5 delay:0.5 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.logo.centerX += self.view.width;
    } completion:nil];

    [UIView animateWithDuration:0.4 delay:0.6 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.userName.centerX += self.view.width;
    } completion:nil];

    [UIView animateWithDuration:0.4 delay:0.7 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.password.centerX += self.view.width;
    } completion:nil];

    [UIView animateWithDuration:0.4 delay:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.loginBtn.centerX += self.view.width;
    } completion:nil];

    [UIView animateWithDuration:3 delay:1 usingSpringWithDamping:0.1 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.dot.centerX += self.view.width * 0.4;
    } completion:nil];


}
#pragma mark - 内部方法
- (IBAction)loginBtnClick:(UIButton *)sender {

    self.loginBtn.enabled = NO;
    self.acView.center = CGPointMake(0, 0);
    [self.acView startAnimating];
    [self.loginBtn addSubview:self.acView];
    self.snipImageView.center = self.loginBtn.center;
    self.loginPoint = self.loginBtn.center;

    [UIView animateWithDuration:0.3 animations:^{
        self.loginBtn.centerX -= 30;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.loginBtn.centerX += 30;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                self.loginBtn.centerY += 90;
                [self.acView removeFromSuperview];
            }completion:^(BOOL finished) {
                [UIView transitionWithView:self.snipImageView duration:0.3 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
                    self.snipImageView.hidden = NO;
                }completion:^(BOOL finished) {
                        [UIView transitionWithView:self.snipImageView duration:3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                            self.snipImageView.hidden = YES;
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.2 animations:^{
                                self.loginBtn.center = self.loginPoint;
                            }completion:^(BOOL finished) {
                                self.loginBtn.enabled = YES;
                            }];
                        }];
                }];
            }];
        }];
    }];
}
- (void)dismissVc
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.loginBtn removeFromSuperview];
    [UIView transitionWithView:self.eventBtn duration:0.5 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        self.eventBtn.hidden = NO;
    } completion:nil];
}
直播


Snip20160718_9.png
聊天界面搭建,用到了 SDAutoLayout,感兴趣的可以学习一下

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        [self setupView];

    }
    return self;
}
- (void)setupView
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    _iconImageView = [UIImageView new];
    [self.contentView addSubview:_iconImageView];

    _container = [UIView new];
    [self.contentView addSubview:_container];

    _label = [MLEmojiLabel new];
    _label.delegate = self;
    _label.font = [UIFont systemFontOfSize:16.0f];
    _label.numberOfLines = 0;
    _label.textInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _label.isAttributedContent = YES;
    [_container addSubview:_label];

    _messageImageView = [UIImageView new];
    [_container addSubview:_messageImageView];

    _containerBackgroundImageView = [UIImageView new];
    [_container insertSubview:_containerBackgroundImageView atIndex:0];

    _maskImageView = [UIImageView new];

    [self setupAutoHeightWithBottomView:_container bottomMargin:0];

    // 设置containerBackgroundImageView填充父view
    _containerBackgroundImageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));

}
- (void)setModel:(GPChatData *)model
{
    _model = model;

    _label.text = model.text;

    // 根据model设置cell左浮动或者右浮动样式
    [self setMessageOriginWithModel:model];

    if (model.imageName) { // 有图片的先看下设置图片自动布局

        // cell重用时候清除只有文字的情况下设置的container宽度自适应约束
        [self.container clearAutoWidthSettings];
        self.messageImageView.hidden = NO;

        self.messageImageView.image = [UIImage imageNamed:model.imageName];

        // 根据图片的宽高尺寸设置图片约束
        CGFloat standardWidthHeightRatio = kMaxChatImageViewWidth / kMaxChatImageViewHeight;
        CGFloat widthHeightRatio = 0;
        UIImage *image = [UIImage imageNamed:model.imageName];
        CGFloat h = image.size.height;
        CGFloat w = image.size.width;

        if (w > kMaxChatImageViewWidth || w > kMaxChatImageViewHeight) {

            widthHeightRatio = w / h;

            if (widthHeightRatio > standardWidthHeightRatio) {
                w = kMaxChatImageViewWidth;
                h = w * (image.size.height / image.size.width);
            } else {
                h = kMaxChatImageViewHeight;
                w = h * widthHeightRatio;
            }
        }

        self.messageImageView.size_sd = CGSizeMake(w, h);
        _container.sd_layout.widthIs(w).heightIs(h);

        // 设置container以messageImageView为bottomView高度自适应
        [_container setupAutoHeightWithBottomView:self.messageImageView bottomMargin:kChatCellItemMargin];

        // container按照maskImageView裁剪
        self.container.layer.mask = self.maskImageView.layer;

        __weak typeof(self) weakself = self;
        [_containerBackgroundImageView setDidFinishAutoLayoutBlock:^(CGRect frame) {
            // 在_containerBackgroundImageView的frame确定之后设置maskImageView的size等于containerBackgroundImageView的size
            weakself.maskImageView.size_sd = frame.size;
        }];

    } else if (model.text) { // 没有图片有文字情况下设置文字自动布局

        // 清除展示图片时候用到的mask
        [_container.layer.mask removeFromSuperlayer];

        self.messageImageView.hidden = YES;

        // 清除展示图片时候_containerBackgroundImageView用到的didFinishAutoLayoutBlock
        _containerBackgroundImageView.didFinishAutoLayoutBlock = nil;

        _label.sd_resetLayout
        .leftSpaceToView(_container, kLabelMargin)
        .topSpaceToView(_container, kLabelTopMargin)
        .autoHeightRatio(0); // 设置label纵向自适应

        // 设置label横向自适应
        [_label setSingleLineAutoResizeWithMaxWidth:kMaxContainerWidth];

        // container以label为rightView宽度自适应
        [_container setupAutoWidthWithRightView:_label rightMargin:kLabelMargin];

        // container以label为bottomView高度自适应
        [_container setupAutoHeightWithBottomView:_label bottomMargin:kLabelBottomMargin];
    }
}


- (void)setMessageOriginWithModel:(GPChatData *)model
{
    if (model.messageType == GPMessageTypeSendToOthers) {
        self.iconImageView.image = [UIImage imageNamed:@"001"];

        // 发出去的消息设置居右样式
        self.iconImageView.sd_resetLayout
        .rightSpaceToView(self.contentView, kChatCellItemMargin)
        .topSpaceToView(self.contentView, kChatCellItemMargin)
        .widthIs(kChatCellIconImageViewWH)
        .heightIs(kChatCellIconImageViewWH);

        _container.sd_resetLayout.topEqualToView(self.iconImageView).rightSpaceToView(self.iconImageView, kChatCellItemMargin);

        _containerBackgroundImageView.image = [[UIImage imageNamed:@"SenderTextNodeBkg"] stretchableImageWithLeftCapWidth:50 topCapHeight:30];
    } else if (model.messageType == GPMessageTypeSendToMe) {
        self.iconImageView.image = [UIImage imageNamed:@"003"];

        // 收到的消息设置居左样式
        self.iconImageView.sd_resetLayout
        .leftSpaceToView(self.contentView, kChatCellItemMargin)
        .topSpaceToView(self.contentView, kChatCellItemMargin)
        .widthIs(kChatCellIconImageViewWH)
        .heightIs(kChatCellIconImageViewWH);

        _container.sd_resetLayout.topEqualToView(self.iconImageView).leftSpaceToView(self.iconImageView, kChatCellItemMargin);

        _containerBackgroundImageView.image = [[UIImage imageNamed:@"ReceiverTextNodeBkg"] stretchableImageWithLeftCapWidth:50 topCapHeight:30];
    }

    _maskImageView.image = _containerBackgroundImageView.image;
}


#pragma mark - MLEmojiLabelDelegate

- (void)mlEmojiLabel:(MLEmojiLabel *)emojiLabel didSelectLink:(NSString *)link withType:(MLEmojiLabelLinkType)type
{
    if (self.didSelectLinkTextOperationBlock) {
        self.didSelectLinkTextOperationBlock(link, type);
    }
}
关注
这个界面,有一个下拉弹簧的效果,自定义了流水布局来实现

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    CGFloat offsetY = self.collectionView.contentOffset.y;
    NSArray *attrsArray = [super layoutAttributesForElementsInRect:rect];
    CGFloat collectionViewFrameHeight = self.collectionView.frame.size.height;
    CGFloat collectionViewContentHeight = self.collectionView.contentSize.height;
    CGFloat ScrollViewContentInsetBottom = self.collectionView.contentInset.bottom;
    CGFloat bottomOffset = offsetY + collectionViewFrameHeight - collectionViewContentHeight - ScrollViewContentInsetBottom;
    CGFloat numOfItems = [self.collectionView numberOfItemsInSection:nil];

    for (UICollectionViewLayoutAttributes *attr in attrsArray) {
        if (attr.representedElementCategory == UICollectionElementCategoryCell) {

        CGRect cellRect = attr.frame;
        if (offsetY <= 0) {
            CGFloat distance = fabs(offsetY) / 8;
            cellRect.origin.y += offsetY + distance * (CGFloat)(attr.indexPath.section + 1);

        }else if (bottomOffset > 0 ){
            CGFloat distance = bottomOffset / 8;
            cellRect.origin.y += bottomOffset - distance *(CGFloat)(numOfItems - attr.indexPath.section);
        }
        attr.frame = cellRect;
    }
}
    return attrsArray;
}
达人


Snip20160718_14.png

同样使用 UICoolectionView 布局,代码比较多可以看源码

#pragma mark - 初始化
- (instancetype)init
{
    // 流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize =[UIScreen mainScreen].bounds.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [self initWithCollectionViewLayout:layout];
}
- (void)setupNav
{
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    UIButton *disBtn = [[UIButton alloc]init];
    [disBtn setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
    disBtn.frame = CGRectMake(5, 25, 20, 20);
    [disBtn addTarget:self action:@selector(disBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.collectionView addSubview:disBtn];
}
- (void)regisCell
{
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPDaRenStepOneCell class]) bundle:nil] forCellWithReuseIdentifier:OneIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPDaRenStepTwoCell class]) bundle:nil] forCellWithReuseIdentifier:TwoIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPDaRenStepThreeCell class]) bundle:nil] forCellWithReuseIdentifier:TheerIdentifier];
}
- (void)loadData
{
        // 1.添加参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"c"] = @"Course";
        params[@"a"] = @"CourseDetial";
        params[@"vid"] = @"18";
        params[@"id"] = self.tagCpunt;

        __weak typeof(self) weakSelf = self;
        // 2.发起请求
        [GPHttpTool get:HomeBaseURl params:params success:^(id responder) {
            weakSelf.picData = [GPDaRenPicData mj_objectWithKeyValues:responder[@"data"]];

            weakSelf.stepArray = weakSelf.picData.step;
            weakSelf.stepToolsArray = weakSelf.picData.tools;
            weakSelf.stepMaetasArray = weakSelf.picData.material;
            weakSelf.stepPicArray = weakSelf.picData.step;

            [weakSelf.collectionView reloadData];
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"跪了"];
        }];
}
#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger row = 1;
    if (section == 2) {
       row = self.stepArray.count;
    }
    return row;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *collecTionCell = nil;
    if (indexPath.section == 0) {
        GPDaRenStepOneCell *oneCell = [collectionView dequeueReusableCellWithReuseIdentifier:OneIdentifier forIndexPath:indexPath];
        oneCell.picData = self.picData;
        collecTionCell = oneCell;
    }else if (indexPath.section == 1){
        GPDaRenStepTwoCell *twoCell = [collectionView dequeueReusableCellWithReuseIdentifier:TwoIdentifier forIndexPath:indexPath];
        twoCell.toolsArray = self.stepToolsArray;
        twoCell.materiaArray = self.stepMaetasArray;
        collecTionCell = twoCell;
    }else{
        GPDaRenStepThreeCell *threeCell = [collectionView dequeueReusableCellWithReuseIdentifier:TheerIdentifier forIndexPath:indexPath];
        threeCell.sumNum = self.stepPicArray.count;
        threeCell.currentNum = indexPath.row + 1;
        threeCell.setpData = self.stepPicArray[indexPath.row];
        threeCell.setpBtnClick = ^{
            [self setpPicBtnClick];
        };
        collecTionCell = threeCell;
    }
    return collecTionCell;
}
#pragma mark - 内部方法
- (void)disBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)setpPicBtnClick
{
    XWCoolAnimator *animator = [XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypePageFlip];
    GPDaRenPicsController *picsVc = [[GPDaRenPicsController alloc]init];
    picsVc.stepDataArray = self.stepPicArray;
    picsVc.picData = self.picData;
    [self xw_presentViewController:picsVc withAnimator:animator];
}
-(void)scroolCollection:(NSNotification *)ifno
{

    NSLog(@"%@",ifno.userInfo[@"pic"]);
    NSIndexPath *indexPath = ifno.userInfo[@"pic"];

    CGPoint point = CGPointMake((indexPath.row + 2) * SCREEN_WIDTH, 0);
    [self.collectionView setContentOffset:point];
}
活动


首页-活动01.gif

首页-活动02.gif
活动界面看似较多,其实就是用了两个 UICollectionView 做的子控制器,类似盆友圈的界面,需要注意离屏渲染,直接设置圆角会导致严重的卡顿

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self regisCell];
    [self configThame];
    [self loadData];
    self.title = @"我的作品";
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
#pragma mark - 懒加载
- (NSMutableArray *)picUrlS
{
    if (!_picUrlS) {

        _picUrlS = [[NSMutableArray alloc] init];
    }
    return _picUrlS;
}
- (NSMutableArray *)laudUrlS
{
    if (!_laudUrlS) {

        _laudUrlS = [[NSMutableArray alloc] init];
    }
    return _laudUrlS;
}
- (NSMutableArray *)sizeArray
{
    if (!_sizeArray) {

        _sizeArray = [[NSMutableArray alloc] init];
    }
    return _sizeArray;
}
#pragma mark - 初始化
- (void)regisCell
{
    [self.tableView registerClass:[GPTimeLineHeadCell class] forCellReuseIdentifier:HeadCell];
    [self.tableView registerClass:[GPTimeLineEventCell class] forCellReuseIdentifier:EventCell];
    [self.tableView registerClass:[GPTimeLineApperCell class] forCellReuseIdentifier:ApperCell];
    [self.tableView registerClass:[GPTimeLIneCommentCell class] forCellReuseIdentifier:CommentCell];
}
- (void)configThame
{
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma mark - 数据处理
- (void)loadData
{
    // 1.添加请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"] = @"HandCircle";
    params[@"a"] = @"info";
    params[@"vid"] = @"18";
    params[@"item_id"] = self.circleID;
    __weak typeof(self) weakSelf = self;
    // 2.请求数据
    [GPHttpTool get:HomeBaseURl params:params success:^(id responseObj) {

        weakSelf.timeLineData = [GPTimeLineData mj_objectWithKeyValues:responseObj[@"data"]];
        // 九宫格图片
        for (GPTimeLinePicData *PicData in weakSelf.timeLineData.pic) {
            [weakSelf.picUrlS addObject:PicData.url];
        }
        // 只有一张图片的尺寸
        GPTimeLinePicData *picFistData = weakSelf.timeLineData.pic.firstObject;
        [weakSelf.sizeArray addObjectsFromArray:@[picFistData.width,picFistData.height]];

        // 点赞头像
        for (GPTimeLineLaudData *laudData in weakSelf.timeLineData.laud_list) {
            [weakSelf.laudUrlS addObject:laudData.avatar];
        }

        // 评论
        weakSelf.commentS = weakSelf.timeLineData.comment;
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"小编出差了"];
    }];
}
#pragma mark - 内部方法

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger sectionRow = 1;
    if (section == 3) {
        sectionRow = self.commentS.count;
    }
    return sectionRow;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        GPTimeLineHeadCell *headLineCell = [tableView dequeueReusableCellWithIdentifier:HeadCell];
        headLineCell.sizeArray = self.sizeArray;
        headLineCell.timeLineData = self.timeLineData;
        headLineCell.picUrlArray = self.picUrlS;
        return headLineCell;
    }else if(indexPath.section == 1){
        GPTimeLineEventCell *timeEventCell = [tableView dequeueReusableCellWithIdentifier:EventCell];
            timeEventCell.lineData = self.timeLineData;
        timeEventCell.EventBtnClick = ^{
            [self eventBtnClcik];
        };
        timeEventCell.backgroundColor = [UIColor whiteColor];
            return timeEventCell;
    }else if (indexPath.section == 2){
        GPTimeLineApperCell *timeApperCell = [tableView dequeueReusableCellWithIdentifier:ApperCell];
                timeApperCell.laudnum = self.timeLineData.laud_num;
                timeApperCell.laudArray = self.laudUrlS;
                return timeApperCell;
    }else{
        GPTimeLIneCommentCell *timeCommentCell = [tableView dequeueReusableCellWithIdentifier:CommentCell];
                timeCommentCell.commentData = self.timeLineData.comment[indexPath.row];
                return timeCommentCell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH];
}
#pragma mark - 内部方法
- (void)eventBtnClcik
{
    GPLoginController *loginVc = [UIStoryboard storyboardWithName:@"GPLoginController" bundle:nil].instantiateInitialViewController;

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
    self.transition = [[HYBEaseInOutTransition alloc] initWithPresented:^(UIViewController *presented, UIViewController *presenting, UIViewController *source, HYBBaseTransition *transition) {
        HYBEaseInOutTransition *modal = (HYBEaseInOutTransition *)transition;

        modal.animatedWithSpring = YES;
    } dismissed:^(UIViewController *dismissed, HYBBaseTransition *transition) {
        // do nothing
    }];

    nav.transitioningDelegate = self.transition;
    [self presentViewController:nav animated:YES completion:NULL];

}
教程

Snip20160718_15.png

Snip20160718_16.png
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavTitleView];
    [self addChildVc];
    [self addConterView];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setGes) name:@"dawang" object:nil];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - 初始化
- (void)addNavTitleView
{
    __weak typeof(self) weakSelf = self;
    GPNavTitleView *titleView = [[GPNavTitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.6, 44) block:^(UIButton *button) {
        [weakSelf.containView updateVCViewFromIndex:button.tag];
    }];
    self.titleView = titleView;
    self.navigationItem.titleView = titleView;
}
// 添加子控制器
- (void)addChildVc
{
    self.picVc = [[GPTutorialPicController alloc]init];
    self.videoVc = [[GPTutoriaVideoController alloc]init];
    self.subVc = [[GPTutoriSubController alloc]init];
    self.chidVcArray = @[self.picVc,self.videoVc,self.subVc];
    [self addChildViewController:self.picVc];
    [self addChildViewController:self.videoVc];
    [self addChildViewController:self.subVc];
}
// 添加容器
- (void)addConterView
{
    __weak typeof(self) weakSelf = self;
  self.containView = [[GPContainerView alloc]initWithChildControllerS:self.chidVcArray selectBlock:^(int index) {
      [weakSelf.titleView updateSelecterToolsIndex:index];
    }];
    [self.view addSubview:self.containView];
    self.containView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}
手工圈


Snip20160718_17.png
这里由于我在本地保存了移动后的数据,用到了 FMDB

+ (void)initialize
{
    // 1.获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"handMore.sqlite"];
    // 2.得到数据库
    _db = [FMDatabase databaseWithPath:filename];
    NSLog(@"%@",filename);
    // 3.打开数据库
    if ([_db open]) {
        // 4.创表
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_more (id integer PRIMARY KEY AUTOINCREMENT, moreName blob NOT NULL,moreStr blob NOT NULL,Remark text NOT NULL)"];
       BOOL zero = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_zero (id integer PRIMARY KEY AUTOINCREMENT, moreName blob NOT NULL,moreStr blob NOT NULL,Remark text NOT NULL)"];
        if (result && zero) {
            NSLog(@"成功创表");
        } else {
            NSLog(@"创表失败");
        }
    }
}
+ (void)saveItemArray:(NSMutableArray *)itemArray remark:(NSString *)remark type:(NSMutableArray *)strArray
{
    NSData *nameData = [NSKeyedArchiver archivedDataWithRootObject:itemArray];
    NSData *strData = [NSKeyedArchiver archivedDataWithRootObject:strArray];

    [_db executeUpdateWithFormat:@"INSERT INTO t_more (moreName,moreStr,Remark) VALUES (%@, %@,%@)",nameData,strData,remark];
}
+ (void)saveZeroArray:(NSMutableArray *)itemArray remark:(NSString *)remark type:(NSMutableArray *)strArray
{
    NSData *nameData = [NSKeyedArchiver archivedDataWithRootObject:itemArray];
    NSData *strData = [NSKeyedArchiver archivedDataWithRootObject:strArray];

    [_db executeUpdateWithFormat:@"INSERT INTO t_zero (moreName,moreStr,Remark) VALUES (%@, %@,%@)",nameData,strData,remark];
}

+ (BOOL)updateItemArray:(NSArray *)moreNameArray strArray:(NSArray *)moreStrArray remark:(NSString *)remark
{
    NSData *nameData = [NSKeyedArchiver archivedDataWithRootObject:moreNameArray];
    NSData *strData = [NSKeyedArchiver archivedDataWithRootObject:moreStrArray];

    BOOL isSuccess = [_db executeUpdateWithFormat:@"UPDATE t_more SET moreName = %@,moreStr = %@ WHERE Remark = %@", nameData,strData,remark];

    if (isSuccess) {
        NSLog(@"更新成功");
    }else{
        NSLog(@"更新失败%@",_db.lastErrorMessage);
    }
    return isSuccess;
}
+ (BOOL)updateZeroArray:(NSArray *)moreNameArray strArray:(NSArray *)moreStrArray remark:(NSString *)remark
{
    NSData *nameData = [NSKeyedArchiver archivedDataWithRootObject:moreNameArray];
    NSData *strData = [NSKeyedArchiver archivedDataWithRootObject:moreStrArray];

    BOOL isSuccess = [_db executeUpdateWithFormat:@"UPDATE t_zero SET moreName = %@,moreStr = %@ WHERE Remark = %@", nameData,strData,remark];

    if (isSuccess) {
        NSLog(@"更新成功");
    }else{
        NSLog(@"更新失败%@",_db.lastErrorMessage);
    }
    return isSuccess;
}
+ (NSMutableArray *)list:(NSString *)name
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_more"];

    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *list = [NSMutableArray array];
    while (set.next) {
        NSData *item = [set objectForColumnName:name];
        list = [NSKeyedUnarchiver unarchiveObjectWithData:item];
    }
    return list;
}
+ (NSMutableArray *)zeroList:(NSString *)name
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_zero"];

    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *list = [NSMutableArray array];
    while (set.next) {
        NSData *item = [set objectForColumnName:name];
        list = [NSKeyedUnarchiver unarchiveObjectWithData:item];
    }
    return list;
}
市集
这个界面比较简单,就是 UICollectionView 的简单使用
C

- (void)loadNewData
{
    GPFariParmer *parmers = [[GPFariParmer alloc]init];
    parmers.c = @"Shiji";
    parmers.vid = @"18";
    parmers.a = self.product;
    __weak typeof(self) weakSelf = self;
    [GPFariNetwork fariDataWithParms:parmers success:^(GPFariData *fariData) {
        weakSelf.hotArray = [NSMutableArray arrayWithArray:fariData.hot];
        weakSelf.bestArray = [NSMutableArray arrayWithArray:fariData.best];
        weakSelf.topicBestArray = [NSMutableArray arrayWithArray:fariData.topicBest];
        weakSelf.topicArray = [NSMutableArray arrayWithArray:fariData.topic];
        GPFariTopicData *topicData = weakSelf.topicArray.lastObject;
        weakSelf.lastId = topicData.last_id;
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_header endRefreshing];
    } failuer:^(NSError *error) {
        [weakSelf.collectionView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"啦啦啦,失败了"];
    }];
}
- (void)loadMoreData
{
    GPFariParmer *parmers = [[GPFariParmer alloc]init];
    parmers.c = @"Shiji";
    parmers.vid = @"18";
    parmers.last_id = self.lastId;
    parmers.a = @"topicList";
    parmers.page = self.page;
    __weak typeof(self) weakSelf = self;
    [GPFariNetwork fariMoreDataWithParms:parmers success:^(NSArray *topicDataS) {
        [weakSelf.topicArray addObjectsFromArray:topicDataS];
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_footer endRefreshing];
    } failuer:^(NSError *error) {
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
}

#pragma mark - UICollectionView 数据源
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return SectionCouton;
}
我的

Snip20160718_18.png
这个界面在任何 app 都比较常见,所以没有用到静态单元格,而是用纯代码封装了一个控制器,即使在其他项目中依然可以快速搭建出类似的界面

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }

    return _groups;
}

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}
// 返回有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groups.count;
}

// 返回每一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 获取当前的组模型
    GPSettingGroup *group = self.groups[section];

    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    GPSettingCell *cell = [GPSettingCell cellWithTableView:tableView style:UITableViewCellStyleValue1];

    // 获取对应的组模型
    GPSettingGroup *group = self.groups[indexPath.section];

    // 获取对应的行模型
    GPSettingItem *item = group.items[indexPath.row];

    // 2.给cell传递模型
    cell.item = item;

    return cell;
}

// 返回每一组的头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // 获取组模型
    GPSettingGroup *group = self.groups[section];

    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    // 获取组模型
    GPSettingGroup *group = self.groups[section];

    return group.footer;
}

// 选中cell的时候调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出对应的组模型
    GPSettingGroup *group = self.groups[indexPath.section];

    // 取出对应的行模型
    GPSettingItem *item = group.items[indexPath.row];

    if (item.operation) {

        item.operation(indexPath);
        return;
    }
    // 判断下是否需要跳转
    if ([item isKindOfClass:[GPSettingArrowItem class]]) {

        // 箭头类型,才需要跳转

        GPSettingArrowItem *arrowItem = (GPSettingArrowItem *)item;

        if (arrowItem.destVcClass == nil) return;

        // 创建跳转控制器
        UIViewController *vc = [[arrowItem.destVcClass alloc] init];

        [self.navigationController pushViewController:vc animated:YES];
    }
}
M

#import <Foundation/Foundation.h>

@interface GPSettingGroup : NSObject
/** 组头 */
@property (nonatomic, copy) NSString *header;
/** 组尾 */
@property (nonatomic, copy) NSString *footer;
/**
 *  行模型
 */
@property (nonatomic, strong) NSMutableArray *items;
@end
V

@implementation GPSettingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)cellStyle
{
    static NSString *ID = @"cell";
    GPSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:cellStyle reuseIdentifier:ID];
    }
    return cell;
}
- (void)setItem:(GPSettingItem *)item
{
    _item = item;

    [self setUpData];

    [self setUpAccessoryView];
}
// 设置数据
- (void)setUpData
{
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.subtitle;
}
// 设置右边的辅助视图
- (void)setUpAccessoryView
{
    if ([_item isKindOfClass:[GPSettingArrowItem class]]) { // 箭头
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        self.accessoryView = nil;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}
最后说两句
由于代码量较大,所以还是上源码吧,源码地址

最后,死皮赖脸求个 Star,我是小菜蛋,我为自己带盐...
 推荐拓展阅读
 著作权归作者所有
如果觉得我的文章对您有用，请随意打赏。您的支持将鼓励我继续创作！

本文已收到 0 次打赏 
 喜欢  0 分享到微博 分享到微信 更多分享
×
读者打赏
Tiny
×
喜欢的用户
0条评论 （ 按时间正序· 按时间倒序· 按喜欢排序 ） 添加新评论关闭评论

  ⌘+Return 发表
