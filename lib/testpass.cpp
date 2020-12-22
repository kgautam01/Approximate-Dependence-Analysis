#include <iostream>
#include "llvm/ADT/Statistic.h"
#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include  "llvm/IR/LegacyPassManager.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/Analysis/DependenceAnalysis.h"
#include "llvm/Analysis/LoopAccessAnalysis.h"

using namespace llvm;

#define DEBUG 0

namespace {
  
  //A structure to hold all access info
  struct AccessInfo{
   
    int IterationDistance;
    int Levels; //loop levels
  
  };
  
  struct DependenceP : public FunctionPass {
    static char ID; 
    DependenceP() : FunctionPass(ID) {}
   
    void getAnalysisUsage(AnalysisUsage &AU) const {
        AU.addRequired<LoopInfoWrapperPass>();
        AU.addRequired<ScalarEvolutionWrapperPass>();
        AU.addRequired<DependenceAnalysisWrapperPass>();
    }

   // Used to get the array the instruction is accessing    
    Value* getArrayAccess(const SCEV *ptr){
        
        Value *arrName=NULL;

        if(const SCEVAddRecExpr *arrAddRecExp=dyn_cast<SCEVAddRecExpr>(ptr)){
           if(const SCEVNAryExpr *arrExpr=dyn_cast<SCEVNAryExpr>(arrAddRecExp->getOperand(0))){
              for(unsigned i=0;i<arrExpr->getNumOperands();i++){
                  if(const SCEVUnknown *arr=dyn_cast<SCEVUnknown>(arrExpr->getOperand(i)))
                      arrName=arr->getValue();
              }
           }
           else if(const SCEVUnknown *arr=dyn_cast<SCEVUnknown>(arrAddRecExp->getOperand(0)))
                      arrName=arr->getValue();  
        }

        return arrName;
    }

    // Gets the iteration distance
    int getDistance(const SCEVAddRecExpr* ptr){
        if(auto dist=cast<SCEVConstant>(ptr->getOperand(0)))
            return dist->getValue()->getSExtValue();
    }

