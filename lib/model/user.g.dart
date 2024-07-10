// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KroUser _$KroUserFromJson(Map<String, dynamic> json) => KroUser(
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String?,
      name: json['name'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$KroUserToJson(KroUser instance) => <String, dynamic>{
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'name': instance.name,
      'id': instance.id,
    };
