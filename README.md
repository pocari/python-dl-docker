# ゼロから作るDeep Learning 用 Dockerfle(mac用)

## 必要ライブラリ

### グラフ描画結果をmac側で見たい場合

グラフの描画結果をGUIで表示するためにdocker側からmacのXQuartzに飛ばすためmac側でも準備が要る

```
brew install socat
brew install caskroom/cask/brew-cask
brew cask install xquartz
```

## build

```
docker build -t python-dl .
```

## run

別ウィンドウでdockerから表示するためのmac側の待受ポートを設定する。
これでDocker側からこのPCのipアドレスに向けてグラフの画像を送信できる。
```
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
```

DISPLAY環境変数を(このPCのipアドレス:0)に設定してコンテナ起動
```
docker run --rm -it -e DISPLAY=$(ifconfig en0 | grep -v inet6 | grep inet | awk '{print $2 ":0"}') -v $(pwd):/var/python python-dl bash
```

グラフ描画無しで`numpy`のみ使う場合は
```
docker run --rm -it -v $(pwd):/var/python python-dl bash
```

## sample

コンテナ内で

```
python sample/sample.py
```

を実行しmac側下記のグラフが出れば正常にインストール終了。

- 注意事項
  - PC起動後初回起動時はグラフ描画時にXQuartzの起動も行われるので多少時間がかかる
  - コンテナ起動後初回の`matploglib`のimport時に

    ```
    /usr/local/lib/python3.5/site-packages/matplotlib/font_manager.py:273: UserWarning: Matplotlib is building the font cache using fc-list. This may take a moment.
  warnings.warn('Matplotlib is building the font cache using fc-list. This may take a moment.')
    ```

    の警告が出る。

