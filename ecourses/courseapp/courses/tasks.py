import os

import cloudinary
from celery import shared_task
import boto3
from django.core.mail import send_mail

from courses.models import Video, Lesson
import time

import mailchimp_marketing as MailchimpMarketing
from mailchimp_marketing.api_client import ApiClientError
from django.conf import settings
import io


@shared_task
def subscribe_user_to_mailchimp(email, first_name=None, last_name=None):
    client = MailchimpMarketing.Client()
    client.set_config({
        "api_key": settings.MAILCHIMP_API_KEY,
        "server": settings.MAILCHIMP_SERVER_PREFIX
    })

    list_id = settings.MAILCHIMP_LIST_ID
    member_info = {
        "email_address": email,
        "status": "subscribed",  # Hoặc "pending" nếu bạn muốn xác thực email
        "merge_fields": {
            "FNAME": first_name or "",
            "LNAME": last_name or ""
        }
    }

    try:
        response = client.lists.add_list_member(list_id, member_info)
        print("Mailchimp response:", response)
        return response
    except ApiClientError as error:
        print(f"Mailchimp error: {error.text}")
        return None



@shared_task
def upload_video_to_s3(file_path, filename, video_instance_id):
    time.sleep(3)
    print('upload video')
    s3 = boto3.client(
        's3',
        aws_access_key_id=settings.AWS_ACCESS_KEY_ID,
        aws_secret_access_key=settings.AWS_SECRET_ACCESS_KEY,
        region_name=settings.AWS_S3_REGION_NAME
    )

    try:
        # Lấy instance video từ database
        video_instance = Video.objects.get(id=video_instance_id)

        # Tạo key S3 (đường dẫn trong bucket)
        s3_key = f"courses/2024/10/{os.path.basename(filename)}"

        # Tải video lên S3 từ file tạm thời
        with open(file_path, 'rb') as video_file:
            s3.upload_fileobj(
                video_file,
                settings.AWS_STORAGE_BUCKET_NAME,
                s3_key,
                ExtraArgs={
                    'ContentDisposition': 'inline',  # Đảm bảo video không tải xuống mà phát trực tiếp
                    'ContentType': 'video/mp4'  # Đặt đúng loại MIME để phát video
                }
            )

            # Lưu URL của video vào instance video
        video_instance.url = f'{s3_key}'
        video_instance.save()



        # Xóa file tạm sau khi upload thành công
        os.remove(file_path)
        print("Preparing to send email")
        # Gửi email cho admin
        send_mail(
            subject='Video đã tải lên',
            message=f'"{video_instance.name}"',
            from_email=settings.DEFAULT_FROM_EMAIL,
            recipient_list=[settings.ADMIN_EMAIL],  # Địa chỉ email của admin
            fail_silently=False,
        )

    except Exception as e:
        print(f"An error occurred: {e}")


@shared_task
def upload_image_to_cloudinary(file_path, lesson_id):
    time.sleep(3)
    print('Uploading image to Cloudinary')
    try:
        # Lấy instance hình ảnh từ database
        lesson = Lesson.objects.get(id=lesson_id)

        # Tải lên ảnh lên Cloudinary
        response = cloudinary.uploader.upload(file_path)

        # Lưu URL của ảnh vào instance hình ảnh
        lesson.thumbnail = response['secure_url']
        lesson.save()

        # Xóa file tạm sau khi upload thành công
        os.remove(file_path)

    except Exception as e:
        print(f"An error occurred: {e}")


@shared_task
def TestN():
    time.sleep(15)


