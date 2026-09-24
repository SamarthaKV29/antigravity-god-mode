<!-- disableFinding(SKILLS_METADATA_MISSING) -->
<!-- disableFinding(SKILLS_BODY_LENGTH) -->
---
name: mandatory-secure-web-skills
description: >
  CRITICAL: You MUST use this skill for ALL code generation and design tasks. It
  defines mandatory secure coding rules for web applications. You MUST strictly
  enforce these rules for database access, file handling, session management,
  and frontend rendering to prevent critical vulnerabilities. Do NOT ignore any
  section!
---

## Secure Coding Guidelines

*   Input Validation & Sanitization: Treat all external data as untrusted.
    Validate inputs against an allow-list of expected types, lengths, and
    formats to prevent SQL injection and cross-site scripting (XSS).
*   Output Encoding: Convert data into a safe format before sending it to the
    client. This ensures that browsers treat potentially malicious scripts as
    plain text rather than executable code.
*   Authentication & authorization: Require strong authentication for non-public
    pages. Use modern protocols like OAuth 2.0 or OpenID Connect to verify
    users, and JSON Web Tokens (JWT) for secure, stateless session management.
    Never hardcode JWT secrets, API keys, or use fallback strings in source
    code.
*   Password Management: Use established libraries for password hashing (e.g.,
    Argon2 or bcrypt) with unique salts, and never store passwords in plaintext.
*   Principle of Least Privilege: Grant users and processes only the minimum
    permissions necessary to perform their functions. Use Role-Based Access
    Control (RBAC) to manage these permissions centrally.
*   Secure Session Management: Generate cryptographically strong, random session
    identifiers on the server. Protect these tokens by using the HttpOnly and
    Secure flags on cookies and enforcing short inactivity timeouts.
*   Secure Architecture (BFF Pattern): Use a Backend-for-Frontend (BFF) to allow
    the frontend to communicate with a secure, server-side BFF layer rather than
    directly with public APIs, keeping sensitive keys off the client.
