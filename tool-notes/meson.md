# About Meson Build System
---
+ 依赖
    + 编译时依赖
    + 静态链接依赖
    + 动态链接依赖
+ 文件寻址
+ target
+ 编译参数


## **Common Usage**:

>获取/设置环境变量:
```python
#无法在meson.build中直接访问环境变量
env = environment()
env.set('Key', 'value')
```

>执行shell:

```python
run_command('command', ['args'])
```

>依赖管理：

    Just simply use subdir('subproject') for local source dependencies.

```python
dep = dependency('somedep', {})
```

>指定compiler编译参数

```python
add_global_arguments('', language:'C')
```

---
## **Integration With Cargo**:
- Example:

```rust
.
├── build.rs
├── Cargo.toml
├── clib
│   ├── meson.build
│   ├── squid.h
│   └── squid.c
└── src
    └── lib.rs
```

```rust
//build.rs
extern crate meson;
use std::env;
use std::path::PathBuf;

fn main() {
    let build_path = PathBuf::from(env::var("OUT_DIR").unwrap());
    build_path.join("build");
    let build_path = build_path.to_str().unwrap();

    println!("cargo:rustc-link-lib=squid");
    println!("cargo:rustc-link-search=native={}", build_path);
    meson::build("clib", build_path);//重点
}
```

```toml
#Cargo.toml
[build-dependencies]
meson = "1.0.0"
```

```python
#meson.build
project('squid', c)
shared_library('squid', 'squid.c')
```