; ModuleID = 'a.bc'

@0 = private unnamed_addr constant [13 x i8] c"hello world!\00"

define void @main() {
entrypoint:
  %x = alloca i32
  store i32 123, i32* %x
  %0 = load i32* %x
  %1 = call i32 @puts(i8* getelementptr inbounds ([13 x i8]* @0, i32 0, i32 0))
  %2 = call i32 @func_mylli()
  ret void
}

declare i32 @puts(i8*)
declare i32 @func_mylli()