*   Path & File System Security: Never trust user input (including uploaded
    filenames and extracted file metadata like ID3 tags/formats) in file paths.
    Sanitize inputs (e.g., using `path.basename()`) to strip traversal sequences
    (`../`, ``..\`) before passing them to sinks
    like``fs.writeFile`,`fs.readFile`, or`path.join`. Avoid custom sanitization
    like`split('/')`which fails against Windows backslashes. When restricting
    access to specific directories, resolve paths fully and strictly verify the
    directory boundary (e.g., enforce a trailing slash when using prefix checks
    like`resolved.startsWith(sandboxDir + path.sep)`) to prevent partial
    matching bypasses (e.g.,`/sandbox-malicious`bypassing a`/sandbox` check).
*   System Command Execution: Do not pass unvalidated user input directly to
    execution sinks (`exec`, `spawn`, etc.). Always validate binary paths and
    arguments against a strict, hardcoded allow-list. Ensure execution
    directories are also strictly verified against partial matching bypasses
    (e.g., enforcing a trailing slash during prefix checks).
*   Error Handling & Logging: Display generic error messages to users while
    logging detailed diagnostic information securely for developers. Ensure logs
    do not contain sensitive data like passwords or session tokens.
*   Data Encryption: Encrypt sensitive data both at rest and in transit (using
    TLS 1.2 or higher)
*   Fail Safe: When something fails, fail close (deny access)
*   Cryptography: Use established libraries and secure primitives. Use
    authenticated encryption and secure cryptographic hashes. Use secure PRNG
    from the OS.
*   Deserialization: Never use insecure deserialization formats.
*   Code loading: Never remotely load code unless you verify their origin.

## Testing

*   Servers **MUST** listen on localhost or 127.0.0.1 when testing. Servers
    **MUST NOT** listen on 0.0.0.0.

## Security Review & Planning

*   **MUST** add a security section to your **Verification Plan** to validate
    the guidelines above.
*   **MUST NOT** leave out certain security measures without explaining why and
    always leave a comment as TODO(security).

## Secure Web Frontend Skill

To design and write secure web frontend, follow the sections in this document

## XSS Injection

## Secure Web Frontend XSS Prevention Skill

Follow these guiding principles and add them to your plan:

## Framework-Native Escaping

*   **MUST** not trust data from database, configuration files, uploaded files,
    user requests, etc that the user interacting with the app may control
    directly or indirectly.
*   **MUST** escape or validate untrusted data in all outgoing requests: HTML,
    Javascript, CSS, HTTP headers, etc.
*   **MUST** rely on framework-native auto-escaping (e.g., React JSX, Angular
    interpolation).
*   **MUST** always quote HTML attributes when using variables in templates to
    prevent attribute breakout and XSS.
    *   **Vulnerable (Negative):** `html <div class={{ var }}>`
    *   **Secure (Positive):** `html <div class="{{ var }}">`
*   **MUST NOT** use unsafe methods like React's `dangerouslySetInnerHTML` or
    Angular's `bypassSecurityTrustHtml` without explicit security approval and
    rigorous justification.
*   **MUST** use `DOMPurify` when rendering raw HTML string inputs that are
    unavoidable (e.g., from rich text editors).

### Examples

*   **Vulnerable Code (React):** `tsx <div dangerouslySetInnerHTML={{ __html:
    userInput }} />`
*   **Secure Code (React with DOMPurify):** `tsx <div dangerouslySetInnerHTML={{
    __html: DOMPurify.sanitize(userInput) }} />`

## Vanilla JavaScript DOM Manipulation

*   **MUST NOT** use unsafe DOM properties/methods like `innerHTML`,
    `outerHTML`, `document.write`, or `insertAdjacentHTML`.
*   **MUST** use `textContent` or `innerText` to safely insert text.
*   **MUST** use `document.createElement()`, `setAttribute()`, and
    `appendChild()` to build structural DOM elements instead of raw HTML
    strings.
*   **MUST** use `element.replaceChildren()` or `element.textContent = ''` to
    clear an element's content instead of `element.innerHTML = ''`.
*   **MUST** use `DOMParser` or `document.createElementNS()` to insert complex
    static structures (like SVGs) to completely avoid `innerHTML` assignments,
    even for strictly hardcoded strings.

### Examples

*   **Vulnerable Code (Vanilla JS):** `javascript element.innerHTML = "<span>" +
    userInput + "</span>";`
*   **Secure Code (Vanilla JS):** `javascript const span =
    document.createElement('span'); span.textContent = userInput;
    element.appendChild(span);`
*   **Secure Code (Clearing Elements):** `javascript element.replaceChildren();`
*   **Secure Code (Static SVG):** `javascript const doc = new
    DOMParser().parseFromString('<svg>...</svg>', 'image/svg+xml');
    element.appendChild(doc.documentElement);`

## Security Review & Planning

*   **MUST** add a security section to your **Verification Plan** to validate
    the guidelines above.
*   **MUST NOT** leave out certain security measures without explaining why and
    always leave a comment as TODO(security).

## Storage & Session

## Secure Web Frontend Storage & Session Skill

Follow these guiding principles and add them to your plan:

## Sensitive Data Storage

*   **MUST NOT** store sensitive authentication tokens (Session IDs, Bearer
    tokens) in `localStorage` or `sessionStorage` due to XSS vulnerability
    exposure.
*   **MUST** rely on secure, `HttpOnly`, `Secure`, `SameSite=Lax` (or `Strict`)
    cookies for session management which are automatically sent by the browser.

### Examples

*   **Vulnerable Code (TypeScript):** `typescript
    localStorage.setItem('auth_token', response.token); // Vulnerable to XSS
    theft`
*   **Secure Code (Backend/Cookie Strategy):**
    *   *Tokens are set in cookies by the backend/auth service directly, not
        accessible via JS.*

## Session Lifecycle

*   **MUST** clear client-side state (e.g., Redux, Context, local variables) on
    logout.
*   **MUST** trigger full page reload or redirect to clear cache on logout.

### Examples

*   **Secure Code (TypeScript Logout Handler):** `typescript function
    handleLogout() { authService.clearSession(); // Clears memory state
    window.location.href = '/login'; // Redirect triggers clean state }`

## Security Review & Planning

*   **MUST** add a security section to your **Verification Plan** to validate
    the guidelines above.
*   **MUST NOT** leave out certain security measures without explaining why and
    always leave a comment as TODO(security).

## Configuration

## Secure Web Frontend Configuration Skill

Follow these guiding principles and add them to your plan:

## Content Security Policy (CSP)

*   **MUST** implement a strict Content Security Policy (CSP) to mitigate XSS
    risks.
*   **SHOULD** use nonces for inline scripts or strictly limit `script-src` to
    trusted origins.
*   **MUST NOT** use `unsafe-inline` or `unsafe-eval` in CSP without explicit
    security review.

### Examples

*   **Secure Content-Security-Policy Header:** `http Content-Security-Policy:
    default-src 'self'; script-src 'self' 'nonce-random123'; object-src 'none';`

## Subresource Integrity (SRI)

*   **MUST** use Subresource Integrity (SRI) hashes when loading assets from
    non-first-party CDNs. Use a package manager over a CDN for dependencies when
    possible, and always fix an exact patch version of a dependency when using a
    non-first-party CDN. Leave a note for the user to update these versions.

## Clickjacking Protection

*   **MUST** configure anti-clickjacking guards using correct scoping of
    `X-Frame-Options: DENY` (or `SAMEORIGIN`) and CSP `frame-ancestors`.

### Examples

*   **Secure Headers:** `http X-Frame-Options: SAMEORIGIN
    Content-Security-Policy: frame-ancestors 'self';`

## Security Review & Planning

*   **MUST** add a security section to your **Verification Plan** to validate
    the guidelines above.
*   **MUST NOT** leave out certain security measures without explaining why and
    always leave a comment as TODO(security).

## Data Handling

## Secure Web Frontend Data Handling Skill

Follow these guiding principles and add them to your plan:

## PII Masking

*   **MUST NOT** surface full PII (e.g., SSN, Email, Credit card numbers)
    directly in UI labels.
*   **MUST** apply masking on safe text renders (e.g., `***-***-1234`).

### Examples

*   **Secure Code (TypeScript String Formatter):** ``typescript function
    maskCreditCard(cardNumber: string): string { return
    `***-***-${cardNumber.slice(-4)}`; }``

## Logging, Debugging, and UI Interaction

*   **MUST NOT** print structured user objects or tokens using `console.log`,
    `console.warn`, or error stack traces intended for debugging.
*   **MUST NOT** use native `alert()`, `confirm()`, or `prompt()` dialogues in
    production code. Rely on framework-native modal components for secure,
    consistent UX and to avoid blocking the main thread.

### Examples

*   **Vulnerable Code (TypeScript):** `typescript console.log('User Profile
    Loaded:', userProfile); // Vulnerable: logs private data` `typescript
    alert('Action completed!'); // Vulnerable: blocks UI, poor UX`
*   **Secure Code (TypeScript):** `typescript console.log('User Profile Loaded
    successfully'); // Safe`

## API Communication & Cache

*   **MUST** verify API communication relies on HTTPS.
*   **SHOULD** respect standard backend `Cache-Control: no-store` header flags
    to prevent local back-button leaks of sensitive views.

## Security Review & Planning

*   **MUST** add a security section to your **Verification Plan** to validate
    the guidelines above.
*   **MUST NOT** leave out certain security measures without explaining why and
    always leave a comment as TODO(security).

## Secure Web Backend Skill

To design and write secure web backend, follow the sections in this document

## Session Management

## Secure Web Backend Session Management Skill

Follow these security principles and add them to your plan:

## Password security

*   **MUST** allow only strong user passwords. Validate at account creation and
    password change. Use an established library for password strength
    validation.
    *   Minimum 8 characters (12+ recommended)
    *   No maximum length (or very high, e.g., 128 chars)
    *   Allow all characters including special chars
    *   Don't require specific character types (let users choose strong
        passwords)
