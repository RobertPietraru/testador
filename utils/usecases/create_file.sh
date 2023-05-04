
# echo  "import 'package:dartz/dartz.dart'; import 'package:testador/features/domain/repositories/test_repository.dart'; class ${2} extends UseCase<Result, ${2}Params> { const ${2}(this.testRepository); final TestRepository testRepository; @override Future<Either<TestFailure, Result>> call(params) async { return testRepository.${3}(params); } } class ${2}Params extends Params { const ${2}Params(); }" > $1

echo " import '../failures/test_failures.dart'; import 'package:dartz/dartz.dart'; import '../../../../core/classes/usecase.dart'; import '../repositories/test_repository.dart'; class ${2}Usecase extends UseCase<${2}UsecaseResult, ${2}UsecaseParams> { const ${2}Usecase(this.testRepository); final TestRepository testRepository; @override Future<Either<TestFailure, ${2}UsecaseResult>> call(params) async { return testRepository.${3}(params); } } class ${2}UsecaseParams extends Params { const ${2}UsecaseParams(); } class ${2}UsecaseResult extends Response { const ${2}UsecaseResult(); }"> $1