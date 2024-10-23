import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'global_loader.g.dart';

@riverpod
class AppLoader extends _$AppLoader {
  @override
  bool build() { // Đảm bảo phương thức này được viết đúng
    return false; // Giá trị mặc định cho trạng thái loading
  }

  void setLoaderValue(bool value){
    state = value;

  }
}
