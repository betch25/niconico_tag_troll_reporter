tmp=$(mktemp)
curl http://ext.nicovideo.jp/api/getthumbinfo/$1 > $tmp
tag=$(cat $tmp |grep "<tag>" | sed 's/<tag>//' | sed 's/<\/tag>//')
comment=$(cat << EOS
下記タグで独占し他のタグの追加を妨害する荒らし行為を行なっているユーザーがいるため、
タグ編集禁止などの対応をお願いします。
$tag
EOS)
echo "$comment"
open https://secure.nicovideo.jp/secure/comment_allegation/$1
rm $tmp
exit 0
