ACCOUNT_ID=
BUCKET_NAME=
HOUR=

REGION:=ap-northeast-1
YEAR:=$(shell TZ=UTC date "+%Y")
MONTH:=$(shell TZ=UTC date "+%m")
DAY:=$(shell TZ=UTC date "+%d")

LOG_PREFIX_REGEX=^[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}
S3_PATH=s3://${BUCKET_NAME}/AWSLogs/${ACCOUNT_ID}/elasticloadbalancing/${REGION}/${YEAR}/${MONTH}/${DAY}/

filenames:
	TZ=UTC aws s3 ls ${S3_PATH} > ls.log
	cat ls.log | grep -e '${LOG_PREFIX_REGEX} ${HOUR}' > grep.log
	cat grep.log | awk '{print $$4}' > files.log

download:
	cat files.log | xargs -I{} aws s3 cp ${S3_PATH}{} ./logs/
	ls logs/ | grep '.log.gz' | xargs -I{} gunzip -f logs/{}

cleanup_workfile:
	rm -rf files.log grep.log ls.log

cleanup:
	rm -rf files.log grep.log ls.log logs/

run: filenames download cleanup_workfile

