#include "llvm/ADT/ArrayRef.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/BasicBlock.h"

#include "llvm/IR/IRBuilder.h"
#include <vector>
#include <string>

int main()
{
	llvm::LLVMContext &context = llvm::getGlobalContext();
	llvm::Module *pModule = new llvm::Module("asdf", context);
	llvm::IRBuilder<> builder(context);

	do {
		llvm::FunctionType *funcType = llvm::FunctionType::get(builder.getVoidTy(), false);
		llvm::Function *pFunction = 
			llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "main", pModule);
		llvm::BasicBlock *pBasicBlock = llvm::BasicBlock::Create(context, "entrypoint", pFunction);
		builder.SetInsertPoint(pBasicBlock);
	} while (0);

	do {
		std::vector<llvm::Type *> argTypes;
		argTypes.push_back(builder.getInt8Ty()->getPointerTo());
		llvm::ArrayRef<llvm::Type *> argTypesRef(argTypes);
		llvm::FunctionType *pFunctionType = 
			llvm::FunctionType::get(builder.getInt32Ty(), argTypesRef, false);
		llvm::Constant *pConstant = pModule->getOrInsertFunction("puts", pFunctionType);
		builder.CreateCall(pConstant, builder.CreateGlobalStringPtr("hello world!\n"));
	} while (0);

	do {
		//std::vector<llvm::Value *> argValues;
		//argValues.push_back(builder.CreateGlobalStringPtr("hello world!\n"));
		//argValues.push_back(builder.CreateGlobalStringPtr("hello world!\n"));
		//llvm::ArrayRef<llvm::Value *> argValuesRef(argValues);
		//builder.CreateCall(func, argValuesRef);
	} while (0);

	builder.CreateRetVoid();
	pModule->dump();
}
