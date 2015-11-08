http://www.haskell.org/ghc/docs/latest/html/users_guide/ の日本語訳です。

誤訳や誤字脱字の指摘、新機能の翻訳、訳文への質問を歓迎します。
pull requestするかweb@kotha.netにメールしてください。
パッチを送ってくださる際は修正したものをビルドして
動作確認する必要はないので、そのまま送ってください。

ビルドするには
  ./build
を実行してください。少なくとも以下のものが必要です。
- Unix風環境
- xsltproc
- docbook XSL
成功すれば./xhtml/以下にファイルが作成されます。

postprocessはxhtmlの整形をするHaskellスクリプトです。
動かなくてもあまり支障はありません。
