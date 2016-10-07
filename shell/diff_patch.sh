#first: sudo make mrproper
#usage: make patch

version_num=2.6.30
diff -ruNa linux-$version_num-origin/ linux-$version_num >linux-$version_num.patch
