
import 'package:json_annotation/json_annotation.dart';


part 'user_api.g.dart';

/// {@template user_api}
/// UserApi description
/// {@endtemplate}
@JsonSerializable()
class UserApi {
  /// {@macro user_api}
  const UserApi({ 
  required this.full_name,
  required this.email,
  required this.role,
  required this.password,
  });

    /// Creates a UserApi from Json map
  factory UserApi.fromJson(Map<String, dynamic> data) => _$UserApiFromJson(data);

  /// A description for full_name
  final String full_name;

  /// A description for email
  final String email;

  /// A description for role
  final int role;

  /// A description for password
  final String password;



    /// Creates a Json map from a UserApi
  Map<String, dynamic> toJson() => _$UserApiToJson(this);
}
