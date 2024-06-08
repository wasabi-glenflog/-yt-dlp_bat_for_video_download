コマンドラインのオーディオ/ビデオ ダウンローダyt-dlpをwindowsで使いやすくするためのバッチファイルです。
  
  
https://github.com/yt-dlp/yt-dlp からリリースバージョンのyt-dlp.exeをダウンロードしてこのフォルダに配置してください。
  
ダウンロードに対応しているサイトは、https://github.com/yt-dlp/yt-dlp/blob/master/supportedsites.md に記載されています。

# 使い方
1. youtube_download.bat　をダブルクリックするなどして、実行してください。
2. 「ダウンロードするURLを入力：」が表示されるので、youtubeなどのURLを入力してください。
3. 次に、ダウンロードするファイルを指定します。  
    1. 最高解像度で保存したい場合はEnterキーを押してください。
    2. 解像度を指定したい場合は、「1」  
    3. 動画と音声の指定をしたい場合は、「2」  
    4. 360pの解像度で保存したい場合は、「11」  
        を入力してEnterキーを押してください。  
4. 1,4の場合はダウンロードが開始します。  
    2の場合は、保存したい解像度を数字で入力してください。  
    3の場合は、ダウンロード可能なファイルのリストが表示されるので、保存したい「ID」の番号を入力してください。



# 任意のフォルダへ保存する場合
1. youtube_download.batのショートカットを作成してください。 
2. ショートカットを右クリックして「プロパティ」を開いてください。 
3. 作業ディレクトリに「%~dp0」を入力してください。%~dp0は現在のディレクトリの意味です。  
4. ショートカットを実行すると、ショートカットが置かれたフォルダの中にダウンロードできます。