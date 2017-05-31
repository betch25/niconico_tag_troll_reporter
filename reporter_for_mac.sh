if [ $# -ne 1 ]; then
    echo "指定された引数は$#個です。" 1>&2
    echo "実行するには1個の引数が必要です。" 1>&2
    exit 1
 fi
xml=$(curl http://ext.nicovideo.jp/api/getthumbinfo/$1)
title=$(echo "$xml" |grep "<title>" | sed 's/<title>//' | sed 's/<\/title>//')
tag=$(echo "$xml" |grep "<tag>" | sed 's/<tag>//' | sed 's/<\/tag>//')
comment=$(cat << EOS
下記タグで独占を行い、他のタグの追加を妨害する検索妨害行為を行なっています。
他のタグを追加しても即時削除とタグ追加を行う過剰編集でサーバーに負荷をかけているため、タグ編集禁止の対応をお願いします。
EOS)
form=$(cat << EOS
<html>
<body>
$title<br>
<a href="http://www.nicovideo.jp/watch/$1" target="_blank">http://www.nicovideo.jp/watch/$1</a><br>
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
echo "$form" > $1.html
open $1.html
exit 0
