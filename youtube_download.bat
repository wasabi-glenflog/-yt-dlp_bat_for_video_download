@echo off
setlocal enabledelayedexpansion


REM youtube�Ȃǂ̃_�E�����[�h
REM downloder_EGyoutube_yt-dlp.exe [URL]

set DOWNLODER=".\yt-dlp.exe"


REM ################ �o�[�W������� ################
REM %DOWNLODER% -v
%DOWNLODER% --version

REM ################ �\�t�g�̍X�V ################
REM yt-dlp --update


REM ################ Options ################ 
REM --flat-playlist: �v���C���X�g�W�J�����邩�ǂ����B
REM --cache-dir: �L���b�V���f�B���N�g��
REM --progress: �v���O���X�o�[
REM --format-sort�@res:720:   720p�ȉ��ł̍ő�𑜓x�������͂Ȃ��ꍇ�͍ŏ��̉𑜓x��D�悷��B

REM set OPTIONS_VARS=""
REM set OPTIONS_VARS=" --flat-playlist"
REM set OPTIONS_VARS=" --cache-dir�@\"Z:\\ \" "
REM set OPTIONS_VARS=" --format-sort�@res:720 "



REM ################ ���݂̃f�B���N�g�� ################
echo %%~dp0: %~dp0


REM ################ �_�E�����[�h����URL����́@################
REM set URL="https://www.youtube.com/watch?v=NOxhfTUUob0"
set /P URL="�_�E�����[�h����URL�����: "


REM echo �_�E�����[�h�ł���t�@�C�����X�g�̕\��
REM call %DOWNLODER%  -F  %URL%



REM ################ �_�E�����[�h�̎�ނ��w�肷��@################
set /P DOWNLOAD_MODE="�_�E�����[�h�̎�ނ��w�肷��(���͂Ȃ�:�ō��𑜓x�A1:�𑜓x�w��A2:����Ɖ����̎w��A11:�𑜓x360p): "

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


REM ################ �_�E�����[�h�̎��s_�ʏ�version�@################
IF %DOWNLOAD_NOMAL%==TRUE (
	echo �_�E�����[�h�̎��s_�ʏ�version
	echo %DOWNLODER%  %URL%
	call %DOWNLODER%  %URL%
)


REM ################ �_�E�����[�h�̎��s_�𑜓x�w��version�@################
REM call %DOWNLODER%  --format-sort res:720  %URL%
REM call %DOWNLODER%  --format-sort res:480  %URL%
REM call %DOWNLODER%  --format-sort res:360  %URL%

IF %DOWNLOAD_resolution%==TRUE (
	echo �_�E�����[�h�ł���t�@�C�����X�g�̕\��
	call %DOWNLODER%  -F  %URL%

	echo �_�E�����[�h�̎��s_�𑜓x�w��version
	set /P RESOLUTION="�𑜓x�̎w��__�w��Ȃ��Ȃ�W���掿1080p60webm__ e.g.3=>720, 2=>480, 1=>360, or eles:  "
	
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


REM ################ �_�E�����[�h�̎��s_�_�E�����[�h�t�@�C���̏ڍׂȎw��version�@################
REM 571 - �f���t�@�C��
REM 251 - �����t�@�C��
REM yt-dlp -f 571+251


IF %DOWNLOAD_move_audio%==TRUE (
	echo �_�E�����[�h�ł���t�@�C�����X�g�̕\��
	call %DOWNLODER%  -F  %URL%

	echo �_�E�����[�h�̎��s_�_�E�����[�h�t�@�C���̏ڍׂȎw��version
	set /P VIDEO_NUM="�f���t�@�C���̔ԍ��w��: "
	set /P AUDIO_NUM="�����t�@�C���̔ԍ��w��: "
	
	
	set TRUE_FALSE=FALSE
	IF "!VIDEO_NUM!" == "" (
		set TRUE_FALSE=TRUE
	)

	IF "!AUDIO_NUM!" == "" (
		set TRUE_FALSE=TRUE
	)
	echo VIDEO_NUM�܂���AUDIO_NUM�����͂���Ă��Ȃ�:  !TRUE_FALSE!
	echo #####################################################
	
	If !TRUE_FALSE! == TRUE (
		IF "!VIDEO_NUM!" == "" (
			echo �����t�@�C���̂݃_�E�����[�h
			echo %DOWNLODER%  -f !AUDIO_NUM!  !URL!
			call %DOWNLODER%  -f !AUDIO_NUM!  !URL!
		)

		IF "!AUDIO_NUM!" == "" (
			echo ����t�@�C���̂݃_�E�����[�h
			echo %DOWNLODER%  -f !VIDEO_NUM!  !URL!
			call %DOWNLODER%  -f !VIDEO_NUM!  !URL!
		)
	) else (
		echo ����t�@�C���Ɖ����t�@�C�����_�E�����[�h
		echo %DOWNLODER%  -f !VIDEO_NUM!+!AUDIO_NUM!  !URL!
		call %DOWNLODER%  -f !VIDEO_NUM!+!AUDIO_NUM!  !URL!
	)
)


REM cmd /k