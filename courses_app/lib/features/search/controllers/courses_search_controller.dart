import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'courses_search_controller.g.dart';

@riverpod
class CoursesSearchController extends AutoDisposeNotifier<String>{
  @override
  String build(){
    return "Thao";
  }
}

final coursesSearchControllerProvider = AutoDisposeNotifierProvider<CoursesSearchController, String>(CoursesSearchController.new);
