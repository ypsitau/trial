//===- lli.cpp - LLVM Interpreter / Dynamic compiler ----------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This utility provides a simple wrapper around the LLVM Execution Engines,
// which allow the direct execution of LLVM programs through a Just-In-Time
// compiler, or through an interpreter if no JIT is available for this platform.
//
//===----------------------------------------------------------------------===//

#include "llvm/IR/LLVMContext.h"
//#include "RemoteMemoryManager.h"
//#include "RemoteTarget.h"
//#include "RemoteTargetExternal.h"
#include "llvm/ADT/Triple.h"
#include "llvm/Bitcode/ReaderWriter.h"
#include "llvm/CodeGen/LinkAllCodegenComponents.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/ExecutionEngine/Interpreter.h"
#include "llvm/ExecutionEngine/JITEventListener.h"
#include "llvm/ExecutionEngine/MCJIT.h"
#include "llvm/ExecutionEngine/ObjectCache.h"
#include "llvm/ExecutionEngine/SectionMemoryManager.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/TypeBuilder.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Object/Archive.h"
#include "llvm/Object/ObjectFile.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/DynamicLibrary.h"
#include "llvm/Support/Format.h"
#include "llvm/Support/ManagedStatic.h"
#include "llvm/Support/MathExtras.h"
#include "llvm/Support/Memory.h"
#include "llvm/Support/MemoryBuffer.h"
#include "llvm/Support/PluginLoader.h"
#include "llvm/Support/PrettyStackTrace.h"
#include "llvm/Support/Process.h"
#include "llvm/Support/Program.h"
#include "llvm/Support/Signals.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Instrumentation.h"
#include <cerrno>

#ifdef __CYGWIN__
#include <cygwin/version.h>
#if defined(CYGWIN_VERSION_DLL_MAJOR) && CYGWIN_VERSION_DLL_MAJOR<1007
#define DO_NOTHING_ATEXIT 1
#endif
#endif

using namespace llvm;

#define DEBUG_TYPE "lli"

int main(int argc, char **argv, char * const *envp)
{
	LLVMContext &Context = getGlobalContext();
	InitializeNativeTarget();
	InitializeNativeTargetAsmPrinter();
	InitializeNativeTargetAsmParser();
	//cl::ParseCommandLineOptions(argc, argv,
	//							"llvm interpreter & dynamic compiler\n");
	SMDiagnostic Err;
	std::unique_ptr<Module> Owner = parseIRFile(argv[1], Err, Context);
	Module *Mod = Owner.get();
	if (!Mod) {
		Err.print(argv[0], errs());
		return 1;
	}
	EngineBuilder builder(std::move(Owner));
	std::string ErrorMsg;
	ExecutionEngine *EE = builder.create();
	if (!EE) {
		if (!ErrorMsg.empty())
			errs() << argv[0] << ": error creating EE: " << ErrorMsg << "\n";
		else
			errs() << argv[0] << ": unknown error creating EE!\n";
		exit(1);
	}
	Function *EntryFn = Mod->getFunction("main");
	if (!EntryFn) {
		errs() << '\'' << "main" << "\' function not found in module.\n";
		return -1;
	}
	errno = 0;
	int Result;
    Constant *Exit = Mod->getOrInsertFunction("exit", Type::getVoidTy(Context),
											  Type::getInt32Ty(Context),
											  NULL);
	EE->finalizeObject();

    EE->runStaticConstructorsDestructors(false);
    (void)EE->getPointerToFunction(EntryFn);
	std::vector<std::string> argvSub;
    Result = EE->runFunctionAsMain(EntryFn, argvSub, envp);
    EE->runStaticConstructorsDestructors(true);
	return Result;
}
