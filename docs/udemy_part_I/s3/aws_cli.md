## AWS CLI

# Example web pages 
~/ZWork/xLab/web/exmaple/

# get list of buckets
aws s3 ls 
# made a bucket
aws s3 mb s3://smark.test
aws s3 mb s3://smark.dev.test --profile develop
# copy a file to the bucket
aws s3 cp ~/ZWork/xLab/web/exmaple/index.html s3://smark.dev.test --profile develop
# copy all files to the bucket, and cheking changes, if you have changed a file, then sync copy onlu the changed file.
aws s3 sync ~/ZWork/xLab/web/exmaple s3://smark.dev.test --profile develop