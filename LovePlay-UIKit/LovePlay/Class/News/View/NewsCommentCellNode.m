//
//  NewsCommentCellNode.m
//  LovePlay
//
//  Created by Yuns on 2017/2/4.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsCommentCellNode.h"
#import "NewsCommentModel.h"
#import "NewsCommentReplyAreaNode.h"

@interface NewsCommentCellNode ()
//UI
@property (nonatomic, strong) UIImageView *imageNode;
@property (nonatomic, strong) UILabel *nameTextNode;
@property (nonatomic, strong) UILabel *locationTextNode;
@property (nonatomic, strong) UIButton *voteBtnNode;
@property (nonatomic, strong) UILabel *contentTextNode;
@property (nonatomic, strong) UIView *underLineNode;
@property (nonatomic, strong) NewsCommentReplyAreaNode *commentReplyAreaNode;
//Data
@property (nonatomic, strong) NewsCommentItem *commentItem;

@property (nonatomic, strong) NSDictionary *commentItemsDict;
@property (nonatomic, strong) NSArray *commentIdsArray;
@end

@implementation NewsCommentCellNode

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"NewsCommentCellNode";
    NewsCommentCellNode *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NewsCommentCellNode alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubnodes];
        [self sd_autoLayoutSubViews];
    }
    return self;
}

- (void)addSubnodes
{
    UIImageView *imageNode = [[UIImageView alloc] init];
    [self.contentView addSubview:imageNode];
    _imageNode = imageNode;
    
    UILabel *nameTextNode = [[UILabel alloc] init];
    nameTextNode.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:nameTextNode];
    _nameTextNode = nameTextNode;
    
    UILabel *locationTextNode = [[UILabel alloc] init];
    locationTextNode.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:locationTextNode];
    _locationTextNode = locationTextNode;
    
    UIButton *voteBtnNode = [[UIButton alloc] init];
    [self.contentView addSubview:voteBtnNode];
    _voteBtnNode = voteBtnNode;
//    
//    if (_commentIdsArray.count > 1) {
//        
//    }
    NewsCommentReplyAreaNode *commentReplyAreaNode = [[NewsCommentReplyAreaNode alloc] init];
    [self.contentView addSubview:commentReplyAreaNode];
    _commentReplyAreaNode = commentReplyAreaNode;
    
    UILabel *contentTextNode = [[UILabel alloc] init];
    contentTextNode.numberOfLines = 0;
    [self.contentView addSubview:contentTextNode];
    _contentTextNode = contentTextNode;
    
    UIView *underLineNode = [[UIView alloc] init];
    underLineNode.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:underLineNode];
    _underLineNode = underLineNode;
    
//    imageNode.backgroundColor = [UIColor orangeColor];
//    nameTextNode.backgroundColor = [UIColor yellowColor];
//    locationTextNode.backgroundColor = [UIColor blueColor];
//    voteBtnNode.backgroundColor = [UIColor redColor];
//    contentTextNode.backgroundColor = [UIColor cyanColor];
}

- (void)setupCommentItems:(NSDictionary *)commentItems commmentIds:(NSArray *)commmentIds
{
    _commentItemsDict = commentItems;
    _commentIdsArray = commmentIds;
    _commentItem = commentItems[commmentIds.lastObject];
    _imageNode.imageURL = [NSURL URLWithString:_commentItem.user.avatar];
    _nameTextNode.text = _commentItem.user.nickname ? _commentItem.user.nickname : @"火星网友";
    _locationTextNode.text = _commentItem.user.location ? _commentItem.user.location : @"火星";
    [_voteBtnNode setTitle:[NSString stringWithFormat:@"%@顶",@(_commentItem.vote)] forState:UIControlStateNormal];
    _contentTextNode.text = _commentItem.content;
    
    [_commentReplyAreaNode setupCommentItems:_commentItemsDict floors:_commentIdsArray];
}

#pragma mark - layout
- (void)sd_autoLayoutSubViews
{
    _imageNode.sd_layout
    .widthIs(40)
    .heightIs(40)
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 10);
    
    _voteBtnNode.sd_layout
    .widthIs(50)
    .heightIs(20)
    .topEqualToView(_imageNode)
    .rightSpaceToView(self.contentView, 10);
    
    _nameTextNode.sd_layout
    .topEqualToView(_imageNode)
    .leftSpaceToView(_imageNode, 5)
    .rightSpaceToView(_voteBtnNode, 10)
    .autoHeightRatio(0);
    [_nameTextNode setMaxNumberOfLinesToShow:1];
    
    _locationTextNode.sd_layout
    .leftEqualToView(_nameTextNode)
    .bottomEqualToView(_imageNode)
    .rightEqualToView(_nameTextNode)
    .autoHeightRatio(0);
    [_locationTextNode setMaxNumberOfLinesToShow:1];
    
    _commentReplyAreaNode.sd_layout
    .topSpaceToView(_imageNode, 10)
    .leftEqualToView(_nameTextNode)
    .rightEqualToView(_voteBtnNode);
    
    _contentTextNode.sd_layout
    .topSpaceToView(_commentReplyAreaNode, 10)
    .leftEqualToView(_nameTextNode)
    .rightEqualToView(_voteBtnNode)
    .autoHeightRatio(0);
    [_contentTextNode setMaxNumberOfLinesToShow:0];
//    _contentTextNode.sd_layout
//    .topSpaceToView(_imageNode, 10)
//    .leftEqualToView(_nameTextNode)
//    .rightEqualToView(_voteBtnNode)
//    .autoHeightRatio(0);
//    [_contentTextNode setMaxNumberOfLinesToShow:0];
    
    _underLineNode.sd_layout
    .heightIs(0.5)
    .topSpaceToView(_contentTextNode, 10)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView);
    
    [self setupAutoHeightWithBottomView:_underLineNode bottomMargin:0];
}

@end