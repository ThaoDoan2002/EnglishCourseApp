import 'package:courses_app/common/models/entities.dart';
import 'package:courses_app/global.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  @override
  UserProfile build() => Global.storageService.getUserProfile();
}
