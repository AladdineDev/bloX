import 'package:blox/features/auth/models/user.dart';
import 'package:equatable/equatable.dart';

typedef PostId = String;

class Post extends Equatable {
  const Post({
    required this.id,
    required this.userId,
    required this.content,
    this.mediaUrl,
    this.timestamp,
    this.views = const [],
    this.likes = const [],
    this.comments = const [],
    this.reposts = const [],
    this.quotes = const [],
    this.bookmarks = const [],
    this.parentId,
  });

  final PostId? id;
  final UserId? userId;
  final String? content;
  final String? mediaUrl;
  final DateTime? timestamp;
  final List<UserId>? views;
  final List<UserId>? likes;
  final List<PostId>? comments;
  final List<PostId>? reposts;
  final List<PostId>? quotes;
  final List<UserId>? bookmarks;
  final PostId? parentId;

  @override
  List<Object?> get props => [
        id,
        userId,
        content,
        mediaUrl,
        timestamp,
        views,
        likes,
        comments,
        reposts,
        quotes,
        bookmarks,
        parentId
      ];

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      content: json['content'],
      mediaUrl: json['mediaUrl'],
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
      views: List<UserId>.from(json['views'] ?? []),
      likes: List<UserId>.from(json['likes'] ?? []),
      comments: List<PostId>.from(json['comments'] ?? []),
      reposts: List<PostId>.from(json['reposts'] ?? []),
      quotes: List<PostId>.from(json['quotes'] ?? []),
      bookmarks: List<UserId>.from(json['bookmarks'] ?? []),
      parentId: json['parentId'],
    );
  }

  Map<String, dynamic> toJson([bool keepId = false]) {
    return {
      if (keepId) 'id': id,
      'userId': userId,
      'content': content,
      'mediaUrl': mediaUrl,
      'timestamp': timestamp?.millisecondsSinceEpoch,
      'views': views,
      'likes': likes,
      'comments': comments,
      'reposts': reposts,
      'quotes': quotes,
      'bookmarks': bookmarks,
      'parentId': parentId,
    };
  }

  Post copyWith({
    PostId? id,
    UserId? userId,
    String? content,
    String? mediaUrl,
    DateTime? timestamp,
    List<UserId>? views,
    List<UserId>? likes,
    List<PostId>? comments,
    List<PostId>? reposts,
    List<PostId>? quotes,
    List<UserId>? bookmarks,
    PostId? parentId,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      timestamp: timestamp ?? this.timestamp,
      views: views ?? this.views,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      reposts: reposts ?? this.reposts,
      quotes: quotes ?? this.quotes,
      bookmarks: bookmarks ?? this.bookmarks,
      parentId: parentId ?? parentId,
    );
  }
}
