//
//  Configure.m
//  MarkLite
//
//  Created by zhubch on 11/9/15.
//  Copyright © 2015 zhubch. All rights reserved.
//

#import "Configure.h"

#define RGB(x) [UIColor colorWithRGBString:x]
@implementation Configure

+ (instancetype)sharedConfigure
{
    static Configure *conf = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        NSString *path = [[NSString documentPath] stringByAppendingPathComponent:@"Configure.plist"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            conf = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        }else{
            conf = [[self alloc]init];
        }
        [conf reset];
    });
    return conf;
}

- (BOOL)saveToFile
{
    NSString *path = [[NSString documentPath] stringByAppendingPathComponent:@"Configure.plist"];
    
    return [NSKeyedArchiver archiveRootObject:self toFile:path];
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.highlightColor forKey:@"highlightColor"];
    [aCoder encodeObject:self.style forKey:@"style"];
    [aCoder encodeObject:self.themeColor forKey:@"themeColor"];
    [aCoder encodeBool:self.keyboardAssist forKey:@"keyboardAssist"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.highlightColor = [aDecoder decodeObjectForKey:@"highlightColor"];
        self.style = [aDecoder decodeObjectForKey:@"style"];
        self.themeColor = [aDecoder decodeObjectForKey:@"themeColor"];
        self.keyboardAssist = [aDecoder decodeBoolForKey:@"keyboardAssist"];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

- (void)reset
{    
    _highlightColor = @{
                        @"title":RGB(@"488FE1"),
                        @"link":RGB(@"465DC6"),
                        @"image":RGB(@"A17A8C"),
                        @"bold":RGB(@"000000"),
                        @"quotes":RGB(@"60736B"),
                        @"deletion":RGB(@"916132"),
                        @"separate":RGB(@"BD1586"),
                        @"list":RGB(@"543429"),
                        @"code":RGB(@"7FA684"),
                        };
    _style = @"GitHub2";
    _keyboardAssist = YES;
}

@end
