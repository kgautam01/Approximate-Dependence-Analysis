; ModuleID = 'test2.ll'
source_filename = "test2.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %arr = alloca [100 x i32], align 16
  %brr = alloca [100 x i32], align 16
  call void @llvm.dbg.value(metadata i32 100, metadata !11, metadata !DIExpression()), !dbg !12
  call void @llvm.dbg.declare(metadata [100 x i32]* %arr, metadata !13, metadata !DIExpression()), !dbg !17
  call void @llvm.dbg.declare(metadata [100 x i32]* %brr, metadata !18, metadata !DIExpression()), !dbg !19
  call void @llvm.dbg.value(metadata i32 0, metadata !20, metadata !DIExpression()), !dbg !22
  br label %for.body, !dbg !23

for.body:                                         ; preds = %entry, %for.inc16
  %i.02 = phi i32 [ 0, %entry ], [ %inc17, %for.inc16 ]
  call void @llvm.dbg.value(metadata i32 %i.02, metadata !20, metadata !DIExpression()), !dbg !22
  %sub = sub nsw i32 %i.02, 1, !dbg !24
  %idxprom = sext i32 %sub to i64, !dbg !27
  %arrayidx = getelementptr inbounds [100 x i32], [100 x i32]* %arr, i64 0, i64 %idxprom, !dbg !27
  %0 = load i32, i32* %arrayidx, align 4, !dbg !27
  %add = add nsw i32 %0, 100, !dbg !28
  %idxprom1 = sext i32 %i.02 to i64, !dbg !29
  %arrayidx2 = getelementptr inbounds [100 x i32], [100 x i32]* %arr, i64 0, i64 %idxprom1, !dbg !29
  store i32 %add, i32* %arrayidx2, align 4, !dbg !30
  call void @llvm.dbg.value(metadata i32 0, metadata !31, metadata !DIExpression()), !dbg !33
  br label %for.body5, !dbg !34

for.body5:                                        ; preds = %for.body, %for.inc
  %j.01 = phi i32 [ 0, %for.body ], [ %inc, %for.inc ]
  call void @llvm.dbg.value(metadata i32 %j.01, metadata !31, metadata !DIExpression()), !dbg !33
  %idxprom6 = sext i32 %i.02 to i64, !dbg !35
  %arrayidx7 = getelementptr inbounds [100 x i32], [100 x i32]* %arr, i64 0, i64 %idxprom6, !dbg !35
  %1 = load i32, i32* %arrayidx7, align 4, !dbg !35
  %idxprom8 = sext i32 %j.01 to i64, !dbg !38
  %arrayidx9 = getelementptr inbounds [100 x i32], [100 x i32]* %brr, i64 0, i64 %idxprom8, !dbg !38
  store i32 %1, i32* %arrayidx9, align 4, !dbg !39
  %idxprom10 = sext i32 %j.01 to i64, !dbg !40
  %arrayidx11 = getelementptr inbounds [100 x i32], [100 x i32]* %brr, i64 0, i64 %idxprom10, !dbg !40
  %2 = load i32, i32* %arrayidx11, align 4, !dbg !40
  %add12 = add nsw i32 %2, 100, !dbg !41
  %sub13 = sub nsw i32 %j.01, 2, !dbg !42
  %idxprom14 = sext i32 %sub13 to i64, !dbg !43
  %arrayidx15 = getelementptr inbounds [100 x i32], [100 x i32]* %brr, i64 0, i64 %idxprom14, !dbg !43
  store i32 %add12, i32* %arrayidx15, align 4, !dbg !44
  br label %for.inc, !dbg !45

for.inc:                                          ; preds = %for.body5
  %inc = add nsw i32 %j.01, 1, !dbg !46
  call void @llvm.dbg.value(metadata i32 %inc, metadata !31, metadata !DIExpression()), !dbg !33
  %cmp4 = icmp slt i32 %inc, 100, !dbg !47
  br i1 %cmp4, label %for.body5, label %for.end, !dbg !34, !llvm.loop !48

