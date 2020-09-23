***************************************************************************

                S1C88シリーズ開発ツールパッケージ バージョン 6.00
                                                                2008/01/18
***************************************************************************

S1C88シリーズ開発ツールパッケージをお買い上げいただきまして、誠にありがとう
ございます。このファイルでは開発ツールパッケージをご利用になる前に読んで頂
きたい制限事項やご使用上の注意点などについてご紹介しております。本製品をお
使いになる前に、必ずお読みください。


■ 必要なシステム構成

  S1C88シリーズ開発ツールパッケージをお使いになるには、次のシステムを推奨
　いたします。

  - ハードウェア
    Pentium 1GHz相当以上のCPUを搭載したPC/AT互換機
  - OS
    使用するコンピュータに対応した下記のいずれかのOS
    Microsoft Windows 2000
    Microsoft Windows XP
  - メモリ
    64MB以上
  - ハードディスク
    50MB以上の空き容量
  - ディスプレイ
    800x600以上


- インストールについて
  S1C88シリーズ開発ツールパッケージをインストールする前に、ウィルスチェッ
  クプログラムを含むすべてのWindowsプログラムを必ず終了させてください。

  * インストール手順
  - SETUP.exeを実行し、インストーラを起動します
  - インストーラの指示に従ってインストールを完了させてください

  ※ 空き容量の不足などでインストールがうまくいかないときは、現在セット
     アップされているS1C88シリーズ開発ツールパッケージをいったんアンイン
     ストールしてから再度お試しください

  ※ インストール先のディレクトリ名は8文字以内でスペースを含まないように
     指定してください

  インストール後、S1C88開発ツールパッケージは以下のディレクトリツリーでHDD
  に展開されます。

  Epson\S1C88                   README_J.txt、README_E.txt
     +--- BIN                   S1C88 Cコンパイラ
     |                          WorkBench
     |                          ICE88UR
     |       +--- DB88          デバッガ
     |       +--- SAP           構造化アセンブラツール
     +--- ETC                   S1C88 デフォルトロケータ定義ファイル
     +--- INCLUDE               S1C88 Cコンパイラ用ヘッダファイル
     +--- LIB                   S1C88 Cコンパイラ用ライブラリファイル
     |       +--- LIBCS         スモールモデルライブラリオブジェクト
     |       +--- LIBCC         コンパクト・コードモデルライブラリオブジェクト
     |       +--- LIBCD         コンパクト・データモデルライブラリオブジェクト
     |       +--- LIBCL         ラージモデルライブラリオブジェクト
     |       +--- SRC           ライブラリソースファイル
     +--- DEV                   S1C88シリーズ機種別ロケータ定義ファイル
     +--- SAMPLES               サンプルプログラムソース
     +--- WRITER                Flashマイコンライターツール
     +--- ICE
     |       +--- FPGA          FPGAデータ
     |       +--- ICE88URupd    ICE88UR用ファームウェアアップデートツール
     +--- DOC
             +--- Japanese      ツールマニュアル（日本語版）
             +--- English       ツールマニュアル（英語版）

■ 環境設定
  S1C88開発ツールを使用するために、以下の設定を追加する必要があります。

  SET PATH=C:\Epson\S1C88\BIN;%PATH%
  SET C88INC=C:\Epson\S1C88\INCLUDE
  SET C88LIB=C:\Epson\S1C88\LIB

　ファイル addpath.bat に上記設定が記述されています。

