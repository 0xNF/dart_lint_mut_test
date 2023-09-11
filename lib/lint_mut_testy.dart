// ignore_for_file: avoid_single_cascade_in_expression_statements

int globalScopeVar = 0;

abstract class ForOveridding {
  void doSomeThing();
}

// FYI(nf, 09/08/23): Shouldn't be marked, because it is `main`
void main() {
  globalScopeVar = 3;
}

class BagB extends ForOveridding {
  String s = "";

// FYI(nf, 09/08/23): Shouldn't me marked, because it is `@override`
  @override
  void doSomeThing() {
    globalScopeVar = 3;
  }
}

class BagA {
  int i = 0;
  BagB b = BagB();

  // expect_lint: mut_out_of_scope
  void shouldMarkInBagA() {
    globalScopeVar = 1;
  }
}

// FYI(nf, 09/08/23): This should not be marked for any errors because it modifies nothing and calls no mut functions
void isInconsequential() {}

// FYI(nf, 09/08/23): This should say it needs to be named `Mut`
// expect_lint: mut_infect
void isNotMarked() {
  isMarkedMut();
}

// FYI(nf, 09/08/23): Should not be marked for errors because its marked mut
void isMarkedMut() {}

// FYI(nf, 09/08/23): Should be marked for Mut because it mutates an out of scope
// expect_lint: mut_out_of_scope
void mutsGlobalScope() {
  globalScopeVar = 2;
}

void mutsGlobalScopeMut() {
  globalScopeVar = 3;
}

// FYI(nf, 09/08/23): Should NOT be marked for errors because the variable is entirely within the function scope
void mutsInnerScope() {
  int i = 0;
  void inner() {
    i = 2;
  }

  print(i);

  inner();
}

// FYI(nf, 09/08/23): should be marked Mut for modifying outer scope
void mutsOuterScope() {
  int i = -1;

  // expect_lint: mut_out_of_scope
  void inner() {
    globalScopeVar = 4;
  }

  print(i);

  inner();
}

void mutsOuterScopeMut() {
  int i = 0;

  void innerMut() {
    globalScopeVar = 5;
  }

  print(i);

  innerMut();
}

// FYI(nf, 09/08/23): Should NOT be marked for errors because the variable is entirely within the function scope
void doesNotMutAnything() {
  void inner() {}

  inner();
}

// FYI(nf, 09/08/23): Should mark a as mut, simple
// expect_lint: mut_param
void markThisToo(BagA a) {
  a.i = 1;
}

void dontMarkThisToo(BagA aMut) {
  aMut.i = 1;
}

// expect_lint: mut_param
void markThisTooMut(BagA a) {
  a.i = 2;
}

void dontMarkThisTooMut(BagA aMut) {
  aMut.i = 2;
}

// expect_lint: mut_out_of_scope, mut_param
void markThisToo2(BagA a) {
  a..b.s = "lol";
}

// expect_lint: mut_out_of_scope
void dontMarkThisToo2(BagA aMut) {
  aMut..b.s = "lol";
}

// expect_lint: mut_param
void markThisToo3Mut(BagA b) {
  b
    ..b.s = "lmao"
    ..i = 3;
}

void dontMarkThisToo3Mut(BagA bMut) {
  bMut
    ..b.s = "lmao"
    ..i = 2;
}

// expect_lint: mut_param
void markThistoo3(int i, {required int i2}) {
  i2 = 3;
}

void dontMarkThistoo3(int i, {required int i2Mut}) {
  i2Mut = 3;
}

// expect_lint: mut_param
void markThistoo4(int i, {int i2 = 45}) {
  i2 = 4;
}

void dontMarkThistoo4(int i, {int i2Mut = 45}) {
  i2Mut = 4;
}

// expect_lint: mut_param
void markThistoo5(int i, [int i3 = 0]) {
  i3 = 4;
}

void dontMarkThistoo5(int i, [int i3Mut = 0]) {
  i3Mut = 4;
}

void dummyMut() {}

// expect_lint: mut_infect
void markThisDummy() {
  dummyMut();
}

void dontMarkThisDummyMut() {
  dummyMut();
}
