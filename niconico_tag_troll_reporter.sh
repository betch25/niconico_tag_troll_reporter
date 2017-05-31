tag=$(curl http://ext.nicovideo.jp/api/getthumbinfo/$1 |grep "<tag>" | sed 's/<tag>//' | sed 's/<\/tag>//')
comment=$(cat << EOS
下記タグで独占し他のタグの追加を妨害する荒らし行為を行なっているユーザーがいるため、
タグ編集禁止などの対応をお願いします。
$tag
EOS)
form=$(cat << EOS
<html>
<body>
<form action="https://secure.nicovideo.jp/secure/comment_allegation/$1" name="comment_allegation" id="comment_allegation" method="post">
<input type="hidden" name="mode" id="mode" value="confirm">
<input type="hidden" name="select_allegation" id="select_allegation">
<input type="hidden" name="inquiry" id="inquiry" value="">
<label><input type="radio" name="target" value="tag" checked="checked">タグ</label>
<select name="select_allegation" size="1">
    <option value="search_interference">検索妨害（タグ）</option>
</select>
<textarea name="inquiry" rows="8" id="inquiry">$comment </textarea>
<input type="submit" name="submit" value="確認画面へ" class="submit">
</form>
</body>
</html>
EOS)
echo "$form" > form.html
open form.html
exit 0