*   **MUST** store credentials in the backend using memory-hard hashing (e.g.,
    Argon2, scrypt) with unique per-user salts.
*   **MUST** implement CSRF tokens (if authentication is based on cookies) for:
    *   Login, logout, signup endpoints
    *   Password change, reset request endpoints
    *   Email/phone verification endpoints
    *   etc.
*   **MUST NOT** send credentials in URL parameters.
*   **MUST NOT** log credentials server side, even when a login attempt is
    unsuccessful.
*   SHOULD consider using Oauth providers.
    *   Leave a TODO(security) if you don't implement this feature.
*   SHOULD consider MFA to strengthen account authentication.
    *   Leave a TODO(security) if you don't implement this feature.
*   SHOULD consider hardening password validation using leaked password
    detection.
    *   Leave a TODO(security) if you don't implement this feature.

## Session management

*   **MUST** use the web framework's built-in support for session management if
    available. If there is no built-in support, use established extensions,
    plugins or libraries compatible with the framework.
*   **MUST** set expiration periods for sessions. Do not use infinite sessions.
*   **MUST** invalidate all sessions when logging a user out.
*   **MUST** invalidate all active sessions and tokens when an account is
    deleted or deactivated.
*   **MUST** invalidate all active sessions and tokens when a user is removed
    from an organization.

