# Redis

BOPTEST-Service currently uses Redis for two purposes.

1. Storing test metadata.
2. A pub/sub message bus to communicate with workers. 

## Test Metadata:

A hash under the key `tests:${testid}` is used to store test metadata.

| Key                                      | Field       | Value
| ---------------------------------------- | ----------- | -----------------------------
| `tests:${testid}`                        | `status`    | `Queued \| Running`
| `tests:${testid}`                        | `timestamp` | Epoch seconds when test is queued
| `tests:${testid}`                        | `user`      | The OAuth user "sub", or undefined for anonymous tests

Tests that are started by an authenticated user are stored in a set associated with the user.

| Key                                      |  Value
| ---------------------------------------- | -------------------------------------------
| `users:${userSub}:tests`                 | `[testid1, testid2, ...]`

## Pub/Sub Messages

See notes in `web/server/src/lib/messaging.js`.
