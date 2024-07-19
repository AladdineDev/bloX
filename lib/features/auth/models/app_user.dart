import 'package:equatable/equatable.dart';

typedef AppUserId = String;

class AppUser extends Equatable {
  const AppUser({
    required this.id,
    required this.email,
    this.displayName,
    this.photoURL,
    this.phoneNumber,
    this.username,
    this.profileImageUrl,
    this.bio,
    this.followers = const [],
    this.following = const [],
  });

  final AppUserId? id;
  final String? email;
  final String? displayName;
  final String? photoURL;
  final String? phoneNumber;
  final String? username;
  final String? profileImageUrl;
  final String? bio;
  final List<AppUserId>? followers;
  final List<AppUserId>? following;

  @override
  List<Object?> get props => [
        id,
        email,
        displayName,
        photoURL,
        phoneNumber,
        username,
        profileImageUrl,
        bio,
        followers,
        following,
      ];

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      email: json['email'],
      displayName: json['displayName'],
      photoURL: json['photoURL'],
      phoneNumber: json['phoneNumber'],
      username: json['username'],
      profileImageUrl: json['profileImageUrl'],
      bio: json['bio'],
      followers: List<AppUserId>.from(json['followers'] ?? []),
      following: List<AppUserId>.from(json['following'] ?? []),
    );
  }

  Map<String, dynamic> toJson([bool keepId = false]) {
    return {
      if (keepId) 'id': id,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'phoneNumber': phoneNumber,
      'username': username,
      'profileImageUrl': profileImageUrl,
      'bio': bio,
      'followers': followers,
      'following': following,
    };
  }

  AppUser copyWith({
    AppUserId? id,
    String? email,
    String? displayName,
    String? photoURL,
    String? phoneNumber,
    String? username,
    String? profileImageUrl,
    String? bio,
    List<AppUserId>? followers,
    List<AppUserId>? following,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      username: username ?? this.username,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bio: bio ?? this.bio,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }
}
