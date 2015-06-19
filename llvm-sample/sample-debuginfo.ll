;-------------------------------------------------------------------------------
; [sample.cpp] 
; int func()
; {
;     return 0;
; }
;
; $ llvm-gcc -S -emit-llvm -g sample.cpp
;-------------------------------------------------------------------------------

; ModuleID = 'sample.cpp'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.9.0"

; Function Attrs: nounwind ssp uwtable
define i32 @_Z4funcv() #0 {
  ret i32 0, !dbg !12
}

attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!9, !10}
!llvm.ident = !{!11}

!0 = metadata !{i32 786449, metadata !1, i32 4, metadata !"Apple LLVM version 6.0 (clang-600.0.57) (based on LLVM 3.5svn)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/Users/ypsitau/trial/llvm-test/sample.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !"sample.cpp", metadata !"/Users/ypsitau/trial/llvm-test"}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"func", metadata !"func", metadata !"_Z4funcv", i32 1, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 ()* @_Z4funcv, null, null, metadata !2, i32 2} ; [ DW_TAG_subprogram ] [line 1] [def] [scope 2] [func]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/Users/ypsitau/trial/llvm-test/sample.cpp]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 2}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 600057001}
!11 = metadata !{metadata !"Apple LLVM version 6.0 (clang-600.0.57) (based on LLVM 3.5svn)"}
!12 = metadata !{i32 3, i32 0, metadata !4, null}
