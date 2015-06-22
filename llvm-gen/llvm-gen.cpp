#include "llvm/ADT/STLExtras.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/ExecutionEngine/Interpreter.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/ManagedStatic.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"

#include <vector>
#include <string>
#include <iostream>

int main()
{
	llvm::InitializeNativeTarget();
	llvm::LLVMContext &context = llvm::getGlobalContext();
	std::unique_ptr<llvm::Module> pModule(new llvm::Module("asdf", context));
	llvm::IRBuilder<> builder(context);

	do {
		llvm::FunctionType *funcType = llvm::FunctionType::get(builder.getVoidTy(), false);
		llvm::Function *pFunction = 
			llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "main", pModule.get());
		llvm::BasicBlock *pBasicBlock = llvm::BasicBlock::Create(context, "entrypoint", pFunction);
		builder.SetInsertPoint(pBasicBlock);
	} while (0);

	do {
		llvm::Value *pPointer = builder.CreateAlloca(llvm::Type::getInt32Ty(context), 0, "x");
		builder.CreateStore(llvm::ConstantInt::get(llvm::Type::getInt32Ty(context), 123),
							pPointer);
		builder.CreateLoad(pPointer);
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
	do {
		//llvm::raw_os_ostream out(std::cout);	
		//llvm::WriteBitcodeToFile(pModule, out);
		//out.close();
	} while (0);
	do {
		llvm::ExecutionEngine *pExecutionEngine = llvm::EngineBuilder(std::move(pModule)).create();
		pExecutionEngine->finalizeObject();
		llvm::Function *pFunction = pExecutionEngine->FindFunctionNamed("main");

		std::vector<llvm::GenericValue> args;
		pExecutionEngine->runFunction(pFunction, args);
#if 1
		void *fp = pExecutionEngine->getPointerToFunction(pFunction);
		::printf("%p\n", fp);
		reinterpret_cast<int (*)()>(fp)();
#endif
	} while (0);
	return 0;
}
