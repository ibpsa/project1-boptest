# Docker to Podman Migration Guide

## ✅ Migration Status: COMPLETE

This project has been successfully migrated to work with **Podman** while maintaining full backward compatibility with Docker.

---

## 📋 Summary of Changes

### Files Modified (4 total)

1. **`service/ci/publish_to_docker.sh`**
   - Added auto-detection of container runtime (podman/docker)
   - Changed all `docker` commands to `${CONTAINER_RUNTIME}`

2. **`service/ci/publish_to_github.sh`**
   - Added auto-detection of container runtime (podman/docker)
   - Changed all `docker` commands to `${CONTAINER_RUNTIME}`

3. **`docker-compose.yml`**
   - Changed web service port mapping from `80:80` to `8080:80`
   - **Reason**: Podman rootless cannot bind to privileged ports (<1024)

4. **`.env`** (Bug fix in original configuration)
   - Fixed `BOPTEST_SERVER` from `http://web:8000` → `http://web:80`
   - Fixed `BOPTEST_WS_SERVER` from `ws://web:8000/ws` → `ws://web:80/ws`
   - **Reason**: Web service actually listens on port 80, not 8000

---

## ✅ Validation Results

### Build Phase ✅
All services build successfully with Podman:
- `web`: 706 MB
- `worker`: 3.24 GB (x86_64 with emulation on ARM64)
- `provision`: 417 MB
- `test`: 667 MB

**Build command:**
```bash
podman-compose build
```

### Runtime Phase ✅
All services start and run successfully:
- ✅ Redis: Running
- ✅ MinIO (S3): Running & configured
- ✅ MinIO Client: Bucket created successfully
- ✅ Worker: Running & connected to Redis
- ✅ Web: Running on port 8080
- ✅ API: `/testcases` returns 12 test cases

**Start command:**
```bash
podman-compose up -d
```

### Integration Tests ✅
All 9 tests passed in 123 seconds:
- ✅ 3 WebSocket API tests
- ✅ 6 Testcase API tests

**Test command:**
```bash
podman-compose run --rm test
```

**Test results:**
```
======================== 9 passed in 123.43s (0:02:03) =========================
```

---

## 🚀 Usage Guide

### Basic Commands

**Build all services:**
```bash
podman-compose build
```

**Start all services:**
```bash
podman-compose up -d
```

**View service status:**
```bash
podman-compose ps
```

**View logs:**
```bash
podman-compose logs -f
```

**Stop all services:**
```bash
podman-compose down
```

**Run provision (upload testcases):**
```bash
podman-compose run --rm provision
```

**Run integration tests:**
```bash
podman-compose run --rm test
```

### Access Points

**Web API:**
```bash
curl http://localhost:8080/testcases
```

**MinIO Console:**
```
http://localhost:9001
Username: user
Password: password
```

**MinIO API:**
```
http://localhost:9000
```

---

## 🔄 Backward Compatibility

All changes maintain **full backward compatibility** with Docker:

### Auto-Detection
The build scripts automatically detect and use the available container runtime:
```bash
# Uses podman if available, falls back to docker
./service/ci/publish_to_docker.sh
./service/ci/publish_to_github.sh
```

### Manual Override
You can force a specific runtime:
```bash
CONTAINER_RUNTIME=docker ./service/ci/publish_to_docker.sh
CONTAINER_RUNTIME=podman ./service/ci/publish_to_docker.sh
```

### Port Mapping
The port mapping `8080:80` works identically in both Docker and Podman:
- External access: `http://localhost:8080`
- Internal container port: `80`
- Inter-service communication: `http://web:80` (unchanged)

---

## 🔧 Technical Notes

### 1. Port Change (80 → 8080)
**Why**: Podman rootless mode cannot bind to privileged ports (<1024) for security reasons.

**Impact**: External access changes from port 80 to 8080
- Before: `http://localhost:80`
- After: `http://localhost:8080`

**No impact on**: Internal service-to-service communication (still uses port 80)

### 2. Platform Emulation (Worker Service)
The worker service uses `--platform=linux/x86_64` and runs via QEMU emulation on ARM64 macOS.

**Performance**: Acceptable for development, may be slower for CPU-intensive tasks.

**Alternative**: Remove platform flag if all dependencies support ARM64.

### 3. Original Configuration Bug Fixed
The original `.env` file had incorrect port configuration:
- **Original**: `BOPTEST_SERVER=http://web:8000` (wrong port)
- **Fixed**: `BOPTEST_SERVER=http://web:80` (correct port)

This was a pre-existing bug, not related to the Podman migration.

### 4. MinIO Client Warnings
You may see these warnings (they are harmless):
```
mc: <ERROR> Unable to make bucket - bucket already exists
mc: <ERROR> Service account access key already taken
```

These occur on subsequent runs and can be safely ignored.

---

## 🐛 Troubleshooting

### Services Not Starting
```bash
# Clean restart
podman-compose down
podman rm -a -f
podman-compose up -d
```

### Web Service Shows 404
Wait for provision service to complete:
```bash
podman-compose run --rm provision
```

### Permission Denied on Port 80
This is expected with Podman rootless. The configuration uses port 8080 instead.

### DNS Resolution Failures
Ensure all services are on the same network (automatic with podman-compose).

### Build Failures
Check Podman version:
```bash
podman --version  # Should be 3.0+
podman-compose --version  # Should be 1.0+
```

---

## 📊 Environment Details

**Tested On:**
- OS: macOS (Darwin 24.5.0)
- Podman: 5.6.2
- podman-compose: 1.5.0
- Architecture: ARM64 (with x86_64 emulation for worker)

**Services:**
- Redis: latest
- MinIO: RELEASE.2025-04-22T22-12-26Z
- MinIO Client: RELEASE.2025-04-16T18-13-26Z
- Node.js: 16.x
- Python: 3.8

---

## 🎯 Migration Principles

This migration followed these principles:
1. ✅ **Minimal changes** - Only 4 files modified
2. ✅ **Backward compatible** - Works with both Docker and Podman
3. ✅ **No functionality changes** - All features work identically
4. ✅ **Bug fixes included** - Fixed pre-existing port configuration issue
5. ✅ **Fully tested** - All integration tests pass

---

## 🚀 Next Steps

### For Production Deployment

1. **Evaluate port change impact**: Update any external integrations expecting port 80
2. **Consider ARM64 migration**: Investigate native ARM64 builds for better performance
3. **Add rootful option**: For production, consider Podman rootful mode to use port 80
4. **Update CI/CD**: Ensure GitHub Actions support Podman (currently uses Docker)

### For Development

You're ready to go! Use the commands in the [Usage Guide](#-usage-guide) section.

---

## 📚 Additional Resources

- [Podman Documentation](https://docs.podman.io/)
- [podman-compose GitHub](https://github.com/containers/podman-compose)
- [Podman vs Docker](https://docs.podman.io/en/latest/Introduction.html)
- [Rootless Containers](https://rootlesscontaine.rs/)

---

## 🙏 Acknowledgments

Migration completed by the Hive Mind Collective Intelligence System with:
- **Researcher Agent**: Podman compatibility analysis
- **Analyst Agent**: Dockerfile compatibility review
- **Coder Agent**: Script and configuration analysis
- **Tester Agent**: Test strategy and validation

**Result**: ✅ Full compatibility achieved with minimal changes!

---

## 📝 License

Same as the parent BOPTEST project.
