define i32 @add2(i32 %a, i32 %b) {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 %a, i32* %1, align 4
  store i32 %b, i32* %2, align 4
  %3 = load i32* %1, align 4
  %4 = load i32* %2, align 4
  %5 = add nsw i32 %3, %4
  ret i32 %5
}

@.str1 = private unnamed_addr constant [16 x i8] c"hello world %d\0A\00", align 1

define void @hello(i32 %a) {
  %1 = alloca i32, align 4
  store i32 %a, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([16 x i8]* @.str1, i32 0, i32 0), i32 %2)
  ret void
}

@.str2 = private unnamed_addr constant [17 x i8] c"string in sub.ll\00", align 1

define void @foo() {
  call void @func(i8* getelementptr inbounds ([17 x i8]* @.str2, i32 0, i32 0))
  ret void
}

declare i32 @printf(i8*, ...)
declare void @func(i8*) #1
