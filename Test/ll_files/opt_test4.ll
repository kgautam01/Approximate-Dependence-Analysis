; ModuleID = 'test4.ll'
source_filename = "test4.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %arr = alloca [100 x i32], align 16
  call void @llvm.dbg.value(metadata i32 2, metadata !11, metadata !DIExpression()), !dbg !12
  call void @llvm.dbg.declare(metadata [100 x i32]* %arr, metadata !13, metadata !DIExpression()), !dbg !17
  call void @llvm.dbg.value(metadata i32 0, metadata !18, metadata !DIExpression()), !dbg !20
  br label %for.body, !dbg !21

for.body:                                         ; preds = %entry, %for.inc
  %i.01 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  call void @llvm.dbg.value(metadata i32 %i.01, metadata !18, metadata !DIExpression()), !dbg !20
  %add = add nsw i32 %i.01, 1, !dbg !22
  %idxprom = sext i32 %add to i64, !dbg !25
  %arrayidx = getelementptr inbounds [100 x i32], [100 x i32]* %arr, i64 0, i64 %idxprom, !dbg !25
  %0 = load i32, i32* %arrayidx, align 4, !dbg !25
  %add1 = add nsw i32 %0, 2, !dbg !26
  call void @llvm.dbg.value(metadata i32 %add1, metadata !27, metadata !DIExpression()), !dbg !12
  %mul = mul nsw i32 2, 10, !dbg !28
  %sub = sub nsw i32 %i.01, 2, !dbg !29
  %idxprom2 = sext i32 %sub to i64, !dbg !30
  %arrayidx3 = getelementptr inbounds [100 x i32], [100 x i32]* %arr, i64 0, i64 %idxprom2, !dbg !30
  store i32 %mul, i32* %arrayidx3, align 4, !dbg !31
  br label %for.inc, !dbg !32

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.01, 1, !dbg !33
  call void @llvm.dbg.value(metadata i32 %inc, metadata !18, metadata !DIExpression()), !dbg !20
  %cmp = icmp slt i32 %inc, 100, !dbg !34
  br i1 %cmp, label %for.body, label %for.end, !dbg !21, !llvm.loop !35

for.end:                                          ; preds = %for.inc
  ret i32 0, !dbg !37
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.1 (https://github.com/llvm/llvm-project.git ef32c611aa214dea855364efd7ba451ec5ec3f74)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test4.c", directory: "/media/lavo07/lavo07/Approximate Dependency")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 10.0.1 (https://github.com/llvm/llvm-project.git ef32c611aa214dea855364efd7ba451ec5ec3f74)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 2, type: !8, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "c", scope: !7, file: !1, line: 5, type: !10)
!12 = !DILocation(line: 0, scope: !7)
!13 = !DILocalVariable(name: "arr", scope: !7, file: !1, line: 6, type: !14)
!14 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 3200, elements: !15)
!15 = !{!16}
!16 = !DISubrange(count: 100)
!17 = !DILocation(line: 6, column: 9, scope: !7)
!18 = !DILocalVariable(name: "i", scope: !19, file: !1, line: 7, type: !10)
!19 = distinct !DILexicalBlock(scope: !7, file: !1, line: 7, column: 5)
!20 = !DILocation(line: 0, scope: !19)
!21 = !DILocation(line: 7, column: 5, scope: !19)
!22 = !DILocation(line: 9, column: 18, scope: !23)
!23 = distinct !DILexicalBlock(scope: !24, file: !1, line: 8, column: 5)
!24 = distinct !DILexicalBlock(scope: !19, file: !1, line: 7, column: 5)
!25 = !DILocation(line: 9, column: 13, scope: !23)
!26 = !DILocation(line: 9, column: 22, scope: !23)
!27 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 4, type: !10)
!28 = !DILocation(line: 10, column: 21, scope: !23)
!29 = !DILocation(line: 10, column: 14, scope: !23)
!30 = !DILocation(line: 10, column: 9, scope: !23)
!31 = !DILocation(line: 10, column: 18, scope: !23)
!32 = !DILocation(line: 11, column: 5, scope: !23)
!33 = !DILocation(line: 7, column: 31, scope: !24)
!34 = !DILocation(line: 7, column: 23, scope: !24)
!35 = distinct !{!35, !21, !36}
!36 = !DILocation(line: 11, column: 5, scope: !19)
!37 = !DILocation(line: 12, column: 5, scope: !7)
