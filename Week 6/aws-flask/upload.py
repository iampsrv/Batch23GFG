from werkzeug.utils import secure_filename
import boto3

bucket_name = 'my-tf-test-bucket-pranjal'


def upload_my_file(f):
    #print(f)
    filename = secure_filename(f.filename)
    #print(filename)
    f.save(filename)
    s3client = boto3.client('s3')
    s3client.upload_file(filename, bucket_name, filename)
    return filename