    // Main function to check dependency between instructions in a loop
    void checkDependency(std::vector<Instruction*>Ins,DependenceInfo *DI,ScalarEvolution *SE){
        for(auto I=Ins.begin();I!=Ins.end();I++){
          
          //Checking if the pair of instructions are accessing memory or not 

          if((*I)->mayReadOrWriteMemory() &&  isa<GetElementPtrInst>(getLoadStorePointerOperand(*I))){ 
             for(auto J=I;J!=Ins.end();J++){
                   if((*J)==(*I))
                       continue;
                   if((*J)->mayReadOrWriteMemory() && isa<GetElementPtrInst>(getLoadStorePointerOperand(*J))){
                        
                        #if DEBUG
                        // (*I)->dump();
                        // (*J)->dump();
                        #endif 
                         
                          // Getting array Accesses 
                          
                          GetElementPtrInst *arr_access1= cast<GetElementPtrInst>(getLoadStorePointerOperand(*I));  
                          GetElementPtrInst *arr_access2= cast<GetElementPtrInst>(getLoadStorePointerOperand(*J));

                          auto A1=getArrayAccess(SE->getSCEV(arr_access1));  
                          auto A2=getArrayAccess(SE->getSCEV(arr_access2));
                          
                          //Same array access 
                          if(A1==A2){
                            #if DEBUG
                            // A1->dump();
                            // A2->dump();
                            #endif
                               AccessInfo acc1,acc2;

                                  for (auto gep_op= arr_access1->idx_begin();gep_op!=arr_access1->idx_end();gep_op++){
      
                                    const SCEV *index=SE->getSCEV(*gep_op);
                                    if(auto test=dyn_cast<SCEVAddRecExpr>(index)){
                                        acc1.IterationDistance=getDistance(test);
                                        acc1.Levels=test->getLoop()->getLoopDepth();  
                                    }
                                  }     
                              
                                  for (auto gep_op= arr_access2->idx_begin();gep_op!=arr_access2->idx_end();gep_op++){

                                    const SCEV *index=SE->getSCEV(*gep_op);
                                    if(auto test=dyn_cast<SCEVAddRecExpr>(index)){
                                        acc2.IterationDistance=getDistance(test);
                                        acc2.Levels=test->getLoop()->getLoopDepth();
                                     }
                                  }
                                  
                                  //same loop nest  
                                  if(acc1.Levels==acc2.Levels){
                                     if(isa<StoreInst>(*I) && isa<LoadInst>(*J)){ 
                                          #if DEBUG
                                          // llvm::dbgs()<<"Write Distance "<<acc1.IterationDistance<<"\n"; 
                                          // llvm::dbgs()<<"Read Distance "<<acc2.IterationDistance<<"\n";
                                          #endif 
                                          if((*I)->hasMetadata() && (*J)->hasMetadata()){
                                             
                                              auto DbgInfo1=(*I)->getDebugLoc();
                                              auto DbgInfo2=(*J)->getDebugLoc();

                                              if(acc1.IterationDistance>acc2.IterationDistance)
                                                llvm::outs()<<"WAR at "<<"line: "<<DbgInfo1.getLine()<<" col: "<<DbgInfo1.getCol()<<" --> "
                                                                                                                                  <<"line: "<<DbgInfo2.getLine()<<" col: "<<DbgInfo2.getCol()<<"\n";
                                              else if(acc1.IterationDistance<acc2.IterationDistance) 
                                                llvm::outs()<<"RAW at "<<"line: "<<DbgInfo1.getLine()<<" col: "<<DbgInfo1.getCol()<<" --> "
                                                                                                                                  <<"line: "<<DbgInfo2.getLine()<<" col: "<<DbgInfo2.getCol()<<"\n";

                                          }    

                                         else {

                                            llvm::outs()<<"-g disabled no Line numbers will be shown..\n";
                                            if(acc1.IterationDistance>acc2.IterationDistance)
                                                llvm::outs()<<"WAR\n";
                                            else if(acc1.IterationDistance<acc2.IterationDistance) 
                                                llvm::outs()<<"RAW\n";
                                         
                                         }
                                     }
                                     else if(isa<StoreInst>(*J) && isa<LoadInst>(*I)){
                                          #if DEBUG
                                          // llvm::dbgs()<<"Write Distance "<<acc2.IterationDistance<<"\n"; 
                                          // llvm::dbgs()<<"Read Distance "<<acc1.IterationDistance<<"\n";
                                          #endif
                                          if((*I)->hasMetadata() && (*J)->hasMetadata()){
                                             
                                              auto DbgInfo1=(*I)->getDebugLoc();
                                              auto DbgInfo2=(*J)->getDebugLoc();

                                              if(acc2.IterationDistance>acc1.IterationDistance)
                                                  llvm::outs()<<"WAR at "<<"line: "<<DbgInfo1.getLine()<<" col: "<<DbgInfo1.getCol()<<" --> "
                                                                                                                                  <<"line: "<<DbgInfo2.getLine()<<" col: "<<DbgInfo2.getCol()<<"\n";
                                              else if(acc2.IterationDistance<acc1.IterationDistance) 
                                                  llvm::outs()<<"RAW at "<<"line: "<<DbgInfo1.getLine()<<" col: "<<DbgInfo1.getCol()<<" --> "
                                                                                                                                  <<"line: "<<DbgInfo2.getLine()<<" col: "<<DbgInfo2.getCol()<<"\n";
                                          }
                                          else {

                                            llvm::outs()<<"-g disabled no Line numbers will be shown..\n";
                                            if(acc2.IterationDistance>acc1.IterationDistance)
                                                llvm::dbgs()<<"WAR\n";
                                            else if(acc2.IterationDistance<acc1.IterationDistance) 
                                                llvm::dbgs()<<"RAW\n"; 
                                          }
                                     }
                                  }
                          
                          }
              
                    }
               }
            }
        }
    }

   //Runs as a function pass
    bool runOnFunction(Function &F) override {

      auto *LI=&getAnalysis<LoopInfoWrapperPass>().getLoopInfo();
      auto *SE=&getAnalysis<ScalarEvolutionWrapperPass>().getSE();
      auto *DI=&getAnalysis<DependenceAnalysisWrapperPass>().getDI();
      
      std::vector<Instruction*> AllIns;

      for(Loop *L:*LI){
            for(auto &BB:L->getBlocks()){
                for(auto I=BB->begin();I!=BB->end();I++)
                    AllIns.push_back(&*I);     
                }
            checkDependency(AllIns,DI,SE);
            AllIns.clear();
      }
      return false;
    }

  };
}

char DependenceP::ID = 0;
static RegisterPass<DependenceP> X("Dependence", "Funcion Name Pass");



