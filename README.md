# download-s3elb-log

## Usage

```
$ make run ACCOUNT_ID=123456789012 BUCKET_NAME=bucket-sample HOUR=03
```

## Options

### Require
- ACCOUNT_ID: AWS Account ID
- BUCKET_NAME: S3 Bucket name
- HOUR: download files hour

### Optional
- REGION: AWS Region (default: ap-northeast-1)
- YEAR: download files year (default: now)
- MONTH: download files month (default: now)
- DAY: download files day (default: now)
