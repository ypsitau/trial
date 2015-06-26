//===-- examples/HowToUseJIT/HowToUseJIT.cpp - An example use of the JIT --===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
//  This small program provides an example of how to quickly build a small
//  module with two functions and execute it with the JIT.
//
// Goal:
//  The goal of this snippet is to create in the memory
//  the LLVM module consisting of two functions as follow: 
//
// int add1(int x) {
//   return x+1;
// }
//
// int foo() {
//   return add1(10);
// }
//
// then compile the module via JIT, then execute the `foo'
// function and return result to a driver, i.e. to a "host program".
//
// Some remarks and questions:
//
// - could we invoke some code using noname functions too?
//   e.g. evaluate "foo()+foo()" without fears to introduce
//   conflict of temporary function name with some real
//   existing function name?
//
//===----------------------------------------------------------------------===//

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

int main()
{
	llvm::InitializeNativeTarget();
	llvm::LLVMContext context;
	std::unique_ptr<llvm::Module> pModule = llvm::make_unique<llvm::Module>("test", context);
	llvm::IRBuilder<> builder(context);
	do {
		// declare i32 @puts(i8*)
		llvm::Function *pFunction = llvm::cast<llvm::Function>(
			pModule->getOrInsertFunction(
				"puts",
				builder.getInt32Ty(),
				builder.getInt8Ty()->getPointerTo(),
				nullptr));
	} while (0);
	do {
		// define i32 @add1(i32)
		llvm::Function *pFunction = llvm::cast<llvm::Function>(
			pModule->getOrInsertFunction(
				"add1",
				builder.getInt32Ty(),	// return type
				builder.getInt32Ty(),	// argument type #1
				nullptr));
		llvm::BasicBlock *pBasicBlock = llvm::BasicBlock::Create(context, "entrypoint", pFunction);
		builder.SetInsertPoint(pBasicBlock);
		llvm::Argument *pArgument = pFunction->arg_begin();
		//pArgument->setName("AnArg");
		llvm::Value *pValue = builder.CreateAdd(
			builder.getInt32(1),
			pArgument);
		builder.CreateRet(pValue);
	} while (0);
	do {
		// define i32 @foo()
		llvm::Function *pFunction = llvm::cast<llvm::Function>(
			pModule->getOrInsertFunction(
				"foo",
				builder.getInt32Ty(),
				nullptr));
		llvm::BasicBlock *pBasicBlock = llvm::BasicBlock::Create(context, "entrypoint", pFunction);
		builder.SetInsertPoint(pBasicBlock);
		llvm::CallInst *pCallInst = builder.CreateCall(
			pModule->getFunction("add1"),
			builder.getInt32(10));
		pCallInst->setTailCall(true);
		builder.CreateRet(pCallInst);
	} while (0);
	do {
		// define i32 @bar()
		llvm::Function *pFunction = llvm::cast<llvm::Function>(
			pModule->getOrInsertFunction(
				"bar",
				builder.getInt32Ty(),
				nullptr));
		llvm::BasicBlock *pBasicBlock = llvm::BasicBlock::Create(context, "entrypoint", pFunction);
		builder.SetInsertPoint(pBasicBlock);
		llvm::CallInst *pCallInst = builder.CreateCall(
			pModule->getFunction("puts"),
			builder.CreateGlobalStringPtr("hello world!"));
		pCallInst->setTailCall(true);
		builder.CreateRet(pCallInst);
	} while (0);
	llvm::outs() << "We just constructed this LLVM module:\n\n" << *pModule;
	llvm::outs() << "\n\nRunning foo: ";
	llvm::outs().flush();
	do {
		std::unique_ptr<llvm::ExecutionEngine> pExecutionEngine(
			llvm::EngineBuilder(std::move(pModule)).create());
		//pExecutionEngine->addLibrary("c");
		pExecutionEngine->addGlobalMapping(
			pExecutionEngine->FindFunctionNamed("puts"), reinterpret_cast<void *>(&::puts));
		do {
			std::vector<llvm::GenericValue> args;
			llvm::GenericValue genericValue = pExecutionEngine->runFunction(
				pExecutionEngine->FindFunctionNamed("bar"), args);
			//llvm::outs() << "Result: " << genericValue.IntVal << "\n";
		} while (0);
		//do {
		//	typedef int (*Func)();
		//	Func func = reinterpret_cast<Func>(pExecutionEngine->getPointerToFunction(
		//										   pExecutionEngine->FindFunctionNamed("foo")));
		//	llvm::outs() << "Result: " << func() << "\n";
		//} while (0);
	} while (0);
	llvm::llvm_shutdown();
	return 0;
}
