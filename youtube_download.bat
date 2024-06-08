@echo off
setlocal enabledelayedexpansion


REM youtubeなどのダウンロード
REM downloder_EGyoutube_yt-dlp.exe [URL]

set DOWNLODER=".\yt-dlp.exe"


REM ################ バージョン情報 ################
REM %DOWNLODER% -v
%DOWNLODER% --version

REM ################ ソフトの更新 ################
REM yt-dlp --update


REM ################ Options ################ 
REM --flat-playlist: プレイリスト展開をするかどうか。
REM --cache-dir: キャッシュディレクトリ
REM --progress: プログレスバー
REM --format-sort　res:720:   720p以下での最大解像度もしくはない場合は最小の解像度を優先する。

REM set OPTIONS_VARS=""
REM set OPTIONS_VARS=" --flat-playlist"
REM set OPTIONS_VARS=" --cache-dir　\"Z:\\ \" "
REM set OPTIONS_VARS=" --format-sort　res:720 "



REM ################ 現在のディレクトリ ################
echo %%~dp0: %~dp0


REM ################ ダウンロードするURLを入力　################
REM set URL="https://www.youtube.com/watch?v=NOxhfTUUob0"
set /P URL="ダウンロードするURLを入力: "


REM echo ダウンロードできるファイルリストの表示
REM call %DOWNLODER%  -F  %URL%



REM ################ ダウンロードの種類を指定する　################
set /P DOWNLOAD_MODE="ダウンロードの種類を指定する(入力なし:最高解像度、1:解像度指定、2:動画と音声の指定、11:解像度360p): "

IF "!DOWNLOAD_MODE!" == "" (
	set DOWNLOAD_NOMAL=TRUE
) else (
	set DOWNLOAD_NOMAL=FALSE
)

IF !DOWNLOAD_MODE! == 1 (
	set DOWNLOAD_resolution=TRUE
) else (
	set DOWNLOAD_resolution=FALSE
)

IF !DOWNLOAD_MODE! == 2 (
	set DOWNLOAD_move_audio=TRUE
) else (
	set DOWNLOAD_move_audio=FALSE
)

IF !DOWNLOAD_MODE! == 11 (
	set DOWNLOAD_NOMAL=FALSE
	set DOWNLOAD_resolution=FALSE
	set DOWNLOAD_move_audio=FALSE
	
	echo ######## download 360p ########
	echo %DOWNLODER%  --format-sort res:360  %URL%
	call %DOWNLODER%  --format-sort res:360  %URL%
)



echo DOWNLOAD_MODE  %DOWNLOAD_MODE%
echo DOWNLOAD_NOMAL  %DOWNLOAD_NOMAL%
echo DOWNLOAD_resolution  %DOWNLOAD_resolution% 
echo DOWNLOAD_move_audio  %DOWNLOAD_move_audio%


REM ################ ダウンロードの実行_通常version　################
IF %DOWNLOAD_NOMAL%==TRUE (
	echo ダウンロードの実行_通常version
	echo %DOWNLODER%  %URL%
	call %DOWNLODER%  %URL%
)


REM ################ ダウンロードの実行_解像度指定version　################
REM call %DOWNLODER%  --format-sort res:720  %URL%
REM call %DOWNLODER%  --format-sort res:480  %URL%
REM call %DOWNLODER%  --format-sort res:360  %URL%

IF %DOWNLOAD_resolution%==TRUE (
	echo ダウンロードできるファイルリストの表示
	call %DOWNLODER%  -F  %URL%

	echo ダウンロードの実行_解像度指定version
	set /P RESOLUTION="解像度の指定__指定なしなら標準画質1080p60webm__ e.g.3=>720, 2=>480, 1=>360, or eles:  "
	
	IF "!RESOLUTION!" == "1" (
			echo 360p
			echo %DOWNLODER%  --format-sort res:360  %URL%
			call %DOWNLODER%  --format-sort res:360  %URL%
	) else if "!RESOLUTION!" == "2" (
			echo 480p
			echo %DOWNLODER%  --format-sort res:480  %URL%
			call %DOWNLODER%  --format-sort res:480  %URL%
	) else if "!RESOLUTION!" == "3" (
			echo 720p
			echo %DOWNLODER%  --format-sort res:720  %URL%
			call %DOWNLODER%  --format-sort res:720  %URL%

	) else (
		echo %DOWNLODER%  --format-sort res:!RESOLUTION!  %URL%
		call %DOWNLODER%  --format-sort res:!RESOLUTION!  %URL%
	)
) 


REM ################ ダウンロードの実行_ダウンロードファイルの詳細な指定version　################
REM 571 - 映像ファイル
REM 251 - 音声ファイル
REM yt-dlp -f 571+251


IF %DOWNLOAD_move_audio%==TRUE (
	echo ダウンロードできるファイルリストの表示
	call %DOWNLODER%  -F  %URL%

	echo ダウンロードの実行_ダウンロードファイルの詳細な指定version
	set /P VIDEO_NUM="映像ファイルの番号指定: "
	set /P AUDIO_NUM="音声ファイルの番号指定: "
	
	
	set TRUE_FALSE=FALSE
	IF "!VIDEO_NUM!" == "" (
		set TRUE_FALSE=TRUE
	)

	IF "!AUDIO_NUM!" == "" (
		set TRUE_FALSE=TRUE
	)
	echo VIDEO_NUMまたはAUDIO_NUMが入力されていない:  !TRUE_FALSE!
	echo #####################################################
	
	If !TRUE_FALSE! == TRUE (
		IF "!VIDEO_NUM!" == "" (
			echo 音声ファイルのみダウンロード
			echo %DOWNLODER%  -f !AUDIO_NUM!  !URL!
			call %DOWNLODER%  -f !AUDIO_NUM!  !URL!
		)

		IF "!AUDIO_NUM!" == "" (
			echo 動画ファイルのみダウンロード
			echo %DOWNLODER%  -f !VIDEO_NUM!  !URL!
			call %DOWNLODER%  -f !VIDEO_NUM!  !URL!
		)
	) else (
		echo 動画ファイルと音声ファイルをダウンロード
		echo %DOWNLODER%  -f !VIDEO_NUM!+!AUDIO_NUM!  !URL!
		call %DOWNLODER%  -f !VIDEO_NUM!+!AUDIO_NUM!  !URL!
	)
)


REM cmd /k