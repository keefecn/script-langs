## version
2017/10/15 created by keefe

## intro
Parse command-line options
参数可分为二种：optional argument（选项参数，以-开头），positional argument（位置参数）

argparse 参数解析
* argc 参数个数
* argv 参数项

## shell
```
# $@表示所有参数，
# $1-$9，命令行最多传递9个参数
for args in $@
do
    echo $args
done

```

## python
* argparse — Parser for command-line options, arguments and sub-commands
* optparse — Parser for command line options
* getopt — C-style parser for command line options

```
# argparse
import argparse
parser = argparse.ArgumentParser(description='topic spider')

# optparse
from optparse import OptionParser
parser = OptionParser(description='topic spider')

# getopt
import getopt, sys
opts, args = getopt.getopt(sys.argv[1:], "ho:v", ["help", "output="])
print(opts, args)
```


## c/cpp
* functions: getopt, getopt_long, getopt_long_only, optarg, optind, opterr, optopt
```
#include <unistd.h>
int getopt(int argc, char * const argv[],
          const char *optstring);
```

## java
