#include "llvm/IR/LLVMContext.h"
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

int main(int argc, char **argv, char * const *envp)
{
	llvm::SMDiagnostic err;
	std::unique_ptr<llvm::Module>
		pModule(llvm::parseIRFile(argv[1], err, llvm::getGlobalContext()));
	if (pModule == nullptr) {
		::fprintf(stderr, "error while createing module\n");
		::exit(1);
	}
	llvm::InitializeNativeTarget();
	llvm::InitializeNativeTargetAsmPrinter();
	llvm::InitializeNativeTargetAsmParser();
	llvm::EngineBuilder engineBuilder(std::move(pModule));
	std::string errStr;
	engineBuilder.setMArch("");
	engineBuilder.setMCPU("");
	std::vector<std::string> attrs;
	engineBuilder.setMAttrs(attrs);
	engineBuilder.setRelocationModel(llvm::Reloc::Default);
	engineBuilder.setCodeModel(llvm::CodeModel::JITDefault);
	engineBuilder.setErrorStr(&errStr);
	//engineBuilder.setEngineKind(llvm::EngineKind::Interpreter);
	engineBuilder.setEngineKind(llvm::EngineKind::JIT);
	llvm::ExecutionEngine *pExecutionEngine = engineBuilder.create();
	if (pExecutionEngine == nullptr) {
		::fprintf(stderr, "error while building execution engine\n");
		::exit(1);
	}
#if 0
	do {
		llvm::ErrorOr<llvm::object::OwningBinary<llvm::object::ObjectFile>>
			pObjectFile(llvm::object::ObjectFile::createObjectFile("sub.o"));
		if (pObjectFile.getError()) {
			::fprintf(stderr, "failed to load object file\n");
			::exit(1);
		}
		pExecutionEngine->addObjectFile(std::move(pObjectFile.get()));
	} while (0);
#endif
	pExecutionEngine->finalizeObject();
    pExecutionEngine->runStaticConstructorsDestructors(false);
	int result = 0;
	llvm::Function *pFunction = pExecutionEngine->FindFunctionNamed("main");
	if (pFunction == nullptr) {
		::fprintf(stderr, "failed to find function main\n");
		::exit(1);
	}
#if 0
	do {
		// ExecutionEngine::runFunctionAsMain() executes getPointerToFunction internally.
		std::vector<std::string> argvSub;
		result = pExecutionEngine->runFunctionAsMain(pFunction, argvSub, envp);
	} while (0);
#else
	do {
		int (*func)() = reinterpret_cast<int (*)()>(pExecutionEngine->getPointerToFunction(pFunction));
		result = func();
	} while (0);
#endif
    pExecutionEngine->runStaticConstructorsDestructors(true);
	return result;
}

extern "C" int func_mylli()
{
	::printf("message from mylli\n");
	return 0;
}
