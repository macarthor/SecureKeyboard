//
//  NSKKeyboardTypingNumView.m
//  NSKSecureKeyboard
//
//  Created by McArthor Lee on 2018/11/15.
//  Copyright © 2018 McArthor Lee. All rights reserved.
//

#import "NSKKeyboardTypingNumView.h"

#define kIdentifier (NSStringFromClass([NSKKeyboardTypingNumView class]))

#define kColumnCount 3
#define kItemCount 12

@interface NSKKeyboardTypingNumView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic) NSMutableArray<NSNumber *> *randomNumberArray;

@end

@implementation NSKKeyboardTypingNumView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self generateRandomNumber];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UICollectionViewLayout *layout = self.collectionView.collectionViewLayout;
    ((UICollectionViewFlowLayout *) layout).itemSize = [self calculateItemSize];
    [self.collectionView setCollectionViewLayout:layout];
    self.collectionView.frame = self.bounds;
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return kItemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIdentifier forIndexPath:indexPath];

    UILabel *label = cell.subviews.firstObject;
    NSString *text;
    NSUInteger number = indexPath.row;
    if (number == 10) {
        text = @"空格";
    } else if (number == 11) {
        text = @"删除";
    } else {
        text = [NSString stringWithFormat:@"%@", [_randomNumberArray objectAtIndex:number]];
    }
    [label setText:text];

    [cell addSubview:label];
    return cell;
}

#pragma mark - UICollectionViewDelegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (![self.delegate respondsToSelector:@selector(typeACharacter:)]
        || ![self.delegate respondsToSelector:@selector(typeDelete)]) {
        return;
    }
    NSUInteger number = indexPath.row;
    if (number == 10) {
        [self.delegate typeACharacter:@" "];
    } else if (number == 11) {
        [self.delegate typeDelete];
    } else {
        [self.delegate typeACharacter:[self.randomNumberArray objectAtIndex:number].stringValue];
    }
}

#pragma mark - Private methods

- (void)setupView {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = kItemSpacing;
    layout.minimumInteritemSpacing = kItemSpacing;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    UINib *cellNib = [UINib nibWithNibName:@"NumViewCell" bundle:FRAMEWORK_BUNDLE];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:kIdentifier];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self addSubview:self.collectionView];
}

- (void)generateRandomNumber {
    _randomNumberArray = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *startArray = [[NSMutableArray alloc] initWithObjects:@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, nil];
    NSUInteger round = startArray.count;
    for (int i = 0; i < round; i++) {
        int rndIndex = arc4random() % startArray.count;
        _randomNumberArray[i] = startArray[rndIndex];
        startArray[rndIndex] = [startArray lastObject];
        [startArray removeLastObject];
    }
}

- (CGSize)calculateItemSize {
    CGFloat itemWidth = (self.bounds.size.width - (kColumnCount - 1) * kItemSpacing) / kColumnCount;
    NSUInteger rowCount = ((kItemCount % kColumnCount == 0) ? (kItemCount / kColumnCount) : (kItemCount / kColumnCount + 1));
    CGFloat itemHeight = (self.bounds.size.height - (rowCount - 1) * kItemSpacing) / rowCount;
    return CGSizeMake(itemWidth, itemHeight);
}

@end
