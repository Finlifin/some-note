#set document(title: "Narya Language")

= 取舍
- 内存管理
    - Ownnership
    - Lifetime
    - RAII
    - Allocator
    - Defer && Errdefer
    - Rc
- 数据可变性
- 命令式代码封装
- 动态派发与静态派发
- 传参类型
- 并发模型
- 状态管理
- 元编程与编译指令
- 数据构造
- 命名空间管理

= Remained Words
```rust
    data, where, unsafe, class, of, for, do, in, action, impl, with, default, ref, unref
```

= Some Syntanx
```hs
    --This is a comment.
    sum xs = x + sum xs
    sum [] = 0

    sum xs = action
                sum := 0
                for x in xs
                    sum := sum + x
                return sum
    data Date = Friday | Sunday | Saturday | Other

    impl Date:
        impl Debug:
            --...
```

```hs
    (sendResponse request client) >>= body >>= parse >>= print
        where request = < Request | GET github.com/finlifin >
              client = < Client | SimpleClient >
              body = HTTP.Data.body
              parse = JSON.parse Dict
```

```hs
    doSomething::SomeClass a=> a -> a -> @typeof something
    doSomething a b = @todo
```