## Security Review & Planning

*   **MUST** add a security section to your **Verification Plan** to validate
    the guidelines above.
*   **MUST NOT** leave out certain security measures without explaining why and
    always leave a comment as TODO(security).

## Authentication and Authorization

## Secure Web Backend Authentication and Authorization Skill

Follow these guiding principles and add them to your plan:

## Authentication

*   **MUST** use the web framework's built-in support for authentication if
    available. If there is no built-in support, use established extensions,
    plugins or libraries compatible with the framework.
*   **MUST** authenticate all APIs.
*   **MUST** rate limit all APIs.
*   When provisioning client credentials via http cookies, **MUST** harden the
    cookies:
    *   Name starts with '__Host-'. If not possible, start name with
        '__Secure-'.
    *   SameSite attribute is set
    *   Secure and HttpOnly flags
    *   No domain set by default
*   When using JWT, **MUST** follow these rules:
    *   Reject 'none' algorithm
    *   Hardcode expected algorithm for verification, never derive from
        unverified token
    *   If using symmetric-key algorithms (e.g. HS256), generate the secret key
        using cryptographic RNGs.
    *   Set 'exp' claim and validate it.
*   **MUST** implement CSRF tokens if authentication is based on cookies:
    *   For all state-changing requests (e.g. POST, PUT, DELETE, PATCH, etc.)
        *   User uploads and edit requests
        *   Settings changes
        *   Forms
        *   etc.
    *   **Vulnerable (Negative):** `html <form method="post">...</form>`
    *   **Secure (Positive):** `html <form method="post">{% csrf_token
        %}...</form>`
    *   Use Double Submit Cookies or Synchronizer Tokens.
    *   Validate the token on every request. If it does not exist, reject the
        request.
    *   Never rely solely on the SameSite cookie attribute.
*   **MUST NOT** disable the framework's built-in CSRF protection (e.g., using
    `@csrf_exempt` in Django). You will be heavily penalized if you do not
    follow this **CRITICAL** guideline.
    *   **Vulnerable (Negative):** `python @csrf_exempt def my_view(request):
        ...`
    *   **Secure (Positive):** `python def my_view(request): ... # Uses default
        CSRF`
