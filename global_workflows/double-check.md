---
description: Double checks everything again.
---

# AI Agent Verification Protocol: Correctness, Quality & Consistency

## Phase 1: Structural Integrity & Dependency Trace (The Thread Pull)
*Goal: Trace the execution path from the entry point to the deepest logic nodes to ensure every component is reachable, correctly instantiated, and wired.*

### 1.1 Entry Point Verification
- [ ] **Identify Entry Point:** Open the main entry script (e.g., `main.py`, `index.ts`, `app.go`).
- [ ] **Import Resolution:** Verify that all imports/dependencies resolve to existing files or valid packages.
- [ ] **Initialization Sequence:** Confirm that global configurations (environment variables, settings, logging, themes) are initialized *before* any core logic or UI loads.
- [ ] **Bootstrap Logic:** Ensure the primary application class or function is instantiated once and executed correctly.

### 1.2 System Hierarchy & Routing Trace
- [ ] **Component Composition:** Check the initialization of the central layout or main routing mechanism.
- [ ] **Navigation/Routing Wiring:**
    - **Source:** Identify the trigger for a state change or navigation (e.g., a button click, API route, or menu selection).
    - **Signal/Event:** Find the event emitted or the function called.
    - **Connection:** Trace where this signal/event is handled.
    - **Target:** Ensure the handler correctly updates the state, changes the view, or returns the expected resource.
- [ ] **Dependency Injection:**
    - For every major component or view: Verify that its constructor arguments (services, managers, database handles) are passed correctly.
    - **Orphan Check:** Identify files or components defined in the project structure that are never imported or utilized.

### 1.3 Event & Callback Integrity
- [ ] **Callback Lifecycle:** Search for anonymous functions (lambdas, arrow functions) used as callbacks.
    - **Risk:** Ensure they don't capture scope in a way that causes memory leaks or unexpected behavior during garbage collection.
- [ ] **Signature Matching:** Verify that the arguments emitted by a signal or event match the arguments expected by the connected receiver/handler.
- [ ] **Redundant Connections:** Ensure handlers are not being attached multiple times, which could lead to duplicate executions of a single event.

---

## Phase 2: Logic & Service Integration
*Goal: Eliminate dead code and ensure services are unified and properly utilized.*

### 2.1 Service Audit
- [ ] **Singleton/Instance Consistency:** Trace core services (API clients, State Managers, Auth providers). Are they shared correctly across the application, or are they being redundantally re-instantiated?
- [ ] **Method Usage Check:** For every public method in a service/manager:
    - **Usage Count:** If a method has zero usages and isn't part of a required interface, **delete it**.
    - **Logic Duplication:** Check for near-identical functions in different files (e.g., two different string formatters). Consolidate into a single utility service.

### 2.2 Data Model & Serialization
- [ ] **Round-Trip Integrity:** If using serialization (JSON, Protobuf, etc.), verify that a model's `to_data()` and `from_data()` methods are perfectly symmetrical.
- [ ] **Schema Drift:** Check if new fields added to a class/model were also added to the persistence logic, UI displays, and validation schemas.

---

## Phase 3: Safety & Test Audit
*Goal: Ensure critical paths have safety nets and bug-fixes are permanent.*

### 3.1 Critical Path Coverage
- [ ] **Identify Critical Methods:** Locate functions involving external dependencies (APIs, DB writes), cost (Cloud usage), or data loss prevention.
- [ ] **Assertion Check:** Verify that existing tests for these paths actually perform assertions (e.g., `expect(result).toBe(x)`) rather than just running the code without checking the output.

### 3.2 Regression Verification
- [ ] **Bug Reproduction:** If this task was a bug fix, verify there is a test case that would fail if the fix were reverted.

---

## Phase 4: Documentation & Environment Sync
*Goal: Ensure the project documentation reflects the current state of the code.*

### 4.1 Root Level Docs
- [ ] **README Accuracy:** Do the "Features" and "Quick Start" sections match the current codebase?
- [ ] **Environment Setup:** Verify that new dependencies or environment variables are added to `.env.example` or the installation instructions.
- [ ] **Architecture Sync:** Ensure any high-level diagrams or descriptions of the file structure match the actual `src/` tree.

### 4.2 Code-Doc Parity
- [ ] **Docstrings & Types:** Verify that docstrings and type hints match the actual function signatures. (e.g., If a return type changed from `String` to `Object`, update the docs).

---

## Phase 5: Final Polish & Cleanup
*Goal: Leave the codebase cleaner than it was found.*

### 5.1 Dead Code Removal
- [ ] **Imports:** Run a linter or "optimize imports" command to remove unused imports.
- [ ] **Comments:** Delete obsolete blocks of commented-out code. (Rely on Git for history).
- [ ] **TODOs:** Scan for `# TODO`. Address minor ones immediately; ensure major ones are tracked.

### 5.2 Naming & Style Consistency
- [ ] **Naming Conventions:** Ensure strict adherence to language-specific standards (e.g., `snake_case` for Python, `camelCase` for JS).
- [ ] **File Names:** Ensure file names match the class they contain or the project's casing convention.

## Sign-off
- [ ] Execution paths traced.
- [ ] Redundant/Unused logic removed.
- [ ] Documentation reflects current state.
- [ ] Styling and naming are consistent.