■ ツールのバージョン
  コンパイラツール                 v1.2 r3
  ワークベンチ     WB88.exe        Ver 2.04
                   WB88649.exe     Ver 1.00
  ICE              DB88.EXE        Ver 1.60
  ライタツール
                   G8F3605A.exe    
                   G8F3605C.exe    
                   rw88f360.exe    Ver 1.10
                   88F360.FRM      Ver 1.25
                   OBPW88.exe      Ver 2.70
                   rw8f360.ini     Ver 1.03
                   rw8f626.ini     Ver 1.00

  FPGA             C88348V1.mcs    Ver 1		(S1C88317、S1C88348、S1C88832、S1C88862用)
                   C88316V1.mcs    Ver 1		(S1C88104、S1C88112、S1C88308、S1C88316用)
                   C88649V2.mcs    Ver 2		(S1C88649用)
                   C88650V2.mcs    Ver 2		(S1C88650用)
                   C88655V1.mcs    Ver 1		(S1C88655用)
                   C8F626V1.mcs    Ver 1		(S1C8F626用)
                   c88816V1.mcs    Ver 1		(S1C88349、S1C88816、S1C8F360用)
                   c88848V1.mcs    Ver 1		(S1C88848用)
                   c8E108V1.mcs    Ver 1		(S1C8E108用)

  Devツール
                   WinFog.EXE      Ver 1.06
                   WinMdc.EXE      Ver 1.05
  88104                            Ver 7
                   FIL88104.EXE    Ver 3.00
                   S1C88104.ini    Ver 1.01
                   88104.PAR       Ver 2.01
  88112                            Ver 7
                   FIL88112.EXE    Ver 3.00
                   S1C88112.ini    Ver 1.01
                   88112.PAR       Ver 2.01
  88308                            Ver 9
                   FIL88308.EXE    Ver 3.00
                   S1C88308.ini    Ver 1.01
                   88308.PAR       Ver 2.01
  88316                            Ver 9
                   FIL88316.EXE    Ver 3.00
                   S1C88316.ini    Ver 1.01
                   88316.PAR       Ver 2.01
  88317                            Ver 3
                   FIL88317.EXE    Ver 2.00
                   S1C88317.ini    Ver 1.02
                   88317.PAR       Ver 1.01
  88348                            Ver 4
                   FIL88348.EXE    Ver 3.00
                   S1C88348.ini    Ver 1.02
                   88348.PAR       Ver 2.01
  88349                            Ver 4
                   FIL88349.EXE    Ver 2.00
                   S1C88349.ini    Ver 1.06
                   88349.PAR       Ver 1.00
  8F360                            Ver 6
                   FIL8F360.EXE    Ver 2.00
                   S1C8F360.ini    Ver 4.00
                   8F360.PAR       Ver 1.01
  88365                            Ver 5
                   FIL88365.EXE    Ver 3.00
                   S1C88365.ini    Ver 1.00
                   88365.PAR       Ver 2.01
  88816                            Ver 5
                   FIL88816.EXE    Ver 2.00
                   S1C88816.ini    Ver 2.02
                   88816.PAR       Ver 1.01
  88832                            Ver 3
                   FIL88832.EXE    Ver 2.00
                   S1C88832.ini    Ver 1.02
                   88832.PAR       Ver 1.01
  88848                            Ver 3
                   FIL88848.EXE    Ver 2.00
                   S1C88848.ini    Ver 1.00
                   88848.PAR       Ver 1.00
  88862                            Ver 4
                   FIL88862.EXE    Ver 3.00
                   S1C88862.ini    Ver 1.02
                   88862.PAR       Ver 2.01
  88408                            Ver 1(DOS)
                   FIL88408.EXE    Ver 2.00
                   88408.PAR       Ver 1.20
  88409                            Ver 4(DOS)
                   FIL88409.EXE    Ver 2.00
                   88409.PAR       Ver 1.01
  88649                            Ver 4
                   FIL88649.EXE    Ver 2.00
                   S1C88649.ini    Ver 3.00
                   88649.PAR       Ver 1.00
  88650                            Ver 6
                   FIL88650.EXE    Ver 1.01
                   S1C88650.ini    Ver 5.01
                   88650.PAR       Ver 5.00
  88655                            Ver 5
                   FIL88655.EXE    Ver 1.00
                   S1C88655.ini    Ver 5.00
                   88655.PAR       Ver 5.00
  8F626                            Ver 3
                   FIL8F626.EXE    Ver 1.00
                   S1C8F626.ini    Ver 1.20
                   8F626.PAR       Ver 1.00
  8E108                            Ver 3
                   FIL8E108.EXE    Ver 1.00
                   S1C8E108.ini    Ver 1.10
                   8E108.PAR       Ver 1.00

■ リリース履歴，マニュアルとの相違点，マニュアルに記載されていない制限事項
   これらに関しては、\doc\japanese フォルダのリリースノートrel_xxx.txtを
   参照下さい。

■ Cコンパイラのコード効率
   Cコンパイラが生成するアセンブラコードは,アセンブラで開発した場合のコードと比較して
   Smallモデル：コードサイズ,実行速度とも,おおよそ2倍
   Largeモデル：コードサイズ,実行速度とも,おおよそ4倍
   （CompactCode,CompactDataモデルは上記の中間）
   となりますので,処理速度が要求されるような場合や,コンパクトなコードサイズが要求される
   ような場合は,アセンブラでのプログラム開発をお勧めします。
   （コードサイズ比は処理内容によって異なり,上記コードサイズはあくまで目安です。）

Copyright(C) 2000-2008 SEIKO EPSON Corporation, All rights reserved.

※ 本文中にあります会社名および製品名はそれぞれ各社の商標または登録商標です
