<<<<<<< 0935e2e77af6d69f2328dfeeb304a2925f2d08c8
# adaboost
Adaboostの試作コード
=======
# AdaBoost
機械学習アルゴリズムのひとつであるAdaBoostを実験的にRubyで実装してみた。

##参考文献
* Rapid Object Detection using a Boosted Cascade of Simple
Features  [Here!](https://www.cs.cmu.edu/~efros/courses/LBMV07/Papers/viola-cvpr-01.pdf)
* 局所特徴量と統計学習手法による物体検出  [Here!](http://www.slideshare.net/MPRG_Chubu_University/ss-32258845)
* AdaBoost - Wikipedia [Here!](https://ja.wikipedia.org/wiki/AdaBoost)

## memo
### 使用にあたって
* 簡単な学習データ（低次元、学習データ少数）で、簡単なテストのみ確認
* 本格的に使用すると学習時間滅茶苦茶かかるので覚悟（マシンパワー必須）

### 学習データファイルのフォーマット
~~~csv
# N次元の特徴ベクトル（データ）
[label] [data1] [data2] ... [dataN]   #一個目の学習ベクトル
[label] [data1] [data2] ... [dataN]   #二個目の学習ベクトル

# この時、label = {+1, -1}
# 正クラス：+1、負クラス：-1　をそれぞれとる

#　記述例(二次元データの場合)
-1 -2.416682586290083 -1.6340630148871529
-1 -0.4611169335807954 1.1720161088656624
1 1.771127779864452 0.6400316433636748
1 0.3076072954507474 0.47308423467735405
~~~
>>>>>>> アカウント移動に伴うfirst commit
