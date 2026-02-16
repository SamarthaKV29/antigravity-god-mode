---
description: Double checks everything again.
---

## Phase 1: Static Connectivity Trace (The Thread Pull)
*Goal: Trace the execution path from entry point to leaf nodes to ensure every component is reachable, instantiated correctly, and wired up.*

### 1.1 Entry Point Verification
- [ ] **Open `src/main.py`** (or defined entry script).
- [ ] **Verify Imports:** Ensure all imports resolve to existing files.
- [ ] **App Initialization:** Confirm `QApplication` is instantiated once.
- [ ] **Root Window:** Confirm `MainWindow` is instantiated and `.show()` is called.
- [ ] **Bootstrap Logic:** Verify that global styles (Theme), configuration loaders (`SettingsManager`), and logging are initialized *before* the UI loads.

### 1.2 UI Hierarchy & Routing Trace
*Trace the parent-child chain.*
- [ ] **MainWindow Composition:**
    - Check central widget initialization.
    - Verify `QStackedWidget` (or main layout) exists for view routing.
- [ ] **Navigation Wiring:**
    - **Source:** Go to `SessionSidebar` (or navigation control).
    - **Signal:** Find the signal emitted on selection (e.g., `sessionChanged`, `viewChanged`).
    - **Connection:** Trace where this signal connects in `MainWindow`.
    - **Target:** Ensure the slot correctly changes the `QStackedWidget` index or instantiates the new View.
- [ ] **View Instantiation:**
    - For every View (e.g., `LipSyncView`, `AudioToVideoView`, `SceneRowWidget`):
        - Check `__init__` arguments. Are dependencies (like `FalApiService` or `JobQueueManager`) passed correctly?
        - **Orphan Check:** Are there Views defined in `src/ui/views/` that are never imported or added to the stack?

### 1.3 Signal/Slot Integrity (PySide6 Specific)
*Prevent silent failures and memory leaks.*
- [ ] **Lambda Search:** Search codebase for `.connect(lambda`.
    - **Risk:** Lambdas connected to signals can be garbage collected if not stored, or cause memory leaks if they capture `self` without proper lifecycle management.
    - **Action:** Ensure complex lambdas use a wrapper (e.g., `CallableSlotAdapter`) or that the connection ownership is clear.
- [ ] **Bound Method Check:** Ensure connections to methods like `self.on_click` are not overwriting previous connections unexpectedly.
- [ ] **Signature Match:** Verify that emitted Signal arguments match the connected Slot arguments. (e.g., Signal emits `str`, Slot expects `int` -> **Fix**).

---

## Phase 2: Logic & Service Integration
*Goal: Weed out unused methods and ensure services are actually used.*

### 2.1 Service Injection
- [ ] **Singleton/Instance Check:**
    - Trace `FalApiService`, `JobQueueManager`, `StateManager`.
    - Are they instantiated in `main.py` or `MainWindow`?
    - Are references passed down to children? (e.g., Does `LipSyncView` get the *same* `JobQueueManager` instance as the `QueueSidebar`?)
- [ ] **Method Usage Audit:**
    - For each public method in a Service:
        - **Right Click -> Find Usages**.
        - **Zero Usages?** If it is not a required interface override, **Mark for Deletion**.
        - **Duplicate Declarations?** Check if two services perform nearly identical logic (e.g., two different audio trimming functions). Consolidate into `FFmpegService`.

### 2.2 Data Model Consistency
- [ ] **JSON Serialization:**
    - Check `SessionModel.to_dict()` and `from_dict()`.
    - **Round Trip Test:** Ensure every field saved in `to_dict` is actually restored in `from_dict`.
    - **Drift Check:** Are there fields in the Model class (e.g., `last_prompt`) that are missing from the serialization logic?

---

## Phase 3: Test Coverage Audit
*Goal: Ensure critical paths have safety nets. (Skip if `tests/` folder is empty, but flag as Technical Debt).*

### 3.1 Critical Path Mapping
- [ ] **Identify Critical Methods:**
    - `FalApiService.submit()` (Cost/External Dependency)
    - `JobQueueManager.add_job()` (Core Loop)
    - `StateManager.save_session()` (Data Loss Prevention)
- [ ] **Verify Test Existence:**
    - Go to `tests/`. Look for corresponding test files.
    - **Coverage Check:** Do these tests assert the *result* or just run the method? Ensure assertions exist (e.g., `assert file_exists`, `assert queue.length == 1`).

### 3.2 TDD & Bug Reproduction
- [ ] **Regressions:** If this verification is run due to a bug report, is there a new test case that reproduces that bug?

---

## Phase 4: Documentation Synchronicity
*Goal: Ensure the map matches the territory.*

### 4.1 Root Level Docs
- [ ] **README.md:**
    - **Features List:** Does the README claim features that were removed or not yet implemented?
    - **Installation:** Run the "Quick Start" commands in a fresh terminal/environment. Do they work exactly as written?
- [ ] **Architecture.md:**
    - **Component Diagram:** Does the listed file structure match the actual `src/` tree?
    - **Tech Stack:** Are versions (e.g., Python 3.12, PySide6) accurate?

### 4.2 Code-Doc Parity
- [ ] **Docstrings:** Check complex methods (especially in `src/services`). Do the docstrings match the arguments? (e.g., if an arg was renamed from `url` to `path`, was the docstring updated?)

---

## Phase 5: Cleanup & Final Polish
*Goal: Leave the campsite cleaner than you found it.*

### 5.1 Dead Code Removal
- [ ] **Imports:** Run an optimize imports command (or linter like `ruff`/`pylint`) to remove unused imports.
- [ ] **Commented Out Code:** Search for blocks of commented-out code. If they are obsolete, delete them. Use Git history if retrieval is needed later.
- [ ] **TODOs:** Scan for `# TODO`. Are they still relevant? If minor, fix now. If major, ensure they are tracked in the project management tool.

### 5.2 Naming Conventions
- [ ] **Consistency:** Ensure file names match conventions (e.g., `snake_case.py`).
- [ ] **Class Names:** Ensure `PascalCase` for classes.
- [ ] **Variables:** Ensure `snake_case` for variables and functions.

## Sign-off
*   [ ] All critical paths traced.
*   [ ] Unused code removed.
*   [ ] Tests pass (if applicable).
*   [ ] Documentation updated.