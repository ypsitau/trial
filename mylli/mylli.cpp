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
#include <iostream>

int main(int argc, char *argv[])
{
	if (argc < 2) {
		::fprintf(stderr, "");
		::exit(1);
	}
	const char *fileName = argv[1];
	llvm::LLVMContext &context = llvm::getGlobalContext();
	llvm::SMDiagnostic err;
	std::unique_ptr<llvm::Module> pModule(llvm::parseIRFile(fileName, err, context));
	if (pModule == nullptr) {
		err.print(argv[0], llvm::outs());
		::exit(1);
	}
	llvm::cl::opt<std::string>
		EntryFunc("entry-function",
				  llvm::cl::desc("Specify the entry function (default = 'main') "
								 "of the executable"),
				  llvm::cl::value_desc("function"),
				  llvm::cl::init("main"));
	llvm::Function *pFunction = pModule->getFunction(EntryFunc);
	llvm::EngineBuilder builder(std::move(pModule));

	llvm::cl::opt<std::string> MArch("march",
									 llvm::cl::desc("Architecture to generate assembly for (see --version)"));
	
	llvm::cl::opt<std::string>
		MCPU("mcpu",
			 llvm::cl::desc("Target a specific cpu type (-mcpu=help for details)"),
			 llvm::cl::value_desc("cpu-name"),
			 llvm::cl::init(""));
	
	llvm::cl::list<std::string>
		MAttrs("mattr",
			   llvm::cl::CommaSeparated,
			   llvm::cl::desc("Target specific attributes (-mattr=help for details)"),
			   llvm::cl::value_desc("a1,+a2,-a3,..."));
	
	llvm::cl::opt<llvm::Reloc::Model>
		RelocModel("relocation-model",
				   llvm::cl::desc("Choose relocation model"),
				   llvm::cl::init(llvm::Reloc::Default),
				   llvm::cl::values(
					   clEnumValN(llvm::Reloc::Default, "default",
								  "Target default relocation model"),
					   clEnumValN(llvm::Reloc::Static, "static",
								  "Non-relocatable code"),
					   clEnumValN(llvm::Reloc::PIC_, "pic",
								  "Fully relocatable, position independent code"),
					   clEnumValN(llvm::Reloc::DynamicNoPIC, "dynamic-no-pic",
								  "Relocatable external references, non-relocatable code"),
					   clEnumValEnd));
	
	llvm::cl::opt<llvm::CodeModel::Model>
		CMModel("code-model",
				llvm::cl::desc("Choose code model"),
				llvm::cl::init(llvm::CodeModel::JITDefault),
				llvm::cl::values(clEnumValN(llvm::CodeModel::JITDefault, "default",
											"Target default JIT code model"),
								 clEnumValN(llvm::CodeModel::Small, "small",
											"Small code model"),
								 clEnumValN(llvm::CodeModel::Kernel, "kernel",
											"Kernel code model"),
								 clEnumValN(llvm::CodeModel::Medium, "medium",
											"Medium code model"),
								 clEnumValN(llvm::CodeModel::Large, "large",
											"Large code model"),
								 clEnumValEnd));
	
	builder.setMArch(MArch);
	builder.setMCPU(MCPU);
	builder.setMAttrs(MAttrs);
	builder.setRelocationModel(RelocModel);
	builder.setCodeModel(CMModel);
	builder.setEngineKind(llvm::EngineKind::Interpreter); // EngineKind::JIT


	std::string errorStr;
	builder.setErrorStr(&errorStr);
	std::unique_ptr<llvm::ExecutionEngine> pExecutionEngine(builder.create());
	if (pExecutionEngine == nullptr) {
		if (!errorStr.empty())
			llvm::errs() << argv[0] << ": error creating EE: " << errorStr << "\n";
		else
			llvm::errs() << argv[0] << ": unknown error creating EE!\n";
		exit(1);
	}
	std::vector<std::string> argvSub;

	pExecutionEngine->DisableLazyCompilation(true);
	pExecutionEngine->RegisterJITEventListener(
		llvm::JITEventListener::createOProfileJITEventListener());
	pExecutionEngine->RegisterJITEventListener(
		llvm::JITEventListener::createIntelJITEventListener());

    int result = pExecutionEngine->runFunctionAsMain(pFunction, argvSub, nullptr);
	return 0;
}
