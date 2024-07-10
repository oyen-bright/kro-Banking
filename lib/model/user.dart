// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class KroUser {
  final String email;
  final String? photoUrl;
  final String name;
  final String id;

  KroUser({
    required this.email,
    this.photoUrl,
    required this.name,
    required this.id,
  });

  factory KroUser.fromJson(Map<String, dynamic> json) =>
      _$KroUserFromJson(json);
  Map<String, dynamic> toJson() => _$KroUserToJson(this);

  static KroUser userFromFirebaseUser(User user) {
    return KroUser(
        id: user.uid, email: user.email ?? "", name: user.displayName ?? "");
  }
}
