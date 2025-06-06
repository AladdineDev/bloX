import 'package:blox/features/auth/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

typedef PostId = String;

class Post extends Equatable {
  const Post({
    required this.id,
    required this.userId,
    required this.content,
    this.mediaListUrl = const [],
    this.timestamp,
    this.views = const [],
    this.likes = const [],
    this.replies = const [],
    this.reposts = const [],
    this.quotes = const [],
    this.bookmarks = const [],
    this.parentPostId,
  });

  final PostId? id;
  final AppUserId? userId;
  final String? content;
  final List<String>? mediaListUrl;
  final DateTime? timestamp;
  final List<AppUserId>? views;
  final List<AppUserId>? likes;
  final List<PostId>? replies;
  final List<PostId>? reposts;
  final List<PostId>? quotes;
  final List<AppUserId>? bookmarks;
  final PostId? parentPostId;

  @override
  List<Object?> get props => [
        id,
        userId,
        content,
        mediaListUrl,
        timestamp,
        views,
        likes,
        replies,
        reposts,
        quotes,
        bookmarks,
        parentPostId
      ];

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      content: json['content'],
      mediaListUrl: List<String>.from(json['mediaListUrl'] ?? []),
      timestamp: json['timestamp'] == null
          ? null
          : json['timestamp'] is Timestamp
              ? (json['timestamp'] as Timestamp).toDate()
              : DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
      views: List<AppUserId>.from(json['views'] ?? []),
      likes: List<AppUserId>.from(json['likes'] ?? []),
      replies: List<PostId>.from(json['replies'] ?? []),
      reposts: List<PostId>.from(json['reposts'] ?? []),
      quotes: List<PostId>.from(json['quotes'] ?? []),
      bookmarks: List<AppUserId>.from(json['bookmarks'] ?? []),
      parentPostId: json['parentPostId'],
    );
  }

  Map<String, dynamic> toJson([bool keepId = false]) {
    return {
      if (keepId) 'id': id,
      'userId': userId,
      'content': content,
      'mediaListUrl': mediaListUrl,
      'timestamp': timestamp?.millisecondsSinceEpoch,
      'views': views,
      'likes': likes,
      'replies': replies,
      'reposts': reposts,
      'quotes': quotes,
      'bookmarks': bookmarks,
      'parentPostId': parentPostId,
    };
  }

  Post copyWith({
    PostId? id,
    AppUserId? userId,
    String? content,
    List<String>? mediaListUrl,
    DateTime? timestamp,
    List<AppUserId>? views,
    List<AppUserId>? likes,
    List<PostId>? replies,
    List<PostId>? reposts,
    List<PostId>? quotes,
    List<AppUserId>? bookmarks,
    PostId? parentPostId,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      mediaListUrl: mediaListUrl ?? this.mediaListUrl,
      timestamp: timestamp ?? this.timestamp,
      views: views ?? this.views,
      likes: likes ?? this.likes,
      replies: replies ?? this.replies,
      reposts: reposts ?? this.reposts,
      quotes: quotes ?? this.quotes,
      bookmarks: bookmarks ?? this.bookmarks,
      parentPostId: parentPostId ?? this.parentPostId,
    );
  }
}
