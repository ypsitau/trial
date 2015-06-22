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
  
	// Create some module to put our function into it.
	std::unique_ptr<llvm::Module> pModule = llvm::make_unique<llvm::Module>("test", context);

	do {
		llvm::Function *pFunction = llvm::cast<llvm::Function>(
			pModule->getOrInsertFunction(
				"add1",
				llvm::Type::getInt32Ty(context),
				llvm::Type::getInt32Ty(context),
				(llvm::Type *)0));
		llvm::BasicBlock *pBasicBlock = llvm::BasicBlock::Create(context, "EntryBlock", pFunction);
		llvm::IRBuilder<> builder(pBasicBlock);
		
		assert(pFunction->arg_begin() != pFunction->arg_end()); // Make sure there's an arg
		llvm::Argument *pArgument = pFunction->arg_begin();  // Get the arg
		pArgument->setName("AnArg");
		// Create the add instruction, inserting it into the end of pBasicBlock.
		llvm::Value *Add = builder.CreateAdd(builder.getInt32(1), pArgument);
		// Create the return instruction and add it to the basic block
		builder.CreateRet(Add);
	} while (0);

	llvm::Function *FooF =
		llvm::cast<llvm::Function>(pModule->getOrInsertFunction("foo", llvm::Type::getInt32Ty(context),
													(llvm::Type *)0));

	// Add a basic block to the FooF function.
	llvm::BasicBlock *pBasicBlock = llvm::BasicBlock::Create(context, "EntryBlock", FooF);

	llvm::IRBuilder<> builder(pBasicBlock);

	// Get pointer to the constant `10'.
	llvm::Value *Ten = builder.getInt32(10);

	// Pass Ten to the call to Add1F
	llvm::CallInst *pCallInst = builder.CreateCall(pModule->getFunction("add1"), Ten);
	pCallInst->setTailCall(true);

	// Create the return instruction and add it to the basic block.
	builder.CreateRet(pCallInst);

	llvm::outs() << "We just constructed this LLVM module:\n\n" << *pModule;
	llvm::outs() << "\n\nRunning foo: ";
	llvm::outs().flush();

	// Now we create the JIT.
	llvm::ExecutionEngine *pExecutionEngine = llvm::EngineBuilder(std::move(pModule)).create();

	// Call the `foo' function with no arguments:
	std::vector<llvm::GenericValue> noargs;
	llvm::GenericValue gv = pExecutionEngine->runFunction(FooF, noargs);

	// Import result of execution:
	llvm::outs() << "Result: " << gv.IntVal << "\n";
	delete pExecutionEngine;
	llvm::llvm_shutdown();
	return 0;
}
