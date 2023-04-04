**Example**:
```c
#include <stdio.h>
#include <dlfcn.h>

int main() {
    void* handle = dlopen("./libsome.so", RTLD_LAZY);
    int (*func)(int a, int b);
    func = dlsym(handle, "add");
    printf...
    dlclose(handle);
    return 0;
}

```