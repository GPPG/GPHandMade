//
//  GPFakeChatData.m
//  GPHandMade
//
//  Created by dandan on 16/6/29.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPFakeChatData.h"

static NSArray *namesArray;
static NSArray *iconNamesArray;
static NSArray *messagesArray;

@implementation GPFakeChatData
+ (NSString *)randomName
{
    int randomIndex = arc4random_uniform((int)[self names].count);
    return [self names][randomIndex];
}

+ (NSString *)randomIconImageName
{
    int randomIndex = arc4random_uniform((int)[self iconNames].count);
    return iconNamesArray [randomIndex];
}

+ (NSString *)randomMessage
{
    int randomIndex = arc4random_uniform((int)[self messages].count);
    return messagesArray[randomIndex];
}
+ (NSArray *)names
{
    if (!namesArray) {
        namesArray = @[@"小时候可白了",
                       @"我胸小随我爸@",
                       @"己所不欲，勿施于鱼",
                       @"作业对不起，我配不上你",
                       @"hello world",
                       @"背着书包去打架",
                       @"灭婊大队",
                       @"天天向上",
                       @"僵尸你吃了跳跳糖吗",
                       @"草你恶魔",
                       @"哈哈哈哈",
                       @"啦啦啦啦",
                       @"呵呵呵呵",
                       @"我是小菜蛋",
                       @"法海你不懂爱",
                       @"露露",
                       @"德玛西亚",
                       @"守望屁股",
                       @"你妹啊",
                       @"滚蛋气球",
                       @"你是?",
                       @"嘻嘻嘻",
                       @"大屁股",
                       @"白富美"
                       ];
    }
    return namesArray;
}

+ (NSArray *)iconNames
{
    if (!namesArray) {
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < 24; i++) {
            NSString *iconName = [NSString stringWithFormat:@"%d.jpg", i];
            [temp addObject:iconName];
        }
        iconNamesArray = [temp copy];
    }
    return iconNamesArray;
}

+ (NSArray *)messages
{
    if (!messagesArray) {
        messagesArray = @[@"小时候可白了：什么事？🐂🐂🐂🐂",
                          @"我胸小随我爸@：麻蛋！！！",
                          @"己所不欲，勿施于鱼：好好地，🐂别瞎胡闹",
                          @"作业对不起，我配不上你：https://github.com/GPPG",
                          @"hello world：🐂🐂🐂我不懂",
                          @"背着书包去打架：这。。。。。。酸爽~ https://github.com/GPPG",
                          @"你似不似傻：呵呵🐎🐎🐎🐎🐎🐎",
                          @"灭婊大队：辛苦了！",
                          @"不爱掏粪男孩：快快点点我 http://www.jianshu.com/users/3e324b24a2a8/latest_articles",
                          @"僵尸你吃了跳跳糖吗：[呲牙][呲牙][呲牙]",
                          @"草你恶魔：[图片]",
                          @"别给我晒脸：坑死我了。。。。。",
                          @"哈哈哈哈：你谁？？？🐎🐎🐎🐎",
                          @"筷子姐妹：和尚。。尼姑。。",
                          @"法海你不懂爱：春晚太难看啦，妈蛋的🐎🐎🐎🐎🐎🐎🐎🐎",
                          @"长城长：好好好~~~",
                          @"求点草求点草 http://www.jianshu.com/users/3e324b24a2a8/latest_articles",
                          @"我不搞笑：大大大大大",
                          @"原来我不帅：大大大大大大大？",
                          @"亲亲我的宝贝：你🐎说🐎啥🐎呢",
                          @"高高公公啊哦工熬过：好搞笑🐎🐎🐎，下次还来",
                          @"我是大逗逼：我不理解 http://www.jianshu.com/users/3e324b24a2a8/latest_articles",
                          @"十多年大乱斗：脱掉，脱掉，统统脱掉🐎",
                          @"急跌急跌的：好脏，好污，好喜欢"
                          ];
    }
    return messagesArray;
}


@end
