from rest_framework import viewsets, generics, status, parsers, permissions
from courses import serializers, paginators
from courses.models import Category, Course, Lesson, User
from rest_framework.decorators import action
from rest_framework.response import Response

from .send_mail import subscribe_user_to_mailchimp


class CategoryViewSet(viewsets.ViewSet, generics.ListAPIView):
    queryset = Category.objects.all()
    serializer_class = serializers.CategorySerializer


class CourseViewSet(viewsets.ViewSet, generics.ListAPIView, generics.CreateAPIView, generics.RetrieveAPIView):
    queryset = Course.objects.filter(active=True)
    serializer_class = serializers.CourseSerializer
    pagination_class = paginators.CoursePaginator

    def get_queryset(self):
        queries = self.queryset
        q = self.request.query_params.get('q')
        if q:
            queries = queries.filter(subject__icontains=q)

        return queries

    @action(methods=['get'], detail=True)
    def lessons(self, request, pk):
        lessons = self.get_object().lesson_set.filter(active=True)
        return Response(serializers.LessonSerializer(lessons, many=True).data, status=status.HTTP_200_OK)


class LessonViewSet(viewsets.ViewSet, generics.RetrieveAPIView):
    queryset = Lesson.objects.filter(active=True)
    serializer_class = serializers.LessonSerializer

    @action(methods=['get'], detail=True)
    def videos(self, request, pk):
        videos = self.get_object().video_set.filter(active=True)
        return Response(serializers.VideoSerializer(videos, many=True).data, status=status.HTTP_200_OK)


class UserViewSet(viewsets.ViewSet, generics.CreateAPIView):
    queryset = User.objects.filter(is_active=True)
    serializer_class = serializers.UserSerializer
    parser_classes = [parsers.MultiPartParser]

    def get_permissions(self):
        if self.action.__eq__('current_user'):
            return [permissions.IsAuthenticated()]
        return [permissions.AllowAny()]

    @action(methods=['get'], url_name='current-users', detail=False)
    def current_user(self, request):
        return Response(serializers.UserSerializer(request.user).data)

    def create(self, request, *args, **kwargs):
        # Tạo người dùng
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)

        # Gửi email chào mừng qua Mailchimp
        print(serializer.data['email'])
        user_email = serializer.data['email']
        first_name = serializer.data.get('first_name', '')
        last_name = serializer.data.get('last_name', '')
        subscribe_user_to_mailchimp(user_email, first_name, last_name)

        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)
