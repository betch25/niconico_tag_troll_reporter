cd $(dirname $0)
if [ $# -ne 1 ]; then
    echo "指定された引数は$#個です。" 1>&2
    echo "実行するには1個の引数が必要です。" 1>&2
    exit 1
 fi
for video_id in $(cat $1 |grep -v "#")
do
  sh ./reporter_for_mac.sh $video_id
  sleep 1
done
exit 0
