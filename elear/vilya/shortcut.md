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