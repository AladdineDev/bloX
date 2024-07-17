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
    this.likes = const [],
    this.comments = const [],
    this.tweetParentId,
  });

  final PostId? id;
  final UserId? userId;
  final String? content;
  final String? mediaUrl;
  final DateTime? timestamp;
  final List<UserId>? likes;
  final List<Post>? comments;
  final PostId? tweetParentId;

  @override
  List<Object?> get props => [
        id,
        userId,
        content,
        mediaUrl,
        timestamp,
        likes,
        comments,
        tweetParentId
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
      likes: List<UserId>.from(json['likes'] ?? []),
      comments: (json['comments'] as List<dynamic>? ?? [])
          .map((e) => Post.fromJson(e))
          .toList(),
      tweetParentId: json['parentId'],
    );
  }

  Map<String, dynamic> toJson([bool keepId = false]) {
    return {
      if (keepId) 'id': id,
      'userId': userId,
      'content': content,
      'mediaUrl': mediaUrl,
      'timestamp': timestamp?.millisecondsSinceEpoch,
      'likes': likes,
      'comments': comments?.map((e) => e.toJson()).toList(),
      'parentId': tweetParentId,
    };
  }

  Post copyWith({
    PostId? id,
    UserId? userId,
    String? content,
    String? mediaUrl,
    DateTime? timestamp,
    List<UserId>? likes,
    List<Post>? comments,
    PostId? parentId,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      timestamp: timestamp ?? this.timestamp,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      tweetParentId: parentId ?? tweetParentId,
    );
  }
}
