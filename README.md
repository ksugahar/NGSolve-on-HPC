# NGSolveを東大HPCで動かす方法
---
## 準備1： NGSolveのインストール
---

これは結構ややこしい。
install.shを準備してありますがアップはしていません。

---
## 準備2：動作確認用のファイルの取得
---
```
git clone https://github.com/ksugahar/NGSolve-on-HPC.git
```
---
## Check1： まずはログインノードにてシングルコアで実施
---
下記の操作を実行すると
```
module load intel
module load impi
python3 check_single.py
````
NGSolveのバージョンが戻ってきたら動作しているはず。

---
## Check2： 次にinteractiveモードで並列実行
---
interactiveモードで実行するには
```
pjsub --interact -g gy42 -L rscgrp=interactive-a,node=1
```
でインターラクティブモードに入る。
よく使うのでエイリアスに登録してもよい。

インターラクティブモードではmoduleはloadし直し。
```
module load intel
module load impi
mpirun -np 2 python3 check_mpi.py
```
(u,f) = 0.03514425373579321
となれば計算できているでしょう。
solution.pickelはゴミなので削除

```
rm solution.pickle*
```
計算が終わったらexitでinteractiveから抜けましょう。

---
## Check3： 最後に128並列を実行
---
ジョブ投入スクリプトを編集する
```
#!/bin/sh
#PJM -L ngcgrp=share
#PJM -L gpu=1
#PJM -L elaspe=2:00:00
#PJM -g gy42
#PJM -j
module load intel
module load impi
mpirun -np 128 python3
```
これをpjsub経由で実行
pjsub check3_pjsub.sh
solution.pickelが大量に作成されたら成功

solution.pickelはゴミなので確認後削除