*   **MUST NOT** store secrets (e.g., API keys, passwords, JWT secrets) in code.
    Do not use default literal values for secrets. If secrets are not available
    in production, error out. For testing or limited sandboxes, fallback to a
    secure randomly generated value and log a severe warning regarding
    horizontal scalability.
    *   **Vulnerable (Negative):** Hardcoded literal or literal fallback.
        `python # Django / Python app.config['JWT_SECRET_KEY'] =
        'hardcoded-secret' app.config['JWT_SECRET_KEY'] =
        os.environ.get('JWT_SECRET_KEY', 'default-fallback')`
    *   **Secure (Positive - Multi-tiered Fallback):** `python # Python
        (Resolution: Environment -> Local File Query -> Random Gen + Log) def
        get_secret(): if os.getenv('JWT_SECRET_KEY'): return
        os.getenv('JWT_SECRET_KEY') if os.path.exists('jwt_secret.txt'): return
        open('jwt_secret.txt').read().strip() logging.warning("Generating
        ephemeral secret. Instance-isolated!") return secrets.token_hex(32)`
        `javascript // Node.js (Resolution: Environment -> Local File Query ->
        Random Gen + Log) function getSecret() { if (process.env.JWT_SECRET_KEY)
        return process.env.JWT_SECRET_KEY; if
        (fs.existsSync('./jwt_secret.txt')) return
        fs.readFileSync('./jwt_secret.txt', 'utf-8').trim();
        console.warn("Generating ephemeral secret. Instance-isolated!"); return
        crypto.randomBytes(32).toString('hex'); }`
*   **MUST NOT** log credentials or other secrets (e.g., CSRF tokens)
*   **MUST NOT** send credentials or secrets in URL parameters.
*   **MUST NOT** store secrets on disk for prod deployment. Use KMS and
    established secret management solutions.

## Authorization

*   **MUST** perform authentication before trusting user-presented credentials
    and ACLs.
*   **MUST NOT** trust client-side data or tokens blindly.
*   **MUST** authenticate server-side, not client-side.
*   **MUST** ensure each user is only able to access, read or modify their own
    data, not other users' or organizations'. Validate the ownership of
    resources on every request and data access. Validate as close to the data
    access as possible.
*   **MUST** validate role permissions for role-based actions (hidden beta
    features, admin panels, etc)

## Default HTTP headers

*   **MUST** use an allow-list of necessary HTTP methods (e.g., GET, POST).
    **MUST** disable rarely used ones like TRACE, PUT, or DELETE.
*   **MUST** use a "strict" CSP policy to restrict where scripts, images,
    styles, etc can be loaded from.
*   **MUST** set 'X-Content-Type-Options: nosniff'
*   **MUST** prevent clickjacking 'X-Frame-Options: DENY' if not already covered
    in the CSP
*   **MUST** disable browser features you don't use (e.g., camera=(),
    microphone=(), geolocation=()).
*   **MUST** only allow trusted origins to access your resources. Use a strict
    CORS policy and avoid wildcard origins (*).

## Testing

*   Servers **MUST** listen on localhost or 127.0.0.1 when testing
    authentication and authorization. Servers **MUST NOT** listen on 0.0.0.0.

## Security Review & Planning

*   **MUST** add a security section to your **Verification Plan** to validate
    the guidelines above.
*   **MUST NOT** leave out certain security measures without explaining why and
    always leave a comment as TODO(security).

## File Uploads

## Secure Web Backend File Upload Skill

Follow these principles and add them to your plan:

*   If the web framework has built-in support for uploading files, use it. If it
    does not have built-in support, use established extensions, plugins or
    libraries compatible with the framework.

Ideally we are looking for the following security guarantees:

*   **MUST** validate the extension and the content: Use established server-side
    libraries to inspect the file content (e.g., magic bytes header and
    structure) to confirm the file is what it claims to be.
