# JudgeImage-clang
Docker image for C language online judge.

## how to use.
### Installation
```sh
docker pull ghcr.io/algoattacker/judgeimage-clang:main
```

### Write down
example: Find the maximum value.

`source.c`:
```c
#include <stdio.h>

int main(void) {
  int a, max = -1;
  scanf("%d", &a);

  for (int i = 0; i < a; i++) {
    int b;
    scanf("%d\n", &b);
    if (max < b) {
      max = b;
    }
  }
  
  printf("%d\n", max);
}
```

`judge/1.in`:
```
7
40 5 20 60 50 80 70
```

`judge/1.out`:
```
80
```

`judge/2.in`:
```
5
5 30 20 50 30
```

`judge/2.out`:
```
50
```

### Initialization
```sh
containerId=$(docker create ghcr.io/algoattacker/judgeimage-clang:main)

docker start $containerId

docker cp ./source.c $containerId:/source.c
docker cp ./judge $containerId:/judge
```

### Run
```sh
timeout="3" # in second
secretKey="m<p*)qOaK&uGVn2"

docker exec $containerId /solver.sh $secretKey $timeout
```
