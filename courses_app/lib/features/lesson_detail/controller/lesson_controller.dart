import 'package:courses_app/common/models/lesson_entities.dart';
import 'package:courses_app/common/utils/constants.dart';
import 'package:courses_app/features/lesson_detail/repo/lesson_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:video_player/video_player.dart';

part 'lesson_controller.g.dart';

VideoPlayerController? videoPlayerController;

@riverpod
Future<void> lessonDetailController(LessonDetailControllerRef ref,
    {required int index}) async {
  LessonRequestEntity lessonRequestEntity = LessonRequestEntity();
  lessonRequestEntity.id = index;
  final response = await LessonRepo.courseLessonDetail(rq: lessonRequestEntity);
  if (response?.data != []) {

    print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
    var url = "";
    try {
      // Kiểm tra null trước khi truy cập phần tử
      if (response?.data != null && response!.data!.isNotEmpty) {
        url = "${response.data!.elementAt(0).url}";
        print("URL: $url");
      } else {
        print("Data is null or empty");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
    try {
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));

      var initializeVideoPlayerFuture = videoPlayerController?.initialize();
      LessonVideo vidInstance = LessonVideo(
          lessonItem: response!.data!,
          isPlay: false,
          initializeVideoPlayer: initializeVideoPlayerFuture,
          url: url);
      // videoPlayerController?.play();
      ref
          .read(lessonDataControllerProvider.notifier)
          .updateLessonData(vidInstance);
    } catch (e) {
      print("---------------------An error occurred: $e");
    }
  } else {
    print('request failed ');
  }
}

@riverpod
class LessonDataController extends _$LessonDataController {
  @override
  FutureOr<LessonVideo> build() async {
    return LessonVideo();
  }

  void updateLessonData(LessonVideo lessons) {
    update((data) => lessons);
    // update((data) => data.copyWith(
    //     url: lessons.url,
    //     initializeVideoPlayer: lessons.initializeVideoPlayer,
    //     lessonItem: lessons.lessonItem,
    //     isPlay: lessons.isPlay));
  }

  void playPause(bool isPlay) {
    update((data) => data.copyWith(isPlay: isPlay));
  }

  void playNextVid(String url) {
    if (videoPlayerController != null) {
      videoPlayerController?.pause();
      videoPlayerController?.dispose();
    }

    update((data) => data.copyWith(
          isPlay: false,
          initializeVideoPlayer: null,
        ));

    var vidUrl = url;
    print(vidUrl.toString());

    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(vidUrl));
    var initializeVideoPlayerFuture = videoPlayerController?.initialize();
    update((data) => data.copyWith(
          initializeVideoPlayer: initializeVideoPlayerFuture,
          isPlay: true,
          url: vidUrl,
        ));
    videoPlayerController?.play();
  }
}