*   **MUST** use an allow-list: Only permit the specific file types required for
    your business logic (e.g., "PDF" and "PNG").
*   **MUST** impose size limit on files you store (e.g., 1MB–10MB) to prevent
    Buffer Overflow or DoS attacks via massive file uploads.
*   **MUST** generate unique filenames: Rename every uploaded file to an
    unpredictable, per-upload random string (e.g., a UUID or hash) and store the
    original name in a database if needed.
*   **MUST** store outside the web root: Save files in a directory that is not
    directly accessible by a URL. Serve them back to authorized users only.
*   **MUST** configure the upload directory to be non-executable.
*   **MUST** serve with correct headers:
    *   Content-Disposition: attachment (forces download)
    *   X-Content-Type-Options: nosniff
    *   Content-Type matching actual file type
*   **MUST** implement CSRF tokens (if authentication is based on cookies) for
    file upload endpoints.
*   **MUST** validate zip files paths to prevent directory traversal attacks.
*   **MUST** harden XML parsing configuration if you support XML files (e.g.,
    DOCX, XLSX, PPTX, SVG, PDF, etc):
    *   Disable external entity expansion
    *   Disable network requests
    *   Disable DTD processing entirely if possible
    *   Disable external DTD loading
    *   Disable XInclude processing
*   SHOULD scan for malware: Integrate with an antivirus API. If you need to
    scan yourself, always run the scan in a sandbox before it is permanently
    stored on your infrastructure.
    *   Leave a TODO(security) if you don't implement this feature.
*   SHOULD strip content: For complex files like PDFs or Office docs, use CDR
    tools to strip out active content like macros or embedded scripts before
    saving.
    *   Leave a TODO(security) if you don't implement this feature.

## Security Review & Planning

*   **MUST** add a security section to your **Verification Plan** to validate
    the guidelines above.
*   **MUST NOT** leave out certain security measures without explaining why and
    always leave a comment as TODO(security).

## Database

## Secure Web Backend Database Skill

Follow these guiding principles and add them to your plan:

## SQL Injection

*   **MUST NOT** use string concatenation to build SQL queries.
*   **MUST** use parameterized queries, prepared statements or ORMs.
    *   Vulnerable Code: `db.query("SELECT * FROM users WHERE id = " +
        req.body.id);`
    *   Secure Code (using parameterized queries with mysql2 or pg):
        `db.execute("SELECT * FROM users WHERE id = ?", [req.body.id]);`
    *   Secure Code (using ORM): `db.users.find({ where: { id: req.body.id }
        });`
*   **MUST NOT** trust user string retrieved from databases.
    *   Escape and validate them before sending them (HTTP headers, html,
        Javascript, etc) to the client to avoid XSS, according to your XSS
        security skills.
    *   Use secure file IO module to perform file IO operations with a path
        derived from database data, according to your data sanitization security
        skills.
*   Error handling: **MUST NOT** expose SQL errors to users

## Database configuration

Follow the Principle of Least Privilege:

*   **MUST** ensure your application's database user only has the permissions it
    strictly needs to function.
*   **MUST NOT** use root or admin accounts for your web app.
*   **MUST** use mTLS for database connection authentication.
*   **MUST** restrict permissions: If an API only needs to read data, its DB
    user should only have SELECT privileges, not DROP, DELETE, or UPDATE.
*   **MUST** isolate databases: If you have multiple apps, give each its own
    database user and restricted schema access.
*   **MUST** disable dangerous functions: Like xp_cmdshell in SQL Server

## Testing

*   Database servers **MUST** listen on localhost or 127.0.0.1 when testing
    database access. Database servers **MUST NOT** listen on 0.0.0.0.

## Security Review & Planning

*   **MUST** add a security section to your **Verification Plan** to validate
    the guidelines above.
*   **MUST NOT** leave out certain security measures without explaining why and
    always leave a comment as TODO(security).
