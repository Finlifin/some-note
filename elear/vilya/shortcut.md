    @compileInstructions(args) functionName<comptime args> arg_one arg_two ...

    (+234) --Shall be Num a => a -> a

    Core.(+) Complex -> Complex -> Complex
    Core.(+) a b =
            Complex(
                a.a + b.a,
                b.b + a.b
            )

    impl MyData:
        TypeBindA = Typename
        fmt data = <fmt>
            "name is " <> data.value <> "\n"
            </fmt>


read::String -> a

    int scanf(char* fmt, fmt_list...)
        + 可变引用写操作,副作用
        + 编译期可知的不定参数
>Or maybe we shall just impl it into a macro

        fscanf stdin "<{d},{d}>" {&a, &b}
scanf::FileHandle -> String -> comptime Map -> IO ()
scanf fh fmt target
    | @isEmptyComptimeMap target = return ()
    | otherwise = ...

data Ip = Ipv6 String | Ipv4 (UInt8, UInt8, UInt8, UInt8)
data Ip = Ipv6 String = Ipv6 "::"
        | Ipv4 (UInt8,UInt8,UInt8,UInt8) = Ipv4 (0,0,0,0)