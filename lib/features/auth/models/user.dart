import 'package:equatable/equatable.dart';

typedef UserId = String;

class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.username,
    this.profileImageUrl,
    this.bio,
    this.followers = const [],
    this.following = const [],
  });

  final UserId id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String? username;
  final String? profileImageUrl;
  final String? bio;
  final List<UserId> followers;
  final List<UserId> following;

  @override
  List<Object?> get props => [
        id,
        email,
        displayName,
        photoUrl,
        username,
        profileImageUrl,
        bio,
        followers,
        following,
      ];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      displayName: json['displayName'],
      photoUrl: json['photoUrl'],
      username: json['username'],
      profileImageUrl: json['profileImageUrl'],
      bio: json['bio'],
      followers: List<UserId>.from(json['followers'] ?? []),
      following: List<UserId>.from(json['following'] ?? []),
    );
  }

  Map<String, dynamic> toJson([bool keepId = false]) {
    return {
      if (keepId) 'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'username': username,
      'profileImageUrl': profileImageUrl,
      'bio': bio,
      'followers': followers,
      'following': following,
    };
  }

  User copyWith({
    UserId? id,
    String? email,
    String? displayName,
    String? photoUrl,
    String? username,
    String? profileImageUrl,
    String? bio,
    List<UserId>? followers,
    List<UserId>? following,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      username: username ?? this.username,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bio: bio ?? this.bio,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }
}