for.end:                                          ; preds = %for.inc
  br label %for.inc16, !dbg !50

for.inc16:                                        ; preds = %for.end
  %inc17 = add nsw i32 %i.02, 1, !dbg !51
  call void @llvm.dbg.value(metadata i32 %inc17, metadata !20, metadata !DIExpression()), !dbg !22
  %cmp = icmp slt i32 %inc17, 100, !dbg !52
  br i1 %cmp, label %for.body, label %for.end18, !dbg !23, !llvm.loop !53

for.end18:                                        ; preds = %for.inc16
  ret i32 0, !dbg !55
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
!1 = !DIFile(filename: "test2.c", directory: "/media/lavo07/lavo07/Approximate Dependency")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 10.0.1 (https://github.com/llvm/llvm-project.git ef32c611aa214dea855364efd7ba451ec5ec3f74)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 2, type: !8, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "c", scope: !7, file: !1, line: 4, type: !10)
!12 = !DILocation(line: 0, scope: !7)
!13 = !DILocalVariable(name: "arr", scope: !7, file: !1, line: 5, type: !14)
!14 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 3200, elements: !15)
!15 = !{!16}
!16 = !DISubrange(count: 100)
!17 = !DILocation(line: 5, column: 9, scope: !7)
!18 = !DILocalVariable(name: "brr", scope: !7, file: !1, line: 6, type: !14)
!19 = !DILocation(line: 6, column: 9, scope: !7)
!20 = !DILocalVariable(name: "i", scope: !21, file: !1, line: 7, type: !10)
!21 = distinct !DILexicalBlock(scope: !7, file: !1, line: 7, column: 5)
!22 = !DILocation(line: 0, scope: !21)
!23 = !DILocation(line: 7, column: 5, scope: !21)
!24 = !DILocation(line: 9, column: 23, scope: !25)
!25 = distinct !DILexicalBlock(scope: !26, file: !1, line: 8, column: 5)
!26 = distinct !DILexicalBlock(scope: !21, file: !1, line: 7, column: 5)
!27 = !DILocation(line: 9, column: 18, scope: !25)
!28 = !DILocation(line: 9, column: 27, scope: !25)
!29 = !DILocation(line: 9, column: 9, scope: !25)
!30 = !DILocation(line: 9, column: 16, scope: !25)
!31 = !DILocalVariable(name: "j", scope: !32, file: !1, line: 10, type: !10)
!32 = distinct !DILexicalBlock(scope: !25, file: !1, line: 10, column: 9)
!33 = !DILocation(line: 0, scope: !32)
!34 = !DILocation(line: 10, column: 9, scope: !32)
!35 = !DILocation(line: 12, column: 22, scope: !36)
!36 = distinct !DILexicalBlock(scope: !37, file: !1, line: 11, column: 9)
!37 = distinct !DILexicalBlock(scope: !32, file: !1, line: 10, column: 9)
!38 = !DILocation(line: 12, column: 13, scope: !36)
!39 = !DILocation(line: 12, column: 20, scope: !36)
!40 = !DILocation(line: 13, column: 24, scope: !36)
!41 = !DILocation(line: 13, column: 31, scope: !36)
!42 = !DILocation(line: 13, column: 18, scope: !36)
!43 = !DILocation(line: 13, column: 13, scope: !36)
!44 = !DILocation(line: 13, column: 22, scope: !36)
!45 = !DILocation(line: 14, column: 9, scope: !36)
!46 = !DILocation(line: 10, column: 34, scope: !37)
!47 = !DILocation(line: 10, column: 26, scope: !37)
!48 = distinct !{!48, !34, !49}
!49 = !DILocation(line: 14, column: 9, scope: !32)
!50 = !DILocation(line: 15, column: 5, scope: !25)
!51 = !DILocation(line: 7, column: 30, scope: !26)
!52 = !DILocation(line: 7, column: 22, scope: !26)
!53 = distinct !{!53, !23, !54}
!54 = !DILocation(line: 15, column: 5, scope: !21)
!55 = !DILocation(line: 16, column: 5, scope: !7)
