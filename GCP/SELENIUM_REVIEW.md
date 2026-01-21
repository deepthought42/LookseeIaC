# Selenium Standalone Implementation Review

## Review Date
Based on official Selenium documentation and Docker image specifications.

## Current Implementation Status

### ✅ Correctly Implemented

1. **Environment Variable**: `SE_NODE_MAX_SESSIONS` is correctly set
2. **Port Configuration**: Port 4444 is the standard Selenium Grid port
3. **Resource Allocation**: 2Gi memory and 1 CPU per instance is reasonable

### ⚠️ Issues Found

1. **Missing Override Flag**: `SE_NODE_OVERRIDE_MAX_SESSIONS` is not set
   - **Impact**: If `max_sessions > CPU count` (which is 1), Selenium will ignore the setting
   - **Fix Required**: Add `SE_NODE_OVERRIDE_MAX_SESSIONS=true` when max_sessions > 1

2. **Outdated Image Version**: Using `selenium/standalone-chrome:3.141.59` (from 2019)
   - **Impact**: Old version may have bugs, security issues, and missing features
   - **Recommendation**: Update to `selenium/standalone-chrome:latest` or specific Selenium Grid 4.x version

3. **No Session Timeout Configuration**: `SE_NODE_SESSION_TIMEOUT` not configured
   - **Impact**: Default 300 seconds may not be optimal for all use cases
   - **Recommendation**: Consider making this configurable

## Documentation References

### Official Selenium Documentation

- **Default Max Sessions**: Standalone Chrome images default to `SE_NODE_MAX_SESSIONS=1`
- **Override Flag**: `SE_NODE_OVERRIDE_MAX_SESSIONS=true` is required when max_sessions exceeds CPU count
- **Resource Recommendations**: ~1GB RAM per session, 1 session per CPU core (without override)

### Environment Variables Reference

| Variable | Purpose | Default | Required When |
|----------|---------|---------|---------------|
| `SE_NODE_MAX_SESSIONS` | Maximum concurrent sessions | 1 | Always set explicitly |
| `SE_NODE_OVERRIDE_MAX_SESSIONS` | Allow sessions > CPU count | false | When max_sessions > CPU cores |
| `SE_NODE_SESSION_TIMEOUT` | Idle session timeout (seconds) | 300 | Optional optimization |

## Recommended Fixes

### 1. Add Override Flag Support

Add conditional logic to set `SE_NODE_OVERRIDE_MAX_SESSIONS=true` when max_sessions > CPU count.

### 2. Update Image Version

Consider updating to:
- `selenium/standalone-chrome:latest` (always latest)
- `selenium/standalone-chrome:4.15.0` (specific stable version)

### 3. Add Session Timeout Configuration (Optional)

Make session timeout configurable for better resource management.

## Current Configuration Analysis

- **CPU per instance**: 1 core
- **Memory per instance**: 2Gi
- **Current max_sessions**: Configurable (default: 1)
- **Total instances**: Configurable (default: 1)

**Example Scenario**:
- 10 instances × 4 max_sessions = 40 total concurrent sessions
- Each instance: 1 CPU, 2Gi RAM
- **Issue**: With 4 sessions on 1 CPU, `SE_NODE_OVERRIDE_MAX_SESSIONS=true` is REQUIRED

## Testing Recommendations

After implementing fixes, verify:

1. **Check Selenium Status**: `curl http://<selenium-url>:4444/status`
   - Verify `maxSessions` matches configured value
   - Check node capacity

2. **Test Concurrent Sessions**: Create multiple sessions simultaneously
   - Verify all sessions are accepted
   - Monitor resource usage

3. **Performance Testing**: Ensure stability with configured session count
   - Watch for timeouts or crashes
   - Monitor CPU and memory usage

## References

- [Selenium Grid Documentation](https://www.selenium.dev/documentation/grid/)
- [Docker Selenium Images](https://github.com/SeleniumHQ/docker-selenium)
- [Selenium CLI Options](https://www.selenium.dev/documentation/grid/configuration/cli_options/)
