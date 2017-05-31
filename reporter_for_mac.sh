if [ $# -ne 1 ]; then
    echo "指定された引数は$#個です。" 1>&2
    echo "実行するには1個の引数が必要です。" 1>&2
    exit 1
 fi
tag=$(curl http://ext.nicovideo.jp/api/getthumbinfo/$1 |grep "<tag>" | sed 's/<tag>//' | sed 's/<\/tag>//')
comment=$(cat << EOS
下記タグで独占荒らしを行い、他のタグの追加を妨害するユーザーがいるため、タグ編集禁止の対応をお願いします。
EOS)
form=$(cat << EOS
<html>
<body>
<form action="https://secure.nicovideo.jp/secure/comment_allegation/$1" name="comment_allegation" id="comment_allegation" method="post">
<input type="hidden" name="mode" id="mode" value="confirm">
<input type="hidden" name="select_allegation" id="select_allegation">
<input type="hidden" name="inquiry" id="inquiry" value="">
<input type="hidden" name="target" value="tag">
<input type="hidden" name="select_allegation" size="1" value="search_interference">
<input type="hidden" name="inquiry" value="$comment

$tag">
注意:ログイン済みであることを確認してください。<br>
<br>
通報する前に以下のことを必ず確認してください！<br>
<br>
今、これらのタグを削除してもすぐに編集されますか？<br>
今、これ以外のタグを追加しても削除されますか？<br>
以上から、これらのタグはタグ独占荒らしの仕業と断定できますか？<br>
<br>
$tag<br>
<br>
<input type="submit" name="submit" value="はい、タグ独占荒らしの仕業です" class="submit">
</form>
</body>
</html>
EOS)
echo "$form" > form.html
open form.html
exit 0
