# Object Storage

BOPTEST-Service depends on S3-compatible object storage for persisting uploaded test cases and the artifacts produced while a test is running. In production the deployment targets Amazon S3, while local development typically uses [MinIO](https://min.io). Object stores are flat, but BOPTEST encodes structure by introducing `/` delimiters in the object key.

## Bucket configuration

- `BOPTEST_S3_BUCKET` identifies the bucket used by both the web tier and the workers.
- `BOPTEST_INTERNAL_S3_URL` points the workers at the private endpoint (for example, the MinIO service running inside Docker Compose).
- `BOPTEST_PUBLIC_S3_URL`, when set, is prepended to pre-signed form responses so a browser uploads directly to the public endpoint.

## Test case files

Test cases are uploaded via a pre-signed POST form returned by the API. The form contains the object key that determines where the FMU will live in the bucket.

- Canonical IBPSA cases (shared with all users):
  ```
  testcases/ibpsa/<testcase_id>/<testcase_id>.fmu
  ```
- Additional shared namespaces (e.g. community or organizational contributions):
  ```
  testcases/<namespace>/<testcase_id>/<testcase_id>.fmu
  ```
- User-specific uploads (private by default):
  ```
  users/<user_sub>/testcases/<testcase_id>/<testcase_id>.fmu
  ```

When the client requests a shared upload, the web layer sets `acl=public-read` on the pre-signed form. MinIO ignores object level ACLs, but S3 honors them so shared artifacts become publicly readable.

## Test run artifacts

Two types of data are written back to the bucket as a test executes.

### Working directory archives

Once a worker finishes a test it compresses the entire working directory and uploads it to the bucket:

```
tests/<test_id>.tar.gz
```

The archive is tagged with the submitting user (`user=<oauth_sub>` or `unknown`) and the FMU key used for the run (`testcase=<testcase_key>`). Object tags allow downstream retention and clean-up policies to filter by user or by testcase.

### Result payload snapshots

Calls to `PUT /results/{testid}` request time-series data from the simulation. The worker packages the response into MessagePack and persists it before responding to the API caller. For small payloads (configurable via `BOPTEST_MAX_INLINE_RESULT_BYTES`, default `1,024,000` bytes) the worker skips persistence and streams the message directly back over the Redis pub/sub link to minimize latency for high-frequency polling. Larger snapshots than the threshold are written to object storage and referenced by pointer. Each persisted snapshot generates a unique key:

```
results/<test_id>/<uuid>.msgpack
```

The worker returns a pointer of the form `{ storage: "s3", bucket: <bucket>, key: <object_key> }`, and the web tier retrieves the object and streams it back to the client. The objects are stored with `ContentType=application/msgpack` so downstream tooling can decode them without guessing the format.
