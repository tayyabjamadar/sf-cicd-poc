# Salesforce PR Checks & Merge Gates

## Code Quality Checks

### 1. Static Code Analysis
- **ApexPMD** - Apex code quality rules (complexity, naming, performance)
- **ESLint** - JavaScript/LWC validation
- **Prettier** - Code formatting consistency

### 2. Security Scans
- **SFDX Scanner** - Salesforce-specific security issues
- **Dependency scanning** - npm package vulnerabilities
- **Secret detection** - prevent hardcoded credentials

### 3. Code Coverage
- **Apex test coverage** - minimum 75% (Salesforce requirement for production)
- **LWC test coverage** - Jest coverage thresholds
- **Overall coverage reports**

## Salesforce-Specific Checks

### 4. Org Validation
- Deploy to scratch org
- Run Apex tests
- Verify no breaking changes
- Check for API compatibility

### 5. Metadata Validation
- No duplicate metadata
- Valid XML schema
- Permission set/profile alignment
- Custom field references valid

### 6. Data Migration Safety
- Schema changes backward compatible
- Data type conversions validated
- No data loss scenarios

## Deployment Gates

### 7. Manual Approvals
- Code review approval (1-2 reviewers)
- Security team approval (if touching auth/permissions)
- Release manager sign-off (for main branch)

### 8. Integration Tests
- End-to-end test suite
- Salesforce-specific connectors tested
- External API integrations validated

## Full Gate Configuration

```
Required checks to merge:
├─ validate (pr-validate workflow)
├─ code-quality
│  ├─ apexPMD
│  ├─ eslint
│  └─ prettier
├─ security
│  ├─ sfScanner
│  ├─ dependencyCheck
│  └─ secretDetection
├─ coverage
│  ├─ apexTestCoverage (75%+)
│  └─ lwcTestCoverage (80%+)
├─ deployability
│  ├─ scratchOrgDeploy
│  └─ metadataValidation
└─ approvals
   ├─ 1 code review
   └─ security approval (conditional)
```

## Implementation Phases

### Phase 1 (MVP - Current)
- ✅ Scratch org deployment
- ✅ Apex tests

### Phase 2 (Recommended)
- Code coverage thresholds
- ApexPMD static analysis
- ESLint for LWC/JavaScript
- 1 code review approval

### Phase 3 (Advanced)
- Security scanning
- Dependency checks
- Data migration validation
- Multi-environment testing

## Configuration Examples

### Apex Test Coverage Gate
Minimum 75% code coverage required for production deployment per Salesforce standards.

### Static Analysis Gates
Run ApexPMD and ESLint to catch code quality issues before review.

### Security Gates
Scan for hardcoded credentials, insecure API calls, and dependency vulnerabilities